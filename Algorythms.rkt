#lang racket

(require "Objects.rkt")

;;Create initial array of 0's
(define (createArray x y)
  (define (createArrayX countx x y)
    (define (createArrayY county x y)
      (if (> county y) '()
          (cons 0 (createArrayY (+ county 1) x y))))
    (if (> countx x) '()
        (cons (createArrayY 1 x y) (createArrayX (+ countx 1) x y)))
    )
  (createArrayX 1 x y))
 
;;Add Square
(define (addSquare grid x y)
  (define (goToArrayX grid countx x y)
    (define (goToArrayY grid county x y)
      (cond ((= county y) (cons square (cdr grid)))
            ((eq? grid '()) (display "Coordinates outside of grid"))
          (else (cons (car grid) (goToArrayY (cdr grid) (+ county 1) x y)))))
    (cond ((= countx x) (cons (goToArrayY (car grid) 1 x y) (cdr grid)))
          ((eq? grid '()) (display "Coordinates ourside of grid"))
        (else(cons (car grid) (goToArrayX (cdr grid) (+ countx 1) x y))))
    )
  (goToArrayX grid 1 x y))

;;Get Square
(define (getSquare grid x y)
  (define (goToArrayX grid countx x y)
    (define (goToArrayY grid county x y)
      (cond ((eq? grid '()) (display "Coordinates outside of grid"))
            ((= county y) ((car grid)))
          (else (goToArrayY (cdr grid) (+ county 1) x y))))
    (cond ((eq? grid '()) (display "Coordinates ourside of grid"))
      ((= countx x) (goToArrayY (car grid) 1 x y))  
        (else (goToArrayX (cdr grid) (+ countx 1) x y))))
  (goToArrayX grid 1 x y))