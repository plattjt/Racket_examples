#lang racket

(require dstorrs/utils)

;Transpose a list of lists

(define lol1 (list (list "1" "2" "3")
                   (list "4" "5" "6")
                   (list "6" "8" "9")))

(say lol1)

;lol = list of lists
;il = inner list


(define (transpose_lol lol)
  (for/list ((i (length (list-ref lol 0))))
    (for/list ((il lol))
      (list-ref il i))))


(say (transpose_lol lol1))