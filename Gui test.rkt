#lang racket
(require racket/gui/base)

(define frame (new frame% [label "Example"]))
(send frame show #t)

(define input-x (new text-field%
                        (label "X")
                        (parent frame)
                        (init-value "Field")))
