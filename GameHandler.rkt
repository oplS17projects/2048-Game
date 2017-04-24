#lang racket
;;Used to create the window
;;(require htdp/world)
(require 2htdp/universe)

;;Other files handler will use
(require "menu_gui.rkt")
(require "universe_gui.rkt")
(require "Sound.rkt")
(require "Algorithms.rkt")

(define menu-draw
  start-screen)

;;Keyboard event handler, pretty much the only thing that needs to happen in the handler
;;Everything else will happen in other files (libraries)
(define (main)
(let ((mainGrid (genRandSquare(createArray 4 4))))

(define (startGame)
 ;;Create start window
(big-bang 0 (on-key menu-control) (to-draw start-screen))

;;Call on-key-event, which will listen for keyboard events and a cond will handle each key press
;;(cond ((false?(on-key-event change)) (display "Failed to start key-event-handler\n"))
    ;;(else (display "Sucessfully loaded key-event-handler\n")))
  )

  ;;This is where you define what each key will do
  ;;Need to move/merge squares in algorythms, play a sound, and update the window with new graphics
(define (game-control w a-key)
  (cond
    [(key=? a-key "left")  (begin (set! mainGrid (genRandSquare(moveLeft mainGrid))) (gameOver? mainGrid) (printGrid mainGrid) (plot-squares-interop mainGrid))]
    [(key=? a-key "right") (begin (set! mainGrid (genRandSquare(moveRight mainGrid))) (gameOver? mainGrid) (printGrid mainGrid) (plot-squares-interop mainGrid))]
    [(key=? a-key "up")    (begin (set! mainGrid (genRandSquare(moveUp mainGrid))) (gameOver? mainGrid) (printGrid mainGrid) (plot-squares-interop mainGrid))]
    [(key=? a-key '"down")  (begin (set! mainGrid (genRandSquare(moveDown mainGrid))) (gameOver? mainGrid) (printGrid mainGrid) (plot-squares-interop mainGrid))]
    ))

(define (menu-control w a-key)
  (cond
   [(key=? a-key " ")  (begin (printGrid mainGrid) (plot-squares-interop mainGrid) (big-bang 0 (on-release game-control) (to-draw update) (close-on-stop isGameOver?)))]
    ))
  
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
  (printGrid mainGrid)


    ))


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

;;(main)







