#lang racket

(define  (fac n)
               (let ((x (round n)))
                 (if (even?  x)
                     (displayln (+ x 1))
                     (displayln (- x 1))
                     ))
               (displayln n)
               )
(fac 6)
(fac 0)
(fac -1)
(fac 1.5)