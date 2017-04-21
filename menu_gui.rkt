#lang racket
(require 2htdp/universe)
(require 2htdp/image)

(define (start-screen n)
  (bitmap "StartScreen.png"))

(define (stop-screen n)
  (bitmap "StopScreen.png"))


(define (key-event-handler x key)
(if (key=? key " ")      
      (big-bang 0(to-draw stop-screen))
    x))


;; (big-bang 0 (on-key key-event-handler) (to-draw start-screen))

(provide (all-defined-out))