#lang racket

(provide square
         blankSquare)

 
(define (square)
  (let ((level 1)(color "green")(size 1))
      (define (getLevel)
    level)
  (define (levelUp)
    (begin (set! level (+ 1 level))
           level)
    )
    (define (changeColor newColor)
    (begin (set! color newColor)
           color)
    )
    (define (changeSize newSize)
    (begin (set! size newSize)
           size)
    )
    (define (getColor)
    color)
    (define (getSize)
    size)

    
  (define (dispatch m)
        (cond ((eq? m 'levelUp) levelUp)
              ((eq? m 'getLevel) getLevel)
              ((eq? m 'getColor) getColor)
              ((eq? m 'getSize) getSize)
              ((eq? m 'changeColor) changeColor)
              ((eq? m 'changeSize) changeSize)
              (else (error "Unknown request: "  m))))
dispatch))

;;Create a blank square that will error gracefully when used
(define (blankSquare)
  (define (dispatch m)
        (lambda () (begin (display "\nThis is not a square") -1)))
dispatch)
