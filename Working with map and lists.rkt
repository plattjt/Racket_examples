#lang racket

; Map is a function which works with lists but it will process as many lists as you give it.


(for ((f (list + * /))) ;Use these different operators going through the lists.
  (map (lambda (l) (displayln (apply f l)))
       (map list
            '(1 2 3)
            '(7 9 5)
            '(10 20 30))))

; + is really a sum operator.  Similarly, * and / are really iterative operators as well.
; Therefore, you get column sums, column iterated products and column iterated division.