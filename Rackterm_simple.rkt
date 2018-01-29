#lang racket


(require racket/gui
         rackterm/private/terminal-canvas-persistent
         racket/system
         racket/runtime-path
         )

  (define-runtime-path terminfo-file "/Users/fingal/Library/Racket/6.10/pkgs/rackterm/rackterm/rackterm.terminfo")
    (system* (find-executable-path "tic") "-x" (path->string terminfo-file))

(define frame (new frame% [label "Example"]
                   (width 800)
                   (height 800)
                   ))

(send frame show #t)

(define my-term (new terminal-canvas-persistent%
                    [parent frame]
                    [font-size 14]
                    [font-name "Courier"]
                    [term-var "rackterm"]
                    [command-and-args '("ls" "-lh")]
                    [set-title-callback (lambda (title) (send frame set-label title))]
                    [horiz-margin 2]
                    [vert-margin 2]
                     ))

;(let ((my-term (new terminal-canvas%
;                     (parent frame)
;                     )))
;  (send my-term focus)
;  )
  

;(let loop () (println 1) (loop))