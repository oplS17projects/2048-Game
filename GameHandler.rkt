#lang racket
;;Used to create the window
(require htdp/world)
(require graphics/turtles)
;;Other files handler will use
(require "Sound.rkt")

;;Keyboard event handler, pretty much the only thing that needs to happen in the handler
;;Everything else will happen in other files (libraries)
(define (change w a-key)
  (cond
    [(key=? a-key 'left)  ]
    [(key=? a-key 'right) ]
    [(key=? a-key 'up)    ]
    [(key=? a-key 'down)  ]
    [(key=? a-key #\space)  ]
    [(key=? a-key 'escape)  ]
    ))

;;Create no window
(cond ((false?(big-bang 0 0 1 2)) (display "Failed to load world\n"))
    (else (display "World loaded succesfully\n")))

;;Call on-key-event, which will listen for keyboard events and a cond will handle each key press
(cond ((false?(on-key-event change)) (display "Failed to start key-event-handler\n"))
    (else (display "Sucessfully loaded key-event-handler\n")))