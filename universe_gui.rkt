#lang racket
(require 2htdp/image)
(require "Algorithms.rkt")
(define grid-square (square 40 'outline 'black)) ;;1 unit = px size of square
;(define testL '( (20 20 20 "solid" "red") (60 60 30 "outline" "blue") (-20 -20 10 "solid" "green") (-60 -60 5 "outline" "black"))) ;;square (x y lvl solid? color)
;;This defines the grid size. will use -a to a for x and y directions
(define grid_size 60) ;;1 1 is top left

(define (row size) ;;size of each row on the grid
  (if (> size 1)
      (beside grid-square (row (- size 1)))
      grid-square))

(define (grid rs cs) ;;row size , column size
  (if (> cs 1)
      (above (row rs) (grid rs (- cs 1)))
      (row rs)))

(define (plot-squares-interop list-squares)
  (plot-squares (convert list-squares)))

(define (testGridZ)
  (let ((test (createArray 4 4))) 
    (begin
    (set! test (addSquare test 1 1))
      (set! test (addSquare test 2 3))
    (set! test (addSquare test 4 3))
      (set! test (addSquare test 4 4))
      test)))


(define (convert squares)
  (let ((as (array-size squares)))
  (define (loopx squares x y)
     (if (eq? squares '()) '()
        (if (square? (car squares))
             ;(cons (list x y (car squares)) (loopx (cdr squares) (+ x  (/ (* 2 grid_size) as)) y))
            (cons (list x y (car squares)) (loopx (cdr squares) (+ x  (/ (* 2.65 grid_size) as)) y))
             (loopx (cdr squares) (+ x (/ (* 2.65 grid_size) as)) y))
             
   ))
  (define (loopy squares y)
    (if (eq? squares '()) '()
        (append (loopx (car squares) (* grid_size -1) y) (loopy (cdr squares ) (+ y (/ (* 2.65 grid_size) as))))
        ))
  (reverse(loopy squares (* grid_size -1)))
  ))
  
;(define (plot-squares list-squares)
  ;(if (null? list-squares)
      ;(grid 4 4) ;;grid can be any size but if grid r or c arent even it will throw off the square placement
       ;(overlay/offset (square (car (cdr (cdr (car list-squares)))) (car (cdr (cdr (cdr (car list-squares))))) (car (cdr (cdr (cdr (cdr (car list-squares))))))) (car (car list-squares )) (car (cdr (car list-squares))) (plot-squares (cdr list-squares)))))

(define (convert2YIter squares ypos) 1)
 ; (if (> ypos 4)
   ;   '()
    ;  (cons (convert2XIter (car squares

(define (convert2XIter squares xpos ypos)
  (if (eq? 0 (car squares))
      (convert2XIter (cdr squares) (+ 1 xpos) ypos)
      1))
      

(define (convert2 squares) 
  ;(convert2XIter (car squares)
    1)
      


(define (level-square level) 
  (square (* 10 level) "solid" (if (> level 3) "red" "green"))) ;; not final size

(define (plot-squares list-squares)
  (if (null?  list-squares)
      (grid 4 4)  
      (overlay/offset (level-square (((car (cdr (cdr (car list-squares)))) 'getLevel))) (car (car list-squares)) (car (cdr (car list-squares))) (plot-squares (cdr list-squares)))))

(plot-squares-interop (testGridZ))
;(plot-squares (testGridY))

(convert (testGridZ))
(testGridX)
 (((car (car (testGridY))) 'getLevel))
;(getSquare (testGridY) 1 1)
;(plot-squares-interop (testGridY))
;;(plot-squares testL)

(provide (all-defined-out))