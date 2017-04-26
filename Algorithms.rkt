#lang racket

(require "Objects.rkt")
(require "Sound.rkt")

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

;;Debug Grids
(define (testGridX)
  (let ((test (createArray 4 4))) 
    (begin
      (set! test (addSquare test 1 1))
      (set! test (addSquare test 1 2))
      (set! test (addSquare test 1 3))
      (set! test (addSquare test 1 4))
      test)))

(define (testGridY)
  (let ((test (createArray 4 4))) 
    (begin
      (set! test (addSquare test 1 1))
      (set! test (addSquare test 2 1))
      (set! test (addSquare test 3 1))
      (set! test (addSquare test 4 1))
      test)))

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


;;Takes in a grid and generates a random square on a blank grid square
(define (genRandSquare grid)
  (define (genRandSquare2 grid x y)
        (if (square? (getSquare grid x y))
            (genRandSquare2 grid (+ (random (array-size grid)) 1) (+ (random (array-size grid)) 1))
            ;;else
            (addSquare grid x y)))
  ;;First, check to see if its possible to place a square
  (if (noBlanks? grid)
      ;;Game over, no blank spaces left
      grid
      ;;Else
      (genRandSquare2 grid (+ (random (array-size grid)) 1) (+ (random (array-size grid)) 1)))
  )
      
(define (list-copy list)
  (if (null? list) '() (cons (car list) (list-copy (cdr list)))))

;;Check if the entire grid is filled with squares, even after moving left right up and down
(define (checkGameOver grid)
  (if (noBlanks? grid)
  (and (noBlanks? (moveLeft grid false)) (noBlanks? (moveRight grid false)) (noBlanks? (moveUp grid false)) (noBlanks? (moveDown grid false))) 
  false))

(define (noBlanks? grid)
  (define (blanksLoop grid)
    (if (eq? grid '()) true
    (if (false? (square? (car grid))) false
        (blanksLoop (cdr grid))
        )))
  (if (eq? grid '()) true
      (if (false? (blanksLoop (car grid))) false
                  (noBlanks? (cdr grid)))))

(define (gameOver? grid)
  (if (checkGameOver grid) (begin (set! isGameOver? true) (display "Score: ") (display (getScore grid)) (display "\n") isGameOver?) false))

(define isGameOver? false)

(define menuClose false)
(define (closeTheMenu) (set! menuClose true))
(define (closeMenu? n) menuClose)

(define (gameWinClose? n) isGameOver?)
;;Returns true or false depending on if maybeSquare is a square object or not
(define (square? maybeSquare)
  (not (number? maybeSquare)))
  ;;(eq? maybeSquare square ))


(define (getScore grid)
  (foldr (lambda (x y) (+ (foldr (lambda (x y) (if (square? x) (+ (* ((x 'getLevel)) ((x 'getLevel))) y) (+ y 0))) 0 x) y)) 0 grid))


;;This will be used for both left and right folding
;;List input and output must be reversed for right folding
(define (moveFold x y readOnly)
    
    (define (moveAllToLeft x)
    (cond ((eq? (car x) '()) '())
          ((eq? (cdr x) '()) x)
          ((not (square? (car x))) (append (moveAllToLeft (cdr x)) '(0) ))
          (else (cons (car x) (moveAllToLeft (cdr x))))
          ))

    (define (mergeSquaresLeft x readOnly)
      (if (eq? x '()) '()
          (if (eq? (cdr x) '()) x
        (if (and (square? (car x)) (square? (cadr x)))
           (if (= (((car x) 'getLevel)) (((cadr x) 'getLevel)))
               (begin
                ; (display "If youre here, youre bad")
                
               (when (false? readOnly)
                 (begin 
                 (((car x) 'levelUp)) (if (= (modulo(((car x) 'getLevel)) 4) 0) (playSound "Sound4.wav") (playSound "Sound1.wav"))))
               (mergeSquaresLeft (append (cons (car x) (cdr (cdr x))) '(0)) readOnly))
               (cons (car x) (mergeSquaresLeft (cdr x) readOnly)))
               (cons (car x) (mergeSquaresLeft (cdr x) readOnly))
               ))))
    (mergeSquaresLeft (moveAllToLeft x) readOnly)
    )

;;;Movement algorytims, right and up are based off left, down is based off up.
;;Every movement except left manipulates its array into one that can be processed
;; by moveLeft, and then it manipulates it back to its original form

;;Move the squares left
(define (moveLeft grid readOnly)
  (define (moveLeftFold x y)
    (cons (moveFold x y readOnly) y))
    (if (eq? grid '()) '()
         (foldr moveLeftFold '() grid))
        )

 ;;Move the squares right   
(define (moveRight grid readOnly)
  (define (moveRightFold x y)
    (cons (reverse(moveFold (reverse x) y readOnly)) y))
  
  (if (eq? grid '()) '()
         (foldr moveRightFold '() grid))
        )

;;Move the squares up 
(define (moveUp grid readOnly)
        
(define (moveUpFold x y)
    (cons (moveFold x y readOnly) y))

  (define (moveUpLoop grid)
  (cond ((eq? (car grid) '()) '())
        (else
         (cons (foldr (lambda (x y) (cons (car x) y)) '() grid) (moveUpLoop (foldr (lambda (x y) (cons (cdr x) y)) '() grid))))
        ))

  (moveUpLoop (foldr moveUpFold '() (moveUpLoop grid)))
  )

;;Move the squares down 
(define (moveDown grid readOnly)
  (define (moveDownFold x y)
    (cons (moveFold (reverse x) y readOnly) y))

  (define (moveDownLoop grid)
  (cond ((eq? (car grid) '()) '())
        (else
         (cons (foldr (lambda (x y) (cons (car x) y)) '() grid) (moveDownLoop (foldr (lambda (x y) (cons (cdr x) y)) '() grid))))
        ))
;;Same as for up but lists are reversed for input and then again as output
  (reverse(moveDownLoop (foldr moveDownFold '() (moveDownLoop grid))))
;;(foldr moveDownFold '() (moveDownLoop grid))
;;(moveDownLoop grid)
  )


(provide (all-defined-out))