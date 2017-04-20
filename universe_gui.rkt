#lang racket
(require 2htdp/image)
(define grid-square (square 40 'outline 'black)) ;;1 unit = px size of square
(define testL '( (20 20 20 "solid" "red") (60 60 30 "outline" "blue") (-20 -20 10 "solid" "green") (-60 -60 5 "outline" "black"))) ;;square (x y lvl solid? color)

(define (row size) ;;size of each row on the grid
  (if (> size 1)
      (beside grid-square (row (- size 1)))
      grid-square))

(define (grid rs cs) ;;row size , column size
  (if (> cs 1)
      (above (row rs) (grid rs (- cs 1)))
      (row rs)))

(define (plot-squares list-squares)
  (if (null? list-squares)
      (grid 4 4) ;;grid can be any size but if grid r or c arent even it will throw off the square placement
      (overlay/offset (square (car (cdr (cdr (car list-squares)))) (car (cdr (cdr (cdr (car list-squares))))) (car (cdr (cdr (cdr (cdr (car list-squares))))))) (car (car list-squares )) (car (cdr (car list-squares))) (plot-squares (cdr list-squares)))))

(plot-squares testL)