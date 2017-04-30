# 2048 Game in Racket

## Tim Barber
### April 30, 2017

# Overview
This project emulated the concept of the game 2084 using colors and sizes instead of numbers. 
There are multiple tiered colors, each with 3 sizes (small, medium, large). 
Combine two small squares of the same color to make a medium square, 
and combine two large squares of a same color to make a small square of the next color tier.
Together with my partner Henry, we developed this game using racket. 

I was in charge of creating the algorithms for movement, the square object, and sound.
I also worked on the game handler that would bring all these pieces together into the final game, along with Henry.

The most difficult part of this project was the algorithms for movement. I have always had trouble thinking recursively,
but the most efficient way to process the lists of objects was to use recursive procedures and folding. 
By the end of this project, I felt more comfortable working with recursion and folding.

**Authorship note:** All of the code described here was written by myself.

# Libraries Used
The code uses five libraries:

```
(require 2htdp/universe)
(require 2htdp/image)
(require 2htdp/batch-io)
(require htdp/gui)
(require (planet clements/rsound))
```

* The ```2htdp/universe``` library provides the window creation, image drawing, and keyboard event handling we used in our game.
* The ```2htdp/image``` library provides image creation, allowing generation of squares and lines of varying colors and sizes. This library was used in conjunction with ```2htdp/universe``` to draw images to the window
* The ```2htdp/batch-io``` library provides IO functionality used to read and write the high scores from the game to a text file.
* The ```htdp/gui``` library provides basic GUI functionality used to create the window for the user to enter their name, as well as display the user’s high score. 
* The ```planet clements/rsound``` library provides WAV sound functionality, allowing the game to play sounds depending on the actions on screen.

I predominantly used ```2htdp/batch-io``` ```htdp/gui``` ```planet clements/rsound```, and used ```2htdp/universe``` to create the windows.

# Key Code Excerpts

Here is a discussion of the most essential procedures, including a description of how they 
embody ideas from UMass Lowell's Organization of Programming languages course.

Five examples are shown and they are individually numbered. 

## 1. Square Objects
Using what I learned in class, I created a square object in racket. 
I Created a definition with a let statement to hold the variables needed in the object.
```(let ((level 1)(color "green")(size 1))```

I then created multiple get and set procedures, 
using an incrementing procedure for the level to prevent accidental values being placed in level:
```(define (levelUp)
     (begin (set! level (+ 1 level))
            level)
     )
     (define (changeColor newColor)
     (begin (set! color newColor)
            color)
     )
     (define (changeSize newSize)
     (begin (set! size newSize)
            size)
     )
     (define (getColor)
     color)
     (define (getSize)
     size)
```

Then I created a dispatch function that takes a procedure name, and then returns that procedure to be evaluated:
```  (define (dispatch m)
         (cond ((eq? m 'levelUp) levelUp)
               ((eq? m 'getLevel) getLevel)
               ((eq? m 'getColor) getColor)
               ((eq? m 'getSize) getSize)
               ((eq? m 'changeColor) changeColor)
               ((eq? m 'changeSize) changeSize)
               (else (error "Unknown request: "  m))))
```               
I then finished the definition by returning the dispatch procedure (unevaluated):
```dispatch))```

What this does is that when a square is created in the grid, it becomes the dispatch procedure, 
with its own values kept inside the let statement encapsulating that dispatch function. 
The dispatch procedure is then evaluated and it returns the procedure asked for (unevaluated), 
if it can’t find the procedure it says “unknown request”. 
The procedure returned must then be evaluated with the parameters it needs. 

## 2. Movement Procedures
I spent the majority of my time working on the movement procedures. My goal was to make them work for any grid size. 
To keep complexity down I created one movement function to handle all arrays. 
It assumes that you want to move all squares left. This function deals with only one row at a time, 
so it must be called multiple times depending on the row count:
```(define (moveFold x y readOnly)
 
     (define (moveAllToLeft x)
           (cond ((eq? (car x) '()) '())
           ((eq? (cdr x) '()) x)
           ((not (square? (car x))) (append (moveAllToLeft (cdr x)) '(0) ))
           (else (cons (car x) (moveAllToLeft (cdr x))))
           ))
```
 It starts by moving all squares as far left as they can go (using moveAllToLeft). 
 Squares cannot pass through other squares but they can pass through blank spaces (indicated as 0).
 
 This procedure is recursive, each call deals with the car (the head) of the list. 
 If its not a square, it is moved to the end of the row and everything else is moved left by 1. 
 If not, it moves on to the next element in the list until we reach the end of the list (indicated by nil)
 
```     (define (mergeSquaresLeft x readOnly)
       (if (eq? x '()) '()
           (if (eq? (cdr x) '()) x
         (if (and (square? (car x)) (square? (cadr x)))
             ;;If this square and the next are the same level. Merge them and increase the level
            (if (= (((car x) 'getLevel)) (((cadr x) 'getLevel)))
                (begin
                  ;;Check to see if we are not modifying the levels (readOnly in game over checking to see into the future)
                (when (false? readOnly)
                  (begin
                    ;;Level up the current square, if the level is mod 4 (meaning we changed color), then play a different sound than a normal merge
                  (((car x) 'levelUp)) (if (= (modulo(((car x) 'getLevel)) 4) 0) (playSound "Sound4.wav") (playSound "Sound1.wav"))))
                (mergeSquaresLeft (append (cons (car x) (cdr (cdr x))) '(0)) readOnly))
                (cons (car x) (mergeSquaresLeft (cdr x) readOnly)))
                (cons (car x) (mergeSquaresLeft (cdr x) readOnly))
                ))))
```
Then the squares are merged (using mergeSquaresLeft), using the row returned by moveAllToLeft. 
mergeSquaresLeft iterates through the row, if two adjacent squares are the same level, 
then it levels up the one furthest left and removes the one furthest right. 

It also plays a sound depending on if its changing size or changing color (and size). 
A readOnly flag is set if we want to check for a future moves without impacting the level of the object. 

Even if the grid is a copy, the objects are not so any changes to a copy of the grid will still change the object. 
It was for this reason that I had to create the readOnly flag to prevent changes when doing operations,
such as checking for game over, which checks all possible next moves.

```(mergeSquaresLeft (moveAllToLeft x) readOnly))```
                                                                                                                                                                                          
This is what the procedure calls when it is run. 
It calls mergeSquaresLeft and give it the grid created by moveAllToLeft, along with the readOnly flag.

From there, moving left and right was only a few extra lines:
```
 (define (moveLeft grid readOnly)
   (define (moveLeftFold x y)
     (cons (moveFold x y readOnly) y))
     (if (eq? grid '()) '()
          (foldr moveLeftFold '() grid))
         )
 
 (define (moveRight grid readOnly)
   (define (moveRightFold x y)
     (cons (reverse(moveFold (reverse x) y readOnly)) y))
   
   (if (eq? grid '()) '()
          (foldr moveRightFold '() grid))
         )
```
Moving squares left required a foldr which appends the result of the processed row with the rest of the grid. 
In this instance, the define was used instead of lambda for readability in the foldr.

Moving squares right was similar to moving left, but the rows needed to be reversed as input and then as output.

Moving the squares up and down would be more challenging, as the structure of the grid was a list of lists. 
Moving up and down would require traversing one element of multiple lists instead of multiple elements of one list.
To achieve this, I used a method to turn each column into a row and then back again:
```
 (define (moveUp grid readOnly)
         
 (define (moveUpFold x y)
     (cons (moveFold x y readOnly) y))
 
   (define (moveUpLoop grid)
   (cond ((eq? (car grid) '()) '())
         (else
          (cons (foldr (lambda (x y) (cons (car x) y)) '() grid) (moveUpLoop (foldr (lambda (x y) (cons (cdr x) y)) '() grid))))
         ))
 
   (moveUpLoop (foldr moveUpFold '() (moveUpLoop grid)))
   )
```
I took the car of each column, appended them to create a row, then I “shaved” the first value off each list, 
and continued until each list was nil. Now the grid was in a format that could be processed 
by the moveFold procedure (much like moving left)

Moving down used a similar method, but it needed to be reversed as input and as output (much like moving right):
```
 (define (moveDown grid readOnly)
   (define (moveDownFold x y)
     (cons (moveFold (reverse x) y readOnly) y))
 
   (define (moveDownLoop grid)
   (cond ((eq? (car grid) '()) '())
         (else
          (cons (foldr (lambda (x y) (cons (car x) y)) '() grid) (moveDownLoop (foldr (lambda (x y) (cons (cdr x) y)) '() grid))))
         ))
 ;;Same as for up but lists are reversed for input and then again as output
   (reverse(moveDownLoop (foldr moveDownFold '() (moveDownLoop grid))))
   )
   ```

These procedures challenged my recursion skills, as well as my ability to predict the given output of code. 
By the end, I felt very confident in my abilities to design recursive statements.

## 3. Folding
In this project, I repeatedly used Folding, mostly Foldr, to recurse over lists. 
Mainly, my use of foldr was to manipulate the grid (a list of lists). Here is an excerpt from moveUp shown previously:
```(define (moveUpLoop grid)
   (cond ((eq? (car grid) '()) '())
         (else
          (cons (foldr (lambda (x y) (cons (car x) y)) '() grid) (moveUpLoop (foldr (lambda (x y) (cons (cdr x) y)) '() grid))))
         ))
```
The first foldr:
```(foldr (lambda (x y) (cons (car x) y)) '() grid)```
Was used to grab the first element from each list

The second foldr:
```(foldr (lambda (x y) (cons (cdr x) y)) '() grid)```
Was used to construct a grid with the first element from each list removed
These folds were used in conjunction to convert each column into a row.

Other examples of folding are in the score counting:

```(foldr (lambda (x y) (+ (foldr (lambda (x y) (if (square? x) (+ (* ((x 'getLevel)) (* ((x 'getLevel)) ((x 'getLevel)))) y) (+ y 0))) 0 x) y)) 0 grid)```

This excerpt uses nested foldr’s to iterate through each list. 
Within each list, if there is a square, it adds the level of that square^3 to the score.

By the end of this project, I was able to easily visualize how to use folding to achieve any iterative process on the grid, 
as long as it did not involve external parameters, since I could not pass that to the lambda. 


## 4. Using Lists
This project revolved around the grid, a list of lists, used throughout the game, to store, modify, and move squares. 
Any of these actions requires extensive list manipulation. Here is an excerpt of adding a square to the array:
```(define (addSquare grid x y)
   (define (goToArrayX grid countx x y)
     (define (goToArrayY grid county x y)
       (cond ((= county y) (cons (square) (cdr grid)))
             ((eq? grid '()) (display "Coordinates outside of grid"))
           (else (cons (car grid) (goToArrayY (cdr grid) (+ county 1) x y)))))
     (cond ((= countx x) (cons (goToArrayY (car grid) 1 x y) (cdr grid)))
           ((eq? grid '()) (display "Coordinates outside of grid"))
         (else(cons (car grid) (goToArrayX (cdr grid) (+ countx 1) x y))))
     )
   (goToArrayX grid 1 x y))
```
The code uses two functions, goToArrayY and goToArrayX. goToArrayX is called with a count of 1, 
which first waits for goToArrayY. goToArrayY recursively calls itself with the cdr of the grid until the counter 
equals the given y coordinate (which starts at 1). If the grid is nil before we get to the coordinate, or on the coordinate,
we return an error. 

Once y is found, it is returned to goToArrayX as a single list of the squares. 

Then goToArrayX uses the same method of recursively calling itself until the count equals the x coordinate. 
Once the specific coordinate is reached, it will replace whatever is there with a new square object. 

This procedure is “dumb” in the sense that it does not check for an existing square, 
this is expected to be done externally before this procedure is called. The only checks it does it bounds checking.

This is just one example of list manipulation. Just about every procedure in the Algorithms.txt manipulates the grid. 
I used my knowledge of how lists work in racket along with the how to access elements using car and cdr inside the lists. 

## 5. Short Circuiting
I implemented short circuiting in my game over checking procedure. 
I needed to implement short circuiting to minimize the performance impact of this procedure, 
as it had to be run every move and had the performance impact of more than 4 moves. 
The following code is an excerpt from the game over procedure:
```(define (checkGameOver grid)
   (if (noBlanks? grid)
   (and (noBlanks? (moveLeft grid false)) (noBlanks? (moveRight grid false)) (noBlanks? (moveUp grid false)) (noBlanks? (moveDown grid false))) 
   false))
 ```
The first thing this procedure checks is if the grid has blanks, if it does then there is no reason to check anything else, the game is not over. If the grid is full, I use and to check for blanks after moving left, then right, up, and down. The and uses short circuiting, so if one is false (hopefully the first one) it will short circuit, and we will not have to check any other moves for blank squares.

Within the noBlanks? procedure, I also used short circuiting:
```(define (noBlanks? grid)
   (define (blanksLoop grid)
     (if (eq? grid '()) true
     (if (false? (square? (car grid))) false
         (blanksLoop (cdr grid))
         )))
   (if (eq? grid '()) true
       (if (false? (blanksLoop (car grid))) false
                   (noBlanks? (cdr grid)))))
```
noBlanks? iterates over the lists, and within each list, checks for a blank square (using square?). 
For the first blank square it sees, it returns false. 
This short circuiting will help prevent a full grid iteration, which can be expensive especially if the grid is large. 
However, if the grid is completely full, the grid will need to be iterated through in its entirty to determine there are no blank squares left.

While I have learned short-circuiting in the past, this class taught me the performance benefit of using short circuiting, 
and it made a noticeable impact on my machine once I implemented short circuiting in the excerpts above.
