#lang racket/base

;;==========================================================================
;;===                Code generated with MrEd Designer 3.16              ===
;;===              https://github.com/Metaxal/MrEd-Designer              ===
;;==========================================================================

;;; Call (project-39158-init) with optional arguments to this module

(require
 racket/gui/base
 racket/class
 racket/list
 )

(provide project-39158-init frame-39210)

(define (label-bitmap-proc l)
  (let ((label (first l)) (image? (second l)) (file (third l)))
    (or (and image?
             (or (and file
                      (let ((bmp (make-object bitmap% file 'unknown/mask)))
                        (and (send bmp ok?) bmp)))
                 "<Bad Image>"))
        label)))

(define (list->font l)
  (with-handlers
   ((exn:fail?
     (λ (e)
       (send/apply
        the-font-list
        find-or-create-font
        (cons (first l) (rest (rest l)))))))
   (send/apply the-font-list find-or-create-font l)))

(define project-39158 #f)
(define frame-39210 #f)
(define button-39427 #f)
(define (project-39158-init
         #:button-39427-callback
         (button-39427-callback (lambda (button control-event) (void))))
  (set! frame-39210
    (new
     frame%
     (parent project-39158)
     (label "Frame")
     (width #f)
     (height #f)
     (x #f)
     (y #f)
     (style '())
     (enabled #t)
     (border 0)
     (spacing 0)
     (alignment (list 'center 'top))
     (min-width 70)
     (min-height 30)
     (stretchable-width #t)
     (stretchable-height #t)))
  (set! button-39427
    (new
     button%
     (parent frame-39210)
     (label (label-bitmap-proc (list "Button" #f #f)))
     (callback button-39427-callback)
     (style '())
     (font (list->font (list 8 'default 'normal 'normal #f 'default #f)))
     (enabled #t)
     (vert-margin 2)
     (horiz-margin 2)
     (min-width 0)
     (min-height 0)
     (stretchable-width #f)
     (stretchable-height #f)))
  (send frame-39210 show #t))

(module+ main (project-39158-init))
