#lang racket

(require racket/gui)
;
;(define panel (new horizontal-panel% [parent frame]))
;  (new button% [parent panel]
;               [label "Left"]
;               [callback (lambda (button event)
;                           (send msg set-label "Left click"))])
;  (new button% [parent panel]
;               [label "Right"]
;               [callback (lambda (button event)
;(send msg set-label "Right click"))])

(define frame (new frame% [label "Simple Edit"]
                          [width 800]
                          [height 800]))
(define canvas (new editor-canvas% [parent frame]))
(define text (new text%))
(send canvas set-editor text)
(send frame show #t)

(define menu-bar (new menu-bar% [parent frame]))
(define edit-menu (new menu% [label "Edit"] [parent menu-bar]))
(define execution-menu (new menu% [label "Execution"] [parent menu-bar]))
(new menu-item% [label "Run"]
                [parent execution-menu]
                [callback (λ (mi e) #t)]
                [shortcut #\R]
                [shortcut-prefix '(cmd)])
(append-editor-operation-menu-items edit-menu #f)

(define delta (make-object style-delta% 'change-size 14))
(send delta set-face "Menlo")
(send text change-style delta)
