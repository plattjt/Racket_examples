#lang racket

(define (fac n)
  (cond
    [(not (integer? n)) 1]
    [(<= n 0) 1]
    [(equal? n 1) n]
    (else (* n (fac (- n 1))))
    )
  )

; Create tests first and then write and rewrite the function above to pass all tests.
(map fac '(0 -2 3.14 3+2i 1 2 9))


