#lang racket
(require 2htdp/batch-io)
(require htdp/gui)


(define (storeScore score)
  
(define (enterName) (show-window w))
  
(define text1
  (make-text "Please enter your name"))

(define button1
  (make-button "Submit" (lambda (e) (writeFile (text-contents text1) score) (hide-window w) (showLeaderboard))))

(define w
    (create-window
      (list (list button1) (list text1))))

(define (writeFile name score)
(if (file-exists? "highscore.txt")
      (write-file "highscore.txt" (append (construct name score)))
      (write-file "highscore.txt" (construct name score))))

(define (append string)
  (string-append (read-file "highscore.txt") string))

(define (construct name score)
  (string-append "\n" (string-append name (string-append ": " (string-append (number->string score) "\n")))))

  (enterName)
  )

(define (showLeaderboard)
(define text1
  (make-message (read-file "highscore.txt")))

(define button1
  (make-button "Exit" (lambda (e) (hide-window w))))

(define w
    (create-window
      (list (list button1) (list text1))))
  (show-window w)
  )

(provide storeScore)