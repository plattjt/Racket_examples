#lang racket

(require racket/gui)

;This code is from:
;https://stackoverflow.com/questions/37583997/basic-code-editor-functionality-in-racket

;With this I have set the font and its size to an agreeable one, and copy and paste operations, etc. work. But there's a lot of unexpected behaviors, such as:
;
;    Pressing modifier+letter key combinations still inserts the letter instead of ignoring it.
;    Pressing alt+left or cmd+left (Mac user) will move the caret a single character instead of a word or to the margin.
;    Double-clicking won't select a word.


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
                ;[callback (λ (mi e) (update (send text get-text)))] ;This is the actual code
                ;from Stack Overflow but it causes an error "update: unbound identifier in module in: update"
                [callback (λ (mi e) #t)];Just change the return to #t so this code will run.
                [shortcut #\R]
                [shortcut-prefix '(cmd)])
(append-editor-operation-menu-items edit-menu #f)

(define delta (make-object style-delta% 'change-size 14))
(send delta set-face "Menlo")
(send text change-style delta)
