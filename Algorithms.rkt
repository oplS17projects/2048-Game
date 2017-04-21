#lang racket

(require "Objects.rkt")

;;Create initial array of -1's
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
      (cond ((= county y) (cons (square) (cdr grid)))
            ((eq? grid '()) (display "Coordinates outside of grid"))
          (else (cons (car grid) (goToArrayY (cdr grid) (+ county 1) x y)))))
    (cond ((= countx x) (cons (goToArrayY (car grid) 1 x y) (cdr grid)))
          ((eq? grid '()) (display "Coordinates outside of grid"))
        (else(cons (car grid) (goToArrayX (cdr grid) (+ countx 1) x y))))
    )
  (goToArrayX grid 1 x y))

;;Get Square
(define (getSquare grid x y)
  (define (goToArrayX grid countx x y)
    (define (goToArrayY grid county x y)
      (cond ((eq? grid '()) (display "Coordinates outside of grid"))
            ((= county y)
             (if (square? (car grid)) (car grid)
                 ;;Send back a blank square to prevent hard errors from closing the program
                 (begin
                   ;;(display "No square at: (")
                   ;;(display x)
                   ;;(display ",")
                   ;;(display y)
                   ;;(display ")")
                 0)))
          (else (goToArrayY (cdr grid) (+ county 1) x y))))
    (cond ((eq? grid '()) (display "Coordinates outside of grid"))
      ((= countx x) (goToArrayY (car grid) 1 x y))  
        (else (goToArrayX (cdr grid) (+ countx 1) x y))))
  (goToArrayX grid 1 x y))

(define (array-size squares)
  (foldr  (lambda (x y) (+ y 1)) 0 squares))
  ;;(length (car squares)))

(define (genRandSquare grid)
  (define (genRandSquare2 grid x y)
        (if (square? (getSquare grid x y))
            (genRandSquare2 grid (+ (random (array-size grid)) 1) (+ (random (array-size grid)) 1))
            ;;else
            (addSquare grid x y)))
  ;;First, check to see if its possible to place a square
  (if (foldr (lambda (x y) (and (foldr (lambda (x y) (and y (square? x))) true x) y)) true grid)
      ;;Game over, no blank spaces left
      (display "Game Over")
      ;;Else
      (genRandSquare2 grid (+ (random (array-size grid)) 1) (+ (random (array-size grid)) 1)))
  )
      

(define (square? maybeSquare)
  (not (number? maybeSquare)))
  ;;(eq? maybeSquare square ))

;;This will be used for both left and right folding
;;List input and output must be reversed for right folding
(define (moveFold x y)
    
    (define (moveAllToLeft x)
    (cond ((eq? (car x) '()) '())
          ((eq? (cdr x) '()) x)
          ((not (square? (car x))) (append (moveAllToLeft (cdr x)) '(0) ))
          (else (cons (car x) (moveAllToLeft (cdr x))))
          ))

    (define (mergeSquaresLeft x)
      (if (eq? x '()) '()
        (if (and (square? (car x)) (square? (cadr x)))
           (if (= (((car x) 'getLevel)) (((cadr x) 'getLevel)))
               (begin
               (((car x) 'levelUp))
               (mergeSquaresLeft (append (cons (car x) (cdr (cdr x))) '(0))))
               (cons (car x)(mergeSquaresLeft (cdr x))))
               (cons (car x)(mergeSquaresLeft (cdr x)))
               )))
    (mergeSquaresLeft (moveAllToLeft x))
    )

(define (moveLeft grid)
  (define (moveLeftFold x y)
    (cons (moveFold x y) y))
    (if (eq? grid '()) '()
         (foldr moveLeftFold '() grid))
        )

    
(define (moveRight grid)
  (define (moveRightFold x y)
    (cons (reverse(moveFold (reverse x) y)) y))
  
  (if (eq? grid '()) '()
         (foldr moveRightFold '() grid))
        )

(define (moveUp grid)
        
(define (moveUpFold x y)
    (cons (moveFold x y) y))

  (define (moveUpLoop grid)
  (cond ((eq? (car grid) '()) '())
        (else
         (cons (foldr (lambda (x y) (cons (car x) y)) '() grid) (moveUpLoop (foldr (lambda (x y) (cons (cdr x) y)) '() grid))))
        ))

  (moveUpLoop (foldr moveUpFold '() (moveUpLoop grid)))
  )

(define (moveDown grid)
  (define (moveDownFold x y)
    (cons (moveFold x y) y))

  (define (moveDownLoop grid)
  (cond ((eq? (car grid) '()) '())
        (else
         (cons (foldr (lambda (x y) (cons (car x) y)) '() grid) (moveDownLoop (foldr (lambda (x y) (cons (cdr x) y)) '() grid))))
        ))
;;Same as for up but lists are reversed for input and then again as output
  (reverse(moveDownLoop (foldr moveDownFold '() (moveDownLoop grid))))
  )


(provide (all-defined-out))