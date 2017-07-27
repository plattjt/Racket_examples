#lang racket
(require racket/gui)

(define my-choices (list "red" "green" "blue"))


(define item-selector (new frame% [label "select item"]))


  (define item-selector-input (new combo-field%
                        (label "item")
                        (parent item-selector)
                        (choices my-choices)))

 
; Make a button in the frame

(new button% [parent item-selector]
             [label "ok"]
             ; Callback procedure for a button click:
             [callback (lambda (button event)
                         (send item-selector-input get-value))])
(send item-selector show #t)
(send item-selector-input get-seection)



(define item-chosen (send item-selector-input get-value))

item-chosen

;(define item-chosen (get-field item-selector-item-selector-input))
  
;(message-box "Text Answer"
;             item-chosen
;             #f)