# 2048-Game


### Statement
Describe your project. Why is it interesting? Why is it interesting to you personally? What do you hope to learn? 

We will be using racket to create the game 2048

A player will need to combine tiles of the same color to form a new tile with a different color.
The player is given a limited amount of space and each movement of a tile produces a new tile. This game will differentiate itself from the game 2048 by using a pattern/color scheme instead of numbers.
The player must try and combine as many squares as possible before the playing area is full and no moves are left.
Both Tim and I are interested in making games so we decided to choose one that was practical and applicable to what we have learned in class. We hope to learn proper abstraction and code practices in racket. We believe that creating a game that demonstrates a visual representation of classes and data abstraction would be a great way to demonstrate what we have learned in this class.

### Analysis
Explain what approaches from class you will bring to bear on the project.

Be explicit about the techniques from the class that you will use. For example:

- Data Abstraction
We plan to use data abstraction to its full potential by creating methods with meaningful names to abstract the data and keep a clean coding environment where everything is well-defined and easy to read.

- Data Encapsulation
Each game object will be encapsulated, the user will not be able to change anything other than the game board through keyboard input.

- Recursion
For each move, recursion will be used to check which blocks are touching each other. 

- Map
Map will be used to map the direction the player inputs to the board. so if the player chooses left we would map left to squares on the board, moving each block left as long as they are not blocked by another
- Object-orientation
Each block will be an object that holds a point value and color, as well as its coordinates on the grid.

- Will you use state-modification approaches? How? (If so, this should be encapsulated within objects. `set!` pretty much should only exist inside an object.)


**Your project will be graded, in part, by the extent to which you adopt approaches from the course into your implementation, _and_ your discussion about this.**

### External Technologies
We plan to implement a leaderboard, storing the user's name and score, and if possible, in terms of space, a replay of their game. We initially plan to do this in an offline database. But if server space can be found, we can host the database online.

### Data Sets or other Source Materials
Not Applicable

### Deliverable and Demonstration
At the end, we will have a racket program that when executed, will create a window where the game can be played by the user using keyboard inputs. This game contains visuals and sound that will be displayed for everyone to see. This will be what we demonstrate during our final presentation
At the end, we will show the leaderboard and how it works, including the raw data stored in the database.

### Evaluation of Results
Simply put if the games plays properly and the leaderboard works properly as we described, then we have achieved success. If not, testing will be necessary to see what is going wrong.

## Architecture Diagram
Upload the architecture diagram you made for your slide presentation to your repository, and include it in-line here.

Create several paragraphs of narrative to explain the pieces and how they interoperate.

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
