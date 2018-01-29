#lang racket

(require racket/gui
         mrlib/terminal)



(define (command-term
         my-command
         #:container [cont #f]
         #:event_space [e #f]
         )

  (in-terminal
   (lambda (e foo)
     (system  my-command)
     (void)
     )
   #:container cont
   )
  )

(define a-terminal (command-term "ls"))

(if (send a-terminal is-closed?)
    (println "Terminal is closed.")
    (println "Terminal is open.")
    )