#!/usr/bin/env racket

#lang at-exp rackjure

;Basic string related functions

(define a-string "This is a string.")

(displayln a-string)

;the function string-append is multivariatic.
(string-append a-string " Add some" " more" " to the string.")

;(displayln a-string)

;Show the first to fourth character of the string:
;The second parameter (after the string, itself) is the place to start
;The third parmaeter is the length of the string to return.
(substring a-string 0 4)

;If you do not specify a string length it will not stop and return all of the string after the starting point.
(substring a-string 2)