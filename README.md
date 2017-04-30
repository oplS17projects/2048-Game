# 2048-Game


### Statement
Describe your project. Why is it interesting? Why is it interesting to you personally? What do you hope to learn? 

We used racket to create the game 2048

A player will need to combine tiles of the same color to form a new tile of a greater size, combining two big tiles together will result in a smaller differently colored tile.
The player is given a limited amount of space and each movement of a tile generates a new randomly placed tile. This game will differentiate itself from the game 2048 by using a pattern/color scheme instead of numbers.
The player must try and combine as many squares as possible before the playing area is full and no moves are left.

Both Tim and I are interested in making games so we decided to choose one that was practical and applicable to what we have learned in class. We implemented proper abstraction and code practices in racket. We believe that creating a game that demonstrates a visual representation of classes and data abstraction would be a great way to demonstrate what we have learned in this class.

### Analysis
Explain what approaches from class you will bring to bear on the project.

Be explicit about the techniques from the class that you will use. For example:

- Data Abstraction
We used data abstraction to its full potential by creating methods with meaningful names to abstract the data and keep a clean coding environment where everything is well-defined and easy to read.

- Data Encapsulation
Each game object will be encapsulated, the user will not be able to change anything other than the game board through keyboard input.

- Recursion
For each move, recursion is used to check which blocks are touching each other. Recurion is also used to plot the squares to the grid as well as made with recursive functions. 

- Map
Map is used to map the direction the player inputs to the board. so if the player chooses left it would map left to squares on the board, moving each block left as long as they are not blocked by another
- Object-orientation
Each block will be an object that holds two point values and a level.

- Will you use state-modification approaches? How? (If so, this should be encapsulated within objects. `set!` pretty much should only exist inside an object.)


**Your project will be graded, in part, by the extent to which you adopt approaches from the course into your implementation, _and_ your discussion about this.**

### External Technologies
We plan to implement a leaderboard, storing the user's name and score, and if possible, in terms of space, a replay of their game. We initially plan to do this in an offline database. But if server space can be found, we can host the database online.

### Data Sets or other Source Materials
Not Applicable

### Deliverable and Demonstration
Currently we have a racket program that when executed, creates a window where the game can be played by the user using keyboard inputs. This game contains visuals and sound that will be displayed for everyone to see. The program will detect when the game is over (no more possible moves), and will ask for the player's name, and will then display the leaderboard. This will be what we demonstrate during our final presentation.
At the end, we will show the leaderboard and how it works, including the raw data stored in the database.

### Evaluation of Results
We have currently achieved a majority of our goals. There were some minor hiccups with moving the squares but that has since been resolved, and there shouldnt be any issues. With the additional time after our demonstration until the code turn in, we will work on smoothing out the user experience, finishing the sound, and as stretch goals, possibly the online leaderboard, and if possible, include game modes with differing sized grids. All of the algorithms are compatible with dynamic grid sizes, but the bugs that may arise pushed this goal past the presentation date.
Some hiccups arose in handling windows in universe. I wasn't sure what the best way to handle windows would be, so the implementation is a bit scattered. Tim eneded up using racket gui to create the leaderboard, and the interface for the player to enter their name.

## Architecture Diagram
Upload the architecture diagram you made for your slide presentation to your repository, and include it in-line here.

Create several paragraphs of narrative to explain the pieces and how they interoperate.
![image](/Presentation%20Architecture%20Diag.png?raw=true "Diagram")

The user generates input using the keyboard, which goes to the main program. The program then generates a new square and moves all the squares together. It also creates a sound which is played to the user. Then this information is stored in a database as a "move" and when the player's game is over, it stores the final score and the user's name in the database.
## Schedule
Explain how you will go from proposal to finished product. 

There are three deliverable milestones to explicitly define, below.

The nature of deliverables depend on your project, but may include things like processed data ready for import, core algorithms implemented, interface design prototyped, etc. 

You will be expected to turn in code, documentation, and data (as appropriate) at each of these stages.

Write concrete steps for your schedule to move from concept to working system. 

### First Milestone (Sun Apr 9)
- Be able to place block on each of the tiles of the game 

### Second Milestone (Sun Apr 16)
- Be able to combine the blocks and recognize when matching blocks are next to each other 
- Implement user keyboard control and sounds

### Public Presentation (Mon Apr 24, Wed Apr 26, or Fri Apr 28 [your date to be determined later])
- Add the leaderboard, bug test and polish the game and underlying code

## Group Responsibilities
Here each group member gets a section where they, as an individual, detail what they are responsible for in this project. Each group member writes their own Responsibility section. Include the milestones and final deliverable.

Please use GitHub properly: each individual must make the edits to this file representing their own section of work.
Henry: Graphics
Tim: Player controls, sound, data structures (defining object classes)

**Additional instructions for teams of three:** 
* Remember that you must have prior written permission to work in groups of three (specifically, an approved `FP3` team declaration submission).
* The team must nominate a lead. This person is primarily responsible for code integration. This work may be shared, but the team lead has default responsibility.
* The team lead has full partner implementation responsibilities also.
* Identify who is team lead.

In the headings below, replace the silly names and GitHub handles with your actual ones.

### Henry Walker @viceroyvonsalsa
Will work on the gui, block structures, and menu interface

### Tim Barber @voxibanez
Will work on user controls, sound, and leaderboard
