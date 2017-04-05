#lang racket
;;Used to create the window
(require htdp/world)

;;Other files handler will use
(require "Sound.rkt")
(require "Algorythms.rkt")

;;Keyboard event handler, pretty much the only thing that needs to happen in the handler
;;Everything else will happen in other files (libraries)
(define (main)
(let ((mainGrid (createArray 4 4)))
(define (startGame)
    (set! mainGrid (addSquare mainGrid 1 4))
  (set! mainGrid (addSquare mainGrid 1 3))
 ;;Create no window
(cond ((false?(big-bang 0 0 1 2)) (display "Failed to load world\n"))
    (else (display "World loaded succesfully\n")))

;;Call on-key-event, which will listen for keyboard events and a cond will handle each key press
(cond ((false?(on-key-event change)) (display "Failed to start key-event-handler\n"))
    (else (display "Sucessfully loaded key-event-handler\n")))
  )

  ;;This is where you define what each key will do
  ;;Need to move/merge squares in algorythms, play a sound, and update the window with new graphics
(define (change w a-key)
  (cond
    [(key=? a-key 'left)  (begin (set! mainGrid (moveLeft mainGrid)) (display mainGrid))]
    [(key=? a-key 'right) (begin (set! mainGrid (moveRight mainGrid)) (display mainGrid))]
    [(key=? a-key 'up)    (begin (moveUp mainGrid) (display mainGrid))]
    [(key=? a-key 'down)  (begin (set! mainGrid (moveDown mainGrid)) (display mainGrid))]
    [(key=? a-key #\space)  ]
    [(key=? a-key 'escape)  ]
    ))

  ;;Start the game
  (startGame)
  (display mainGrid)
    ))


(main)

  





