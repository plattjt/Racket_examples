#lang racket

(require racket/gui
         ;framework
         rackterm/private/terminal-canvas
         rackterm/private/term-key-event
         ;dstorrs/utils
         )



(define font-size (make-parameter 12))
(define font-name (make-parameter "use first fallback"))
(define command (make-parameter #f))
(define term-var (make-parameter "rackterm"))

(define xterm-frame%
  (class frame%
    (init-field
     [handling-keymap
      (make-keymap (key 'control #\G) (lambda _ (send this add-canvas))
                   (key 'control #\N) (lambda _ (send this focus-next))
                   )])

    (define current-keymap handling-keymap)
    (define/public (set-current-keymap kmap)
      (set! current-keymap kmap))
    (define/override (on-subwindow-char receiver event)
      (define key-ev (map-char-event-to-term-key-event event))
      (define handler (get-handler-for-keymap current-keymap key-ev (λ _ 'pass-through)))
      (cond [(dict? handler) (begin
                                   (set! current-keymap handler)
                                   #t)]
            ;; if the handler returns 'pass-through, let control pass through to the child
            [handler (begin
                       (set! current-keymap handling-keymap)
                       (define ret (handler key-ev))
                       (not (equal? ret 'pass-through)))]
            ;; if handler is #f but the keymap was not the default, eat the key (don't pass it)
            [(not (equal? current-keymap handling-keymap)) #t]
            ;; otherwise just let the kids handle it.
            [else #f]))

    (define/public (add-canvas)
      (let ((c (new terminal-canvas%
                    [parent this]
                    [font-size (font-size)]
                    [font-name (font-name)]
                    [term-var (term-var)]
                    [command-and-args '("ls -lah")]
                    [set-title-callback (lambda (title) (send this set-label title))]
                    [horiz-margin 2]
                    [vert-margin 2]
                    )))
        (send c focus)
        c))
    (define/public (focus-next)
      (let* ((children (send this get-children))
             (focused-child (memf (lambda (c) (send c has-focus?)) children))
             (next-child (if focused-child (cdr focused-child) #f)) 
             (to-focus (if (or (null? next-child) (not next-child))
                           (car children)
                           (car next-child))))
        (send to-focus focus)))

    (super-new)))


(define frame (new xterm-frame% [label "Example"]
                   (width 800)
                   (height 800)
                   ))

;
;(define my-term (new terminal-canvas%
;                    [parent frame]
;                    [font-size 16]
;                    [font-name "Courier"]
;                    [term-var "rackterm"]
;                    [command-and-args '("ls -lah")]
;                    [set-title-callback (lambda (title) (send frame set-label title))]
;                    [horiz-margin 2]
;                    [vert-margin 2]
;                     ))

(send frame show #t)
(send frame add-canvas)
