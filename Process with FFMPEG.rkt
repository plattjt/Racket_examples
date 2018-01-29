#lang racket

(require racket/gui
         framework
         mrlib/terminal
         dstorrs/utils
         )

;Wrap MrLib Terminal in a function to make it simpler to call
;within the callback of a GUI element.
(define/contract (command-term
         my-command
         #:container [cont #f]
         #:event_space [e #f]
         )
  (->* (string?)
       (#:container (or/c #f (is-a?/c area-container<%>))
        #:event_space (-> or/c #f eventspace?))
        (is-a?/c terminal<%>))
  (in-terminal
   (lambda (e foo)
     (system  my-command)
     (void)
     )
   #:container cont
   #:abort-label "Cancel" ;For some reason the default is "Abort Instillation"
   #:aborted-message "Canceled"
   #:cleanup-thunk (thunk (send msg set-label "Finished"));cleanup-thunk runs when the command finishes running.
   );This returns a terminal<%> object.
  )

(define frame (new frame%
                     [label "Audio and Video Converter"]
                     [width 1600] 
                     [height 2000]))
;This is set very large but should shrink to accomodate the screen size available.
;It does on macOS, need to test on Linux.
;I like that better as a default than the user always having to expand or maximize
;from a small default window size.


(define msg (new message% [parent frame]
                            [label "Not running..."]))

;Display the selected file in a text field.
(define working-file (new text-field%
                          (parent frame)
                          (label "File")
                          (enabled #t);Setting this to #f prevents the user from editing the field.
                          (init-value "/Temp/")))

;You have to extract the editor from a text-field% in order to get
;an object to which you can send a string to to change the contents of the field.
(define file-text-field (send working-file get-editor))

;;  stretchable-height and stretchable-width
;#t = default to max height or width,
;#f = use min hight or width which will contain the child elements.
;<integer> = stretch to maximum but not less than <integer>

(define out-format-panel (new horizontal-panel% [parent frame]
                                       [alignment '(center top)]
                                       [stretchable-height #f] 
                                       ))

;;;;$$$$$$ Select whether to output audio, video or both.
(define av-out-box-panel (new group-box-panel%  ;This is just for visual separation from other GUI items.
                             (parent out-format-panel)
                             (label "Include in output:")
                             (stretchable-width #f)
                             ))
(define av-out-options (list
                        "both audio and video" ;The first item is selected by default in a radio-box%.
                        "audio only"
                        "video only"))
;Both audio and video - default
;Audio only - e.g. you are extracting from a video to export to an audio only player.
;video only - e.g you are going to redo the audio track later.
(define av-or-both-out (new radio-box%
                       (label " ")
                       (parent av-out-box-panel) ;out-format-panel)
                       (choices av-out-options)
                       ))
;;;;$$$$$$ Select whether to output audio, video or both - done.


;The list of menu choices needs to be defined because the get-selection
;method returns an index.  
(define extensions (list "mp4" "m4a" "mp3"))

;Need to defne a panel so that GUI items can be ordered and arranged as a group.
(define output-choice (new choice%
                           (label "Output format:")
                           (parent out-format-panel)
                           (choices extensions)
                           (selection 0)

     ))

(define (build-command
         #:filepath [filepath (send working-file get-value)]
         #:new-extension [new-extension (list-ref extensions (send output-choice get-selection))]
         #:av-out-select [av-out-select  (list-ref av-out-options (send av-or-both-out get-selection))] ;Should the output be audio only?
         )
  (define output-name (~a filepath new-extension))

  ;(say "-" av-out-select "-")
      (define in-out-separator (case av-out-select
                                 [("both audio and video") "\" \""]
                                 [("audio only") "\" -vn \""]  ; -vn is no video.
                                 [("video only") "\" -an \""]  ; -an is no audio.
                                 ))
  ;Don't try to use "'" for quotations around a filename because file names can contain this character.
  (~a "time /usr/local/bin/ffmpeg -i \"" filepath in-out-separator filepath "." new-extension "\"")
  )

(define command-display (new text-field%
                          (parent frame)
                          (label "Command")
                          (enabled #t);Setting this to #f prevents the user from editing the field.
                          ;(init-value "")
                          ))

;You have to extract the editor from a text-field% in order to get
;an object that you to send text to to change the contents of the field.
(define command-display-ed (send command-display get-editor))

(new button% [parent frame]
             [label "Run"]
             ; Callback procedure for a button click:
             [callback (lambda (button event)
                         (send command-display-ed insert (build-command));For now (build-command) is called twice because in-terminal needs a function as a parameter.
                         (define terminal-area
                           (command-term (build-command) #:container frame))
                         (send msg set-label "Running...")
                         )])


(define menu-bar (new menu-bar%
                      (parent frame)))

(define file-menu (new menu%
     (label "&File")
     (parent menu-bar)))

;(define help-menu (new menu%
;     (label "&Help")
;     (parent menu-bar)))

;;Callbacks for a menu-item should be of the form (callback (lambda (menu-item event) <code>))
(new menu-item%
     (label "Open")
     (parent file-menu)
     (shortcut #\o)
     ;(shortcut-prefix 'cmd)
     ;(callback (lambda (x y) x))
     (callback (lambda (menu-item event)
                 (send file-text-field erase);Erase the default text.
                 (send file-text-field insert (path->string (finder:get-file)))
               )
      )
     )
(new menu-item%
     (label "Close Window")
     (parent file-menu)
     (shortcut #\w)
     ;(callback (lambda (x y) x))
     (callback (lambda (menu-item event) (send frame on-exit)))
     ;You can close a window by sending it on-exit.  Is this the preferred method?
     )

(send frame show #t)
;(send out-format-frame show #t)

;(if (send terminal-area is-closed?)
;    (say "terminal is closed")
;    (say "terminal is open"))

;(message-box "Output Selection"
;             (list-ref extensions (send output-choice get-selection))
;             #f)