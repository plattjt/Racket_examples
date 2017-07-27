#lang racket

(require setup/dirs)


(displayln "\nMain packeges directory:")
(find-pkgs-dir)

(displayln "\nUser packeges directory:")
(find-user-pkgs-dir)
