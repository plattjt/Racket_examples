#!/usr/bin/env racket

#lang at-exp rackjure
(require (planet murphy/protobuf)
		 dstorrs/utils
		 net/url
		 web-server/http/xexpr
		 web-server/dispatch
		 web-server/http/request-structs
		 "../biomantica/app/lib/proto/rkt/P2P.rkt"
		 "../biomantica/app/lib/authorize.rkt"
		 (for-syntax racket/syntax))

;(define nums '(1 2 3 4 5 6 7 8))
;(define h (hash 1 #t 4 #t 7 #t))
;
;
;(for ((n nums) #:when (hash-ref h n #f))
;	 (say n))

(define pbuf (file-list* #:collaboration-name "foobie collab"
						 #:file (list
								 (file-list:files* #:file-hash "hash1" #:file-path "path1")
								 (file-list:files* #:file-hash "hash2" #:file-path "path2")
								 (file-list:files* #:file-hash "hash3" #:file-path "path3")
								 (file-list:files* #:file-hash "hash4" #:file-path "path4"))))

(say "pbuf (outer file-list object) is:  " pbuf)

(define inner-messages (file-list-file pbuf))

(say "inner-messages is: " inner-messages)
(say "hashes are: " (map file-list:files-file-hash inner-messages))
