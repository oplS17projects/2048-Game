#lang racket
 (require graphics/turtles)

(turtles 1)

(define (draw_square1 size) ;square1 (not centered)
  (begin
    (draw size)
    (turn 90)    
    (draw size)
    (turn 90)    
    (draw size)
    (turn 90)    
    (draw size)
    (turn 90)))

(define (draw_square2 size) ;;square centered at turtle origin
  (begin
    (move (/ size 2))
    (turn 90)
    (draw (/ size 2))
    (turn 90)    
    (draw size)
    (turn 90)    
    (draw size)
    (turn 90)    
    (draw size)
    (turn 90))
    (draw (/ size 2))
    (turn 90)  
    (move (/ size 2)))

(define (corner mir deg l)
  (begin
    (turn (* mir deg)) 
    (draw (/ l 4))
    (turn (* mir deg))
    (draw l)))

;;for non centered graph l == graph length
(define (graph l mir) ;mir means the turtle will perform mirrored actions of its counterpart
  (begin
    (if (eq? mir -1)
        (turn 90)
        (turn 0))
    (draw l)    
    (corner mir 90 l)
    (corner mir -90 l)
    (corner mir 90 l)
    (corner mir -90 l)       
    ))
    

(define (make-graph) ;;This is the non centered grid function
  (begin
    (tprompt (graph 300 -1)) ;; two zig zags are created overlapping eachother to create the grid (the second zigzag must be mirrored in order to do this)
    (graph 300 1)))


(define (cross l)
  (begin
    (turn 90)
    (draw (/ l 2))
    (split* (turn 0) (turn 90) (turn -90)) ;;a turtle advances to the center of the smol square and splits into 3 creating 4 sub sections
    (draw (/ l 2))))
    
(define (smol-square l)
  (begin
    (draw l)
    (turn 90)
    (draw (/ l 2))
    (tprompt (split (cross l))) ;;a turtle splits off from the border
    (draw (/ l 2))
    (turn 90)
    (draw l)
    (turn 90)
    (draw l)))

;;since this grid is centered l is == to half the graph length
(define (make-grid l) ;This is the centered grid function it works by rotating and creating 4 small squares
  (begin
    (smol-square l) ;;it makes 4 subsections each with 4 sub sections
    (smol-square l)
    (smol-square l)
    (smol-square l)))

(define (plot z l)
  (begin 
    (if (> z 0)
        (if (eq? z 2)
            (move (+ (/ l 4) (/ l 2)))
            (move (/ l 4)))
        (if (eq? z -2)
            (move (- (+ (/ l 4) (/ l 2)))) ;;This grid is centered at the center compared to the first that goes 1-4 from bottom left
            (move (-(/ l 4)))))))
 ;__________________________________
; |(-2,2) | (-1,2) | (1,2) | (2,2) | //diagram representation
; |(-2,1) | (-1,1) | (1,1) |(2,1)  |
; |(-2,-1)| (-1,-1)| (1,-1)| (2,-1)|
; |(-2,-2)| (-1,-2)| (1,-2)| (2,-2)|


(define (plot-square x y l)
  (begin
    (tprompt (plot x l)
    (turn 90)
    (plot y l) 
    (draw_square2 (* l .43333))))) ;this is the coeff of how big the squares are compared to 1/2 the grid


(make-grid 300)
(plot-square -2 -2 300) ;;having multiple varying size squares isn't quite yet since they aren't centered but you can change the coeff of plot square to have uniform squares of some size
(plot-square -1 1 300)
(plot-square 1 1 300)
(plot-square 2 -2 300)
    
