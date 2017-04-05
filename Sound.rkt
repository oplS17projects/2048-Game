#lang racket
;;Using rsound to add sounds to our game
(require (planet clements/rsound))

(provide playSound)

(define (playSound name)
  (if (file-exists? name)
      (play (rs-read name))
      (begin
      (display "Error: File \"")
      (display name)
      (display "\" not found"))))
  