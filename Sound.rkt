#lang racket
(require (planet clements/rsound))

(provide playSound stopSounds)

;;Plays a sound from the file name provided.
;;If the file doesnt exist, display an error
(define (playSound name)
  (if (file-exists? name)
      (play (rs-read name))
      (begin
      (display "Error: File \"")
      (display name)
      (display "\" not found"))))

;;Stops all currently playing sounds from rsound
(define (stopSounds)
  (stop))