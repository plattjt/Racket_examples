#!/usr/bin/env racket
#lang at-exp rackjure

(require db)
(define (make-connect)
  (postgresql-connect
                #:user "postgres"
 		#:database "biomantica"
 		#:password "foobar"))

(define/contract (dbh)
  (-> connection?)
  (make-connect))

(define db (dbh))

(define list-of-vals (list "hash-529" "hash-242" "hash-3949"))
(make-placeholder list-of-vals)
;Build an IN sub-clause for a list of values.
(query-rows db
          @{delete from chunks
            where hash in (@(placeholder-set! in-clause list-of-vals))}
          list-of-vals)

;Returns "$1,$2,$3" if given a list of 3 elements