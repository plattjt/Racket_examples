#lang racket

(require racket/gui
         mrlib/terminal)


(define/contract (dothis
                  e ;an eventspace
                  my-window
                  my-command
                  ;#:my-command [my-command "ls"]
                  )
  (-> eventspace? (or/c  (is-a?/c top-level-window<%>) #f) string? void?)
    (system my-command)
    (void)
)


(define a-terminal (in-terminal (curryr dothis "ls -lh")))

;(if (send a-terminal is-closed?)
;    (println "Terminal is closed.")
;    (println "Terminal is open.")
;    )


;(dothis (make-eventspace) #f #:my-command "ls -l")