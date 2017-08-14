#lang racket
(require racket/gui)

;;This example uses code from
;;The Racket Graphical Interface Toolkit Version 6.10.0.1
;;Matthew Flatt, Robert Bruce Findler, and John Clements July 27, 2017
;page 6-7. 

; Make a frame by instantiating the frame% class
  (define frame (new frame% [label "Example"]))
  ; Show the frame by calling its show method
  (send frame show #t)

(define msg (new message% [parent frame]
                            [label "No events so far..."]))

; Make a button in the frame
  (new button% [parent frame]
               [label "Click Me"]
               ; Callback procedure for a button click:
               [callback (lambda (button event)
                           (send msg set-label "Button click"))])
  ; Show the frame by calling its show method
  (send frame show #t)


;;Page 7 - this code requires the frame and msg definition from page 6.
;;On macOS, you have to click in the canvas before it has focus and will respond to
;; keyboard events.  It will, however, respond to mouse movement even when it does
;; not have Focus.  Hovering the mouse over the canvas is not enough to give it
;; focus and allow it to respond to the keyboard.
; Derive a new canvas (a drawing window) class to handle events
  (define my-canvas%
    (class canvas% ; The base class is canvas%
      ; Define overriding method to handle mouse events
      (define/override (on-event event)
        (send msg set-label "Canvas mouse"))
      ; Define overriding method to handle keyboard events
      (define/override (on-char event)
        (send msg set-label "Canvas keyboard"))
      ; Call the superclass init, passing on all init args
      (super-new)))
  ; Make a canvas that handles events in the frame
  (new my-canvas% [parent frame])


  (new button% [parent frame]
               [label "Pause"]
               [callback (lambda (button event)
                           (send msg set-label "Before pause")
                           (sleep 5)
                           (send msg set-label "After pause"))])
;When you click this button, there will be a 5 second delay then the label changes.


(define panel (new horizontal-panel% [parent frame]))
  (new button% [parent panel]
               [label "Left"]
               [callback (lambda (button event)
                           (send msg set-label "Left click"))])
  (new button% [parent panel]
               [label "Right"]
               [callback (lambda (button event)
                           (send msg set-label "Right click"))])

