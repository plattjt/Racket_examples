#lang racket

(require racket/gui
         framework)

(define (open-file)
  (finder:get-file))

(define frame (new frame%
                     [label "Example"]
                     [width 600]
                     [height 300]))


(define menu-bar (new menu-bar%
                      (parent frame)))
(define file-menu (new menu%
     (label "&File")
     (parent menu-bar)))

(define edit-menu (new menu%
     (label "&Edit")
     (parent menu-bar)))

(define help-menu (new menu%
     (label "&Help")
     (parent menu-bar)))

;;Callbacks for a menu-item should be of the form (callback (lambda (menu-item event) <code>))
(new menu-item%
     (label "Open")
     (parent file-menu)
     ;(callback (lambda (x y) x))
     (callback (lambda (menu-item event)
                 (message-box "you selected" (path->string (open-file)) #f)))
     )
(new menu-item%
     (label "Do thing 2")
     (parent file-menu)
     ;(callback (lambda (x y) x))
     (callback (lambda (menu-item event) (message-box "you selected" "Thing 2" #f)))
     )
(new menu-item%
     (label "Close Window")
     (parent file-menu)
     ;(callback (lambda (x y) x))
     (callback (lambda (menu-item event) (send frame on-exit)))
     ;You can close a window by sending it on-exit.  Is this the preferred method?
     )


;(send menu-bar enable #t)
(send frame show #t)