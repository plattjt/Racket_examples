#!/usr/bin/env racket

#lang at-exp rackjure

;call/cc allows you to set break points in your code.
; This is useful when you want to have a function stop processing 
; and exit under specified conditions.
(define (example-function condition-variable)
  (call/cc
   (lambda (return)
     (when (equal? condition-variable "stop at first case")
       (return "First case.")
       )
     
     (when (equal? condition-variable "stop at second case")
       (return "Second case.")
       )
     "Reached the end of the function." ;The final return value has to be inside the lambda.
    )
   )
)

(displayln "Call function with first case:")
(example-function "stop at first case")

(displayln "Call function with second case:")
(example-function "stop at second case")

(displayln "Call function with neither case:")
(example-function "dont stop")

