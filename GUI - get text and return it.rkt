#lang racket
;; GUI version
(require racket/gui)


(define answer-text
  (get-text-from-user "Text Input" ;Title of the dialog box
                      "Input some text." ;message to the user
                      #f) ; Graphical element which this dialog box is to be added to as a child.
  )

(message-box "Text Answer"
             answer-text
             #f) ; Graphical element which this dialog box is to be added to as a child.



 