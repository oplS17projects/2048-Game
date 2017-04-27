#lang racket
(require 2htdp/image)
(require "Algorithms.rkt")

;;This defines the grid size. will use -a to a for x and y directions
(define grid_size 240) ;;1 1 is top left
(define square_size (* grid_size (/ 2 3)))
(define grid-square (square square_size 'outline 'black)) ;;1 unit = px size of square

(define (row size) ;;size of each row on the grid
  (if (> size 1)
      (beside grid-square (row (- size 1))) ;creates a row of squares next to eachother
      grid-square))

(define (grid rs cs) ;;row size , column size
  (if (> cs 1)
      (above (row rs) (grid rs (- cs 1))) ;stacks all the rows of squares on top of eachother to make a grid
      (row rs)))

(define (testGridZ)
  (let ((test (createArray 4 4))) 
    (begin
      (set! test (addSquare test 1 1))
      (set! test (addSquare test 2 2))
      (set! test (addSquare test 4 3))
      (set! test (addSquare test 4 4))
      test)))

(define mainGridun '())

(define (update n)
  mainGridun)
  
(define (plot-squares-interop list-squares)
  (set! mainGridun (plot-squares (convert list-squares))))

(define (convert squares)
  (let ((as (array-size squares)))
  (define (loopx squares x y)
     (if (eq? squares '()) '()
        (if (square? (car squares))           
            (cons (list x y (car squares)) (loopx (cdr squares) (- x  (/ (* 2.65 grid_size) as)) y))
             (loopx (cdr squares) (- x (/ (* 2.65 grid_size) as)) y))         
   ))
  (define (loopy squares y)
    (if (eq? squares '()) '()
        (append (loopx (car squares) grid_size y) (loopy (cdr squares ) (- y (/ (* 2.65 grid_size) as))))
        ))
  (reverse(loopy squares grid_size))
  ))
  
;(define (plot-squares list-squares)
  ;(if (null? list-squares)
      ;(grid 4 4) ;;grid can be any size but if grid r or c arent even it will throw off the square placement
       ;(overlay/offset (square (car (cdr (cdr (car list-squares)))) (car (cdr (cdr (cdr (car list-squares))))) (car (cdr (cdr (cdr (cdr (car list-squares))))))) (car (car list-squares )) (car (cdr (car list-squares))) (plot-squares (cdr list-squares)))))

;(define (convert2YIter squares ypos) 1)
 ; (if (> ypos 4)
   ;   '()
    ;  (cons (convert2XIter (car squares

;(define (convert2XIter squares xpos ypos)
 ; (if (eq? 0 (car squares))
      ;(convert2XIter (cdr squares) (+ 1 xpos) ypos)
     ; 1))
     
;(define (convert2 squares) 
  ;(convert2XIter (car squares)
   ; 1)
      
(define (get-color level)
  (if (< level 4) "green"
      (if (< level 7) "red"
          (if (< level 10) "blue"
              "yellow"))))

(define (get-size level)
  (if (eq? (modulo level 3) 0)
      120
      (* 40 (modulo level 3))))

(define (level-square level) 
  (square (get-size level) "solid" (get-color level))) ;; not final size

(define (get-square-level square)
  (((car (cdr (cdr square))) 'getLevel)))

(define (get-x-coord square)
  (car square))

(define (get-y-coord square)
  (car (cdr square)))

(define (plot-squares list-squares)
  (if (null?  list-squares)
      (grid 4 4)              ;;4 4
      (overlay/offset (level-square (get-square-level (car list-squares))) (get-x-coord (car list-squares)) (get-y-coord (car list-squares)) (plot-squares (cdr list-squares)))))

(plot-squares-interop (testGridZ))
;(plot-squares (testGridY))
;(convert (testGridZ))
;(testGridX)
;(((car (car (testGridY))) 'getLevel))
;(getSquare (testGridY) 1 1)
;(plot-squares-interop (testGridY))
;(plot-squares testL)

(provide (all-defined-out))