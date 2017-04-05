#lang racket

(provide square
         blankSquare)

 
(define (square)
  (let ((level 1))
      (define (getLevel)
    level)
  (define (levelUp)
    ;;Find another way besides set! to do this
    (begin (set! level (+ 1 level))
           level)
    )

  (define (dispatch m)
        (cond ((eq? m 'levelUp) levelUp)
              ((eq? m 'getLevel) getLevel)
              (else (error "Unknown request: "  m))))
dispatch))

;;Create a blank square that will error gracefully when used
(define (blankSquare)
  (define (dispatch m)
        (lambda () (begin (display "\nThis is not a square") -1)))
dispatch)
