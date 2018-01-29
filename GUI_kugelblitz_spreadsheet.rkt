#lang racket

(require racket/gui
         dstorrs/utils
         "spreadsheet-editor/spreadsheet-editor.rkt")
; spreadsheet-editor is at https://github.com/kugelblitz/spreadsheet-editor

(define table-data (mutable-hash 0 (mutable-hash 0 "a" 1 "b" 2 "c")
                                 1 (mutable-hash 0 "d" 1 "e" 2 "f")
                                 2 (mutable-hash 0 "g" 1 "h" 2 "i")))


;(thread (thunk
         ;(say "entering thread")

(define frame (new frame% (label "Table")))

(define (set-cell x y val) (hash-set! (hash-ref table-data x) y val))

(define (get-cell x y) (hash-ref (hash-ref table-data x) y))

(define my-table (new spreadsheet-editor%
      (parent frame)
      (n-rows 3)
      (n-columns 3)
      (row-button-width 80)
      (editable? #t)
      (get-cell-contents get-cell)
      (set-cell-contents! set-cell)
      ))

(send frame resize 600 400)
(send frame show #t)
;(sleep 10)

;You need to use class-field-accessor to get a method from the class and
;then you can use them on the instance. 
(say (((class-field-accessor spreadsheet-editor% get-cell-contents) my-table) 0 1))


;(say "leaving thread")
;))

;(sleep 20)

(say "done")

;((send my-table get-cell-contents) 0 1)