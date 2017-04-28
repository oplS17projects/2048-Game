#lang racket
(require 2htdp/image)
(require "Algorithms.rkt")

;;This defines the grid size. will use -a to a for x and y directions
(define grid_size 160) ;;1 1 is top left 240 default
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

(define 6grid #f) ;this is just a test bool for grid size until it can be gathered from menu
;;IMPORTANT change (let ((mainGrid (genRandSquare(createArray 4 4)))) in game handler to 6 6 in order to function 

;debug grid
(define (testGridZ)
  (let ((test (createArray 6 6))) 
    (begin
      (set! test (addSquare test 1 1))
      (set! test (addSquare test 2 2))
      (set! test (addSquare test 2 3))
      (set! test (addSquare test 3 3))
      (set! test (addSquare test 4 4))
      (set! test (addSquare test 4 3))
      (set! test (addSquare test 5 5))
      (set! test (addSquare test 6 6))
      test)))

(define mainGridun '())

(define (update n)
  mainGridun)



(define (plot-squares-interop list-squares)  
  (display "\n")
  (display (getScore  list-squares))
  (set! mainGridun (plot-squares (convert list-squares) (getScore list-squares))))
 
(define (convert squares)
  (define grid-coeff (if (eq? #t 6grid) 4 2.65))
  (let ((as (array-size squares)))
  (define (loopx squares x y)
     (if (eq? squares '()) '()
        (if (square? (car squares))           
            (cons (list x y (car squares)) (loopx (cdr squares) (- x  (/ (* grid-coeff grid_size) as)) y)) ;;2.65 for all
             (loopx (cdr squares) (- x (/ (* grid-coeff grid_size) as)) y))         
   ))
  (define (loopy squares y)
    (if (eq? squares '()) '()
        (append (loopx (car squares) grid_size y) (loopy (cdr squares ) (- y (/ (* grid-coeff grid_size) as))))
        ))
  (reverse(loopy squares grid_size))
  ))
  
;(define (plot-squares list-squares)
  ;(if (null? list-squares)
      ;(grid 4 4) ;;grid can be any size but if grid r or c arent even it will throw off the square placement
       ;(overlay/offset (square (car (cdr (cdr (car list-squares)))) (car (cdr (cdr (cdr (car list-squares))))) (car (cdr (cdr (cdr (cdr (car list-squares))))))) (car (car list-squares )) (car (cdr (car list-squares))) (plot-squares (cdr list-squares)))))

;(define (convert2YIter squares ypos) 
 ; (if (> ypos 4)
   ;   '()
    ;  (cons (convert2XIter (car squares))(convert2XIter (cdr squares))))

;(define (convert2XIter squares xpos ypos)
  ;(if (eq? '() (car squares))
     ;'()
     ; (convert2XIter (cdr squares) (+ 1 xpos) ypos)))     
     
;(define (convert2 squares) 
 ; (cons (convert2YIter (car squares) (convert2YIter (cdr squares)))))

      
(define (get-color level)
  (if (< level 4) "green"
      (if (< level 7) "red"
          (if (< level 10) "blue"
              "yellow"))))

(define (get-size level)
  (if (eq? (modulo level 3) 0)
      (* grid_size (/ 1 2)) ;120 old vals
      (* (* grid_size (/ 1 6)) (modulo level 3)))) ;40

(define (level-square level) 
  (square (get-size level) "solid" (get-color level))) ;; not final size

(define (get-square-level square)
  (((car (cdr (cdr square))) 'getLevel)))

(define (get-x-coord square)
  (car square))

(define (get-y-coord square)
  (car (cdr square)))

(define (plot-squares list-squares score)
  (if (null?  list-squares)
      (if (eq? #t 6grid)
          (grid 8 8) ;so far 6 6 grid is off center and needs a 8 8 to fit on grid or squares go oob
          (overlay/xy (grid 4 4) 0 400 (text (string-append "Score: " (number->string score)) 24 "olive"))) ;default grid (getScore list-squares)
      (overlay/offset (level-square (get-square-level (car list-squares))) (get-x-coord (car list-squares)) (get-y-coord (car list-squares)) (plot-squares (cdr list-squares) score))))



;(plot-squares-interop (testGridY))
;mainGridun
;(plot-squares (testGridY))
;(convert (testGridZ))
;(testGridX)
;(((car (car (testGridY))) 'getLevel))
;(getSquare (testGridY) 1 1)
;(plot-squares-interop (testGridY))
;(plot-squares testL)
(provide (all-defined-out))