#!/usr/bin/env racket

#lang at-exp rackjure

;Basic use of the cond function


;(define cond-variable "a string")
;(define cond-variable "another string")
;(define cond-variable "yet another string")
;(define cond-variable 3)
(define cond-variable #f)


(cond
  [(equal? cond-variable "a string")  (displayln "The variable is 'a string'.")]
  [(equal? cond-variable "another string")  (displayln "The variable is 'another string'.")]
  [(string? cond-variable) (displayln "The variable is a string type but neither of the above.")]
  [cond-variable (displayln "The variable has been set but it is not a string type.")]
  [else  (displayln "None of the above.")]
  )

;It is not actually necessary to use square brackets as done above.
;Bracket types are interchangable but must be matched to the same type.

;;Next: show the use of begin inside a cond