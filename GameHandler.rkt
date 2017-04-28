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
(let ((mainGrid (genRandSquare(createArray 4 4)))) ;;change to 6 6 for bigger list
(define (startGame)
 ;;Create start window
;;(playSound "MainMenu.wav")
(big-bang 0 (on-key menu-control) (to-draw start-screen) (stop-when closeMenu?) (close-on-stop true))
(stopSounds)
  )

  ;;This is the key-map for the game
  ;;This is where you define what each key will do
  ;;Need to move/merge squares in algorythms, play a sound, and update the window with new graphics
(define (game-control w a-key)
  (cond
    [(key=? a-key "left")   (if (gameOver? mainGrid) (startGameOverGui mainGrid) (begin (playSound "Sound5.wav") (set! mainGrid (genRandSquare(moveLeft mainGrid false)))  (plot-squares-interop mainGrid)))]
    [(key=? a-key "right")  (if (gameOver? mainGrid) (startGameOverGui mainGrid) (begin (playSound "Sound5.wav") (set! mainGrid (genRandSquare(moveRight mainGrid false)))  (plot-squares-interop mainGrid)))]
    [(key=? a-key "up")     (if (gameOver? mainGrid) (startGameOverGui mainGrid) (begin (playSound "Sound5.wav") (set! mainGrid (genRandSquare(moveUp mainGrid false)))  (plot-squares-interop mainGrid)))]
    [(key=? a-key '"down")   (if (gameOver? mainGrid) (startGameOverGui mainGrid) (begin (playSound "Sound5.wav") (set! mainGrid (genRandSquare(moveDown mainGrid false)))  (plot-squares-interop mainGrid)))]
    ))

(define (startGameOverGui grid)
  (playSound "Sound6.wav")
  ;;(big-bang 0 (to-draw stop-screen-main))
  (storeScore (getScore grid))
  
  )

  (define (stop-screen-main n)
    (storeScore (getScore mainGrid))
    (stop-screen n))

(define (startGameGui)
  (begin (stopSounds) (closeTheMenu) (plot-squares-interop mainGrid) (big-bang 0 (on-release game-control) (to-draw update 650 700) (stop-when gameWinClose?) (close-on-stop true))))
  
  ;;This is the key map for the menu, only space is used to start the game
(define (menu-control w a-key)
  (cond
   [(key=? a-key " ") (startGameGui)]
    ))

  ;;Debug to print the grid and the level of each square
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
  ;;(printGrid mainGrid)


    ))
 
(main)







