#lang racket

(require racket/gui
         mrlib/terminal)


(define doit
  (lambda
      (e foo)
    (system  "ls")
    (void)
      )
  )


(in-terminal doit)
