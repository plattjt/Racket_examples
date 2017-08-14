#lang racket
(require racket/gui)

(define frame (new frame%
                     [label "Example"]
                     [width 300]
                     [height 300]))

;;In order to actually use the set-canvas-background method, you have to save the canvas
;;in a variable so you can pass it the method.
(define my-new-canvas (new canvas% [parent frame]
               [paint-callback
                (lambda (canvas dc)
                  (send dc set-scale 3 3)
                  (send dc set-text-foreground "blue")
                  (send dc draw-text "Don't Panic!" 0 0))]))

;;
(send my-new-canvas set-canvas-background
      (make-object color% "yellow") ; The method takes an object for an argument
      ;so you have to create a collor object.  You can do this by keyword
      ;or by supplying byte arguments for red green and blue.
      )

(send frame show #t)

