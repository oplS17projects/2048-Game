# 2048 game in Racket

## Henry Walker
### April 30, 2017

# Overview
My partner and I made the game 2048 in racket. The premise of the game is to match equal sized and colored squares with eachother to create a new square
of a larger size or different color. The more squares you are able to match the more points you will earn. Once the game is lost the player will be able to 
store their score in a local leaderboard text file. 

I worked predominately on the GUI for this project. This proved to be a challenge, since I had little experience with making GUI's let alone making one in racket. However, I can't avoid working 
with GUI's forever and this looked like a great learning experience to get aquainted with how they work, so I eagerly accepted the challenge.
I had to learn a lot of new material and made a lot of mistakes, often times having to completely rewrite larger portions of code. One example of this is 
my old turt_gui file, which I spent alot of time on only to find out that it wouldn't function the way we needed it to with user input. After porting the graphics to 2htdp/image I was met with
another challenge, getting everything to line up correctly. While it was easy to do in turtle graphics, converting the array of squares from the Algorythyms file into squares 
which correctly lined up on the grid was definitely my hardest part of the project.

**Authorship note:** All of the code described here was written by myself.

# Libraries Used
I predominately used the 2htdp/image library but also used a bit of the turtle and universe libraries early on in the p
```
(require 2htdp/image)
(require 2htdp/universe)
(require graphics/turtles)
```

* The ```2htdp/image``` library provides the backbone of the Gui for 2048-game
* The ```graphics/turtles``` library was used for the initial GUI but it was later ported to 2htdp/image to make collecting user input easier.
* The ```2htdp/universe``` library is used in the menu_gui

# Key Code Excerpts

Here is a discussion of the most essential procedures, including a description of how they embody ideas from 
UMass Lowell's COMP.3010 Organization of Programming languages course.

Five examples are shown and they are individually numbered. 
 
## 1. Selectors for square object using Procedural Abstraction

The square object we created contains an x coord, y coord and dispatch. To operate on this square object I created a set of selector functions 
to work with in the plot-squares function.

This selector accesses the level. It works by cdring to the third object in the list, which is a procedure, and dispatches it with the getLevel condition, thus returning its level. 
```
(define (get-square-level square)
  (((car (cdr (cdr square))) 'getLevel)))
```
The x and y coordinates just return the first and second elements of the list.
```
(define (get-x-coord square)
  (car square))

(define (get-y-coord square)
  (car (cdr square)))
```
## 2. Using Recursion plot the squares and make the grid

Of all the ideas from the course, I probably used recursion the most due to just how applicable it was for making many things on screen.
The first place I used recursion was the construction of the graph.

```
(define (row size) ;;size of each row on the grid
  (if (> size 1)
      (beside grid-square (row (- size 1))) ;creates a row of squares next to eachother
      grid-square))

(define (grid rs cs) ;;row size , column size
  (if (> cs 1)
      (above (row rs) (grid rs (- cs 1))) ;stacks all the rows of squares on top of eachother to make a grid
      (row rs)))
 ```
 Grid calls row, which recursively places squares next to eachother. This row is then recursively stacked upon other rows until grid returns a singular row.

```
(define (plot-squares list-squares score)
  (if (null?  list-squares)
      (if (eq? #t 6grid)
          (overlay/xy (grid 6 6) 0 637 (text (string-append "Score: " (number->string score)) 24 "black")) ;so far 6 6 grid is off center and needs a 8 8 to fit on grid or squares go oob
          (overlay/xy (grid 4 4) 0 650 (text (string-append "Score: " (number->string score)) 24 "black"))) ;default grid (getScore list-squares)
      (overlay/offset (level-square (get-square-level (car list-squares))) (get-x-coord (car list-squares)) (get-y-coord (car list-squares)) (plot-squares (cdr list-squares) score))))
```
This function is what plots the squares. It works by recursively overlaying each square onto the grid. The square is constructed according to its level and placed in its x/y position
The function then calls itself until it runs out of squares. Once this happens the grid is placed. We currently have two levels implemented a 4x4 grid and a 6x6 grid
Depending on whether the 6 grid flag is on the squares are then placed over the corresponding grid.

## 3. Using recursion for the conversion of square array

Tim and I worked on the conversion function together. Tim initially created the function to help me along while I was having trouble porting the gui from turtle graphics to 2htdp/image
It did plot the squares to the grid but they were offcentered and could only function with a 4x4 grid. I attempted to create my own iterative conversion function from scratch but ran into esssentially the same problem the 
original function did. This was the most difficult part of the assignment for me, as I ended up going through the function line by line testing different values to understand why the squares weren't lining up correctly
I ended up finding and adding the exact coefficients for both the 4x4 and the 6x6 grid so they lined up correctly. The 6x6 grid was alot harder than the 4x4 grid because while the squares lined up, each square was offset 1 square 
so the last row of squares was outside of the grid. I was able to find out that the 6x6 grid needed to be multiplied by another coefficient before its call to loopy here
``` (reverse(loopy squares (* grid-offset grid_size)))``` Since 4x4 was already fine it is just multiplied by 1. With these additions and calibrations we were able to convert the array into a series of squares with precise coordinates.


```
(define (convert squares)
  
  (define grid-coeff (if (eq? #t 6grid) 4 2.65))  ;;this is so the squares line up with eachother
  (define grid-offset (if (eq? #t 6grid) 1.67 1)) ;;this is so the squares line up with the grid

  (let ((as (array-size squares)))
  (define (loopx squares x y)
     (if (eq? squares '()) '()
        (if (square? (car squares))           
            (cons (list x y (car squares)) (loopx (cdr squares) (- x  (/ (* grid-coeff grid_size) as)) y)) ;;2.65 for all
             (loopx (cdr squares) (- x (/ (* grid-coeff grid_size) as)) y))         
   ))
  (define (loopy squares y)
    (if (eq? squares '()) '()
        (append (loopx (car squares) (* grid-offset grid_size) y) (loopy (cdr squares ) (- y (/ (* grid-coeff grid_size) as))))
        ))
  (reverse(loopy squares (* grid-offset grid_size)))
  ))
```
