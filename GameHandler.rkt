#lang racket
;;Used to create the window
;;(require htdp/world)
(require 2htdp/universe)

;;Other files handler will use
(require "menu_gui.rkt")
(require "universe_gui.rkt")
(require "Sound.rkt")
(require "Algorithms.rkt")
(require "Leaderboards.rkt")

(define menu-draw
  start-screen)

;;Keyboard event handler, pretty much the only thing that needs to happen in the handler
;;Everything else will happen in other files (libraries)
(define (main)
  ;;mainGrid to be used with the game (created with one randomly placed square)
(let ((mainGrid (genRandSquare(createArray 4 4)))) ;;Assume 4 x 4 until changed to 6 x 6
(define (startGame)

;;Menu Music
(playSound "MainMenu.wav")

 ;;Create start window
(big-bang 0 (on-key menu-control) (to-draw start-screen) (stop-when closeMenu?) (close-on-stop true))
(stopSounds)
  )

  ;;This is the key-map for the game
  ;;You can move the squares up down left and right
  ;;Each move checks for game over, plays a sound, moves/merges the squares,
  ;;generates a new square, and then draws them to the screen
(define (game-control w a-key)
  (cond
    [(key=? a-key "left")   (if (gameOver? mainGrid) (startGameOverGui mainGrid) (begin (playSound "Sound5.wav") (set! mainGrid (genRandSquare(moveLeft mainGrid false)))  (plot-squares-interop mainGrid)))]
    [(key=? a-key "right")  (if (gameOver? mainGrid) (startGameOverGui mainGrid) (begin (playSound "Sound5.wav") (set! mainGrid (genRandSquare(moveRight mainGrid false)))  (plot-squares-interop mainGrid)))]
    [(key=? a-key "up")     (if (gameOver? mainGrid) (startGameOverGui mainGrid) (begin (playSound "Sound5.wav") (set! mainGrid (genRandSquare(moveUp mainGrid false)))  (plot-squares-interop mainGrid)))]
    [(key=? a-key '"down")   (if (gameOver? mainGrid) (startGameOverGui mainGrid) (begin (playSound "Sound5.wav") (set! mainGrid (genRandSquare(moveDown mainGrid false)))  (plot-squares-interop mainGrid)))]
    ))

;;Game over sequence
(define (startGameOverGui grid)
  (playSound "Sound6.wav")
  ;;Window was appearing over gui, so its been removed
  ;;(big-bang 0 (to-draw stop-screen-main))
  (storeScore (getScore grid))
  )

  ;;Game over sequence -> get score
  (define (stop-screen-main n)
    (storeScore (getScore mainGrid))
    (stop-screen n))

  ;;Starts a 4 x 4 grid game
(define (startGameGui44)
  (begin (stopSounds) (closeTheMenu) (plot-squares-interop mainGrid) (big-bang 0 (on-release game-control) (to-draw update 650 700) (stop-when gameWinClose?) (close-on-stop true))))

  ;;Starts a 6 x 6 grid game
(define (startGameGui66)
  (begin (stopSounds) (closeTheMenu) (set! mainGrid (genRandSquare(createArray 6 6))) (using6grid) (plot-squares-interop mainGrid) (big-bang 0 (on-release game-control) (to-draw update 650 700) (stop-when gameWinClose?) (close-on-stop true))))
  
  ;;This is the key map for the menu, space is used to start the game 4 x 4
  Return is used to start the game 6 x 6
(define (menu-control w a-key)
  (cond
   [(key=? a-key " ") (startGameGui44)]
   [(key=? a-key "\r") (startGameGui66)]
    ))

  ;;Debug to print the grid and the level of each square to console
  (define (printGrid grid)
    (define (displayLevel x)
    (cond ((eq? x '()) '())
        ((square? (car x)) (cons (((car x) 'getLevel)) (displayLevel (cdr x))))
     (else (cons (car x) (displayLevel (cdr x))))))
    
    (cond ((not(eq? grid '()))
    (begin
    (display (displayLevel (car grid)))
    (display "\n")
    (printGrid (cdr grid))))))
  
  ;;Start the game
  (startGame)
    ))

;;Automatically call main on run
(main)







