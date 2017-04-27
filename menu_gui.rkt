#lang racket
(require 2htdp/universe)
(require 2htdp/image)

(define (start-screen n)
  (bitmap "start_menu.jpg"))

(define (stop-screen n)
  (bitmap "StopScreen.png"))

;(define current-grid-lvl 0)

(define (grid-level-text lvl)
  (define lvl-text  
    (cond
      ((< lvl -2) "Cannot create smaller grid")
      ((eq? lvl -1) "Smallest 2 x 2 grid")
      ((eq? lvl 0) "Standard 4 x 4 grid")
      ((eq? lvl 1) "Medium 6 x 6 grid")
      ((eq? lvl 2) "Hard 8 x 8 grid")
      ((> lvl 2) "Maximum grid size attained")))
  (display (text lvl-text 34 "white" ))) 


;(define (key-event-handler x key)
;  (if (key=? key " ")      
;    (big-bang 0(to-draw stop-screen))
;      x)
;  (if (key=? key "up")      
;    (big-bang 0(to-draw (overlay/xy (start-screen 4) 20 10 (grid-level-text (+ 1 current-grid-lvl)))))
;    x)
;  (if (key=? key "down")      
;     (big-bang 0(to-draw (overlay/xy (start-screen 4) 20 10 (grid-level-text (- 1 current-grid-lvl)))))
;     x))


 ;(big-bang 0 (on-key key-event-handler) (to-draw start-screen))

(provide (all-defined-out))