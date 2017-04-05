#lang racket

(provide square)

 
(define (square)
  (let ((level 1))
  (define (levelUp)
    ;;Find another way besides set! to do this
    (set! level (+ 1 level))
    )
  (define (getLevel)
    level)
  (define (dispatch m)
        (cond ((eq? m 'levelUp) levelUp)
              ((eq? m 'getLevel) getLevel)
              (else (error "Unknown request: "  m))))
dispatch))