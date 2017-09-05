#lang racket


(require racket/gui
         rackterm/private/terminal-canvas
         )


(define frame (new frame% [label "Example"]
                   (width 800)
                   (height 800)
                   ))

(send frame show #t)

(define my-term (new terminal-canvas%
                    [parent frame]
                    [font-size 14]
                    [font-name "Courier"]
                    [term-var "rackterm"]
                    [command-and-args '("ls -lh")]
                    [set-title-callback (lambda (title) (send frame set-label title))]
                    [horiz-margin 2]
                    [vert-margin 2]
                     ))