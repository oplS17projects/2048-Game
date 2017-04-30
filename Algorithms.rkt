#lang racket
(require "Objects.rkt")
(require "Sound.rkt")

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
 
;;Add Square - Adds a square at the given coordinates using recursion with bounds checking
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

;;Get Square - Gets the square at a given location,
;;returns a blank square object if there was no square at the
;;coordinate. Has bounds checking
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

;;Gets the size of the array
(define (array-size squares)
  (foldr  (lambda (x y) (+ y 1)) 0 squares))
  ;;(length (car squares)))


;;Generates a random square on the grid
;;Randomly generates an x and y coordinate, checks if it's a square.
;;If it is a square, try again with new random coordinates.
;;If its not a square, place a square there.
;;Checks are in place to make sure we don't infinitly iterate over a full board
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

;;Checks for game over - checks if the entire grid is filled with squares after moving left right up and down
;;(make sure you really can't move anywhere)
;;Made sure to use short circuiting to help save time since moving squares can be resource intensive
(define (checkGameOver grid)
  (if (noBlanks? grid)
  (and (noBlanks? (moveLeft grid false)) (noBlanks? (moveRight grid false)) (noBlanks? (moveUp grid false)) (noBlanks? (moveDown grid false))) 
  false))

;;Checks if there are any blank spaces on the grid
;;Didn't use folding since I wanted short circuiting to help save resources
;;The first blank square found will return false
(define (noBlanks? grid)
  (define (blanksLoop grid)
    (if (eq? grid '()) true
    (if (false? (square? (car grid))) false
        (blanksLoop (cdr grid))
        )))
  (if (eq? grid '()) true
      (if (false? (blanksLoop (car grid))) false
                  (noBlanks? (cdr grid)))))

;;If the game is over, set the isGameOver? to true, which will close the main window (this is how universe checks if the window should be closed)
(define (gameOver? grid)
  (if (checkGameOver grid) (begin (set! isGameOver? true) isGameOver?) false))

;;Used by universe, if true, the window closes - Used for main window
(define isGameOver? false)
(define (gameWinClose? n) isGameOver?)

;;Used by universe, if true, the window closes - used for start screen
(define menuClose false)
(define (closeTheMenu) (set! menuClose true))
(define (closeMenu? n) menuClose)

;;Returns true or false depending on if maybeSquare is a square object or not
(define (square? maybeSquare)
  (not (number? maybeSquare)))

;;Uses foldr to count up the score of the squares
;;Currently using level^3 to calculate the score
;;This should give a fair distribution of points based on level
(define (getScore grid)
  (foldr (lambda (x y) (+ (foldr (lambda (x y) (if (square? x) (+ (* ((x 'getLevel)) (* ((x 'getLevel)) ((x 'getLevel)))) y) (+ y 0))) 0 x) y)) 0 grid))


;;This will be used for left right up and down folding
;;Expects an array formated for a move left operation
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
            ;;If this square and the next are the same level. Merge them and increase the level
           (if (= (((car x) 'getLevel)) (((cadr x) 'getLevel)))
               (begin
                 ;;Check to see if we are not modifying the levels (readOnly in game over checking to see into the future)
               (when (false? readOnly)
                 (begin
                  ;;
                   ;;Level up the current square, if the level is mod 4 (meaning we changed color), then play a different sound than a normal merge
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
  )


(provide (all-defined-out))