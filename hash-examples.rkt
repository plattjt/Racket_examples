#!/usr/bin/env racket

#lang at-exp rackjure

;Define a hash literal
(define a-hash
  (hash "a-boolean" #t
      "an-int" 3
      "a-string" "this is a string"
      "a-list" '("item one" "item two")
      )
  )

(displayln a-hash)

(displayln "\n")

;Pull a specific value out of a hash
(displayln (hash-ref a-hash "a-string"))
