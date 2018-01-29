#lang racket

(require racket/gui
         framework
         dstorrs/utils)

(define (open-file)
  (finder:get-file))

(define (pathparts
          my-path)
   (define-values (basepath the-file) (dir-and-filename my-path))
   (string-append (path->string basepath) " is the parent path\n and " (path->string the-file) "is the file.")
   )


(define frame (new frame%
                     [label "Example"]
                     [width 600]
                     [height 300]))


(define menu-bar (new menu-bar%
                      (parent frame)))
(define file-menu (new menu%
     (label "&File")
     (parent menu-bar)))

;;Callbacks for a menu-item should be of the form (callback (lambda (menu-item event) <code>))
(new menu-item%
     (label "Open")
     (parent file-menu)
     ;(callback (lambda (x y) x))
     (callback (lambda (menu-item event)
                 (message-box "you selected" (pathparts (open-file)) #f)))
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