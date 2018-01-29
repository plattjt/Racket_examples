
#lang racket

(define my-list '(a big dog))

; There is a list->string function in Racket base.
; This function is only for lists of characters.
; This file, however, deals with putting together lists of strings.

;; the easy way (has parens):
;(~a my-list)

 (string-join (map ~a my-list) "','")

;; For an SQL IN clause:
(string-append "'" (string-join (map ~a my-list) "','") "'")