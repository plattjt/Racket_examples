#lang racket/gui
 
;  Table panel example.
;  This example displays a table panel containing four more
;  table panels and demonstrates some column and row stretch-
;  ability options.
 
(require table-panel)
 
;  The top-level frame
(define frame
  (instantiate frame%
    ("Test")))
 

(define table-panel (instantiate table-panel%
    (frame)
    (alignment '(left top))
    (style '(border))
    ;(border 500)
    (column-stretchability #t)
    (row-stretchability #t)
    (dimensions '(2 2))
    ))


(define row1-column1 (instantiate table-panel%
  (table-panel)
   (alignment '(left top))
    (style '(border))
    ;(border 500)
    (column-stretchability #t)
    (row-stretchability #t)
    (dimensions '(1 1))
))

                       
   (new message%
       (parent row1-column1)
       (label "row 1, column 1")
       (stretchable-width #t)
       (stretchable-height #t)
       (auto-resize #t)
       )

   (new message%
       (parent table-panel)
       (label "row 1, column 2")
       (stretchable-width #t)
       (stretchable-height #t)
       (auto-resize #t)
       )
   
   (new message%
       (parent table-panel)
       (label "row 2, column 1")
       (stretchable-width #t)
       (stretchable-height #t)
       (auto-resize #t)
       )

   (new message%
       (parent table-panel)
       (label "row 2, column 2")
       (stretchable-width #t)
       (stretchable-height #t)
       (auto-resize #t)
       )
 
;  Show the top-level frame.
(send frame show #t)