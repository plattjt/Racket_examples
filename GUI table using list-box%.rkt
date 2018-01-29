#lang racket
(require racket/gui/base)

;This example code is from:
;https://stackoverflow.com/questions/16646910/gui-table-using-in-racket-variable-parameters-using-list-box
;Table data comes in the form of a list of lists plus a list of column headers.

(define frame (new frame% 
                  [label "myTable"]
                  [width 800]
                  [height 600]
                  ))

(define table (new list-box%
                 [parent frame]
                 [choices (list )]
                 [label "Test"]
                 [style (list 'single 'column-headers 'variable-columns)]
                 [columns (list "C1" "C2" "C3")]))

(define data (list (list "1" "2" "3")
                   (list "4" "5" "6")
                   (list "6" "8" "9")))


(send/apply table set data)


(send frame show #t)