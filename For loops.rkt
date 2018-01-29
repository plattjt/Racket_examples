#lang racket


;For iterates through a series, which is a list.
(for ([i '(0 1 2 3 4)])
  (printf (string-join (list "item" (number->string i) "\n")))
  )

(printf "\n")

;An exact positive integer is considered to be a series for this purpose.
;It has a number of elements equal to the integer, however keep in mind
;that it starts counting with 0.  So 5 = '(0 1 2 3 4).
(for ([i 5])
  (printf (string-join (list "item" (number->string i) "\n")))
  )
