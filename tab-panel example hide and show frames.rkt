#lang racket

(require racket/gui)

;outside container to hold the tab-panel
(define frame (new frame% [label "Info"]
                   [min-width 400]
                   [min-height 200]
                   ))

(define members "Alice, Bob")
(define files "file1, file2")

;A tab-panel is a container but the individual tabs are not.
;You use a callback from each tab to fill the container
; with the information that should represent each tab.
; You have to have to keep in mind that any objects created
; by the callback will persist until deleted.  So they will
; accumulate each time you click back and forth between tabs.
;If, on the other hand, you create multiple objects for alternate
; versions of the content (e.g. one for each tab), with the
; idea of hiding and showing them, they will be laid out
; when created and not when hidden or shown.
;The approach used in this code is to get the existing children
; of the tab-panel and delete them each time before replacing
; them.
;An alternate approach might be to use the place-children method
; each time a tab is clicked to change the order of the layout
; and also hide and show the alternate content.


(define/contract (fill-tab-panel-with-message
                  working-tab-panel
                  message-text)
  (-> (is-a?/c tab-panel%) string? any)

  ;Delete all existing children of the panel
  ;This has to be done in order for space to be laid out correctly
  ;because all existing children are taking up space.
  (for ([this-child (send working-tab-panel get-children)])
    (send working-tab-panel delete-child this-child)
    )

  (new message%
       (parent working-tab-panel)
       (label message-text)
       (stretchable-width #t)
       (stretchable-height #t)
       (auto-resize #t)
       )

  )


(define details-panel (new tab-panel%
                           (parent frame)
                           (choices (list "Members" "Files"))
                           (callback (lambda (b e)
                                         (case (send details-panel get-selection)
                                           ((0) (fill-tab-panel-with-message details-panel members))
                                           ((1) (fill-tab-panel-with-message details-panel files))
                                           (else (fill-tab-panel-with-message details-panel "no information"))
                                       )))
                           ))

(fill-tab-panel-with-message details-panel members);Set the default contents of the tab-panel

(send frame show #t)
