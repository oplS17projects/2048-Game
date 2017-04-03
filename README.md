# 2048-Game


### Statement
Describe your project. Why is it interesting? Why is it interesting to you personally? What do you hope to learn? 

We will be using racket to create the game 2048

A player will need to combine tiles of the same color to form a new tile with a different color.
The player is given a limited amount of space and each movement of a tile produces a new tile. This game will differencate itself from the game 2048 by using a pattern/color scheme instead of numbers.
The player must try and combine as many squares as possible before the playing area is full and no moves are left.
Both Tim and I are interested in making games so we decided to choose one that was practical and applicable to what we have learned in class. We hope to learn proper abstraction and code practises in racket. We beleive that creating a game that demonstrates a visual representation of classes and data abstraction would be a great way to demonstrate what we have learned in this class.

### Analysis
Explain what approaches from class you will bring to bear on the project.

Be explicit about the techiques from the class that you will use. For example:

- Data Abstraction
We plan to use data abstraction to its full potential by creating methods with meaningful names to abstract the data and keep a clean coding environment where everything is well-defined and easy to read.

- Data Encapsilation
Each game object will be encapsulated, the user will not be able to change anything other than the game board through keyboard input.

- Recusrion
For each movem recursion will be used to check which blocks are touching eachother. 

- Map
Map will be used to map the direction the player inputs to the board. so if the player chooses left we would map left to squares on the board, moving each block left as long as they are not blocked by another
- Object-orientation
Each block will be an object that holds a point value and color, as well as its coordinates on the grid.

- Will you use state-modification approaches? How? (If so, this should be encapsulated within objects. `set!` pretty much should only exist inside an object.)


**Your project will be graded, in part, by the extent to which you adopt approaches from the course into your implementation, _and_ your discussion about this.**

### External Technologies
You are encouraged to develop a project that connects to external systems. For example, this includes systems that:

- retrieve information or publish data to the web
- generate or process sound
- control robots or other physical systems
- interact with databases

If your project will do anything in this category (not only the things listed above!), include this section and discuss.

### Data Sets or other Source Materials
If you will be working with existing data, where will you get those data from? (Dowload from a website? Access in a database? Create in a simulation you will build? ...)

How will you convert your data into a form usable for your project?  

If you are pulling data from somewhere, actually go download it and look at it before writing the proposal. Explain in some detail what your plan is for accomplishing the necessary processing.

If you are using some other starting materials, explain what they are. Basically: anything you plan to use that isn't code.

### Deliverable and Demonstration
Explain exactly what you'll have at the end. What will it be able to do at the live demo?
Once completed, we will be able to demonstrate the game and play through a few rounds.

What exactly will you produce at the end of the project? A piece of software, yes, but what will it do? Here are some questions to think about (and answer depending on your application).

Will it run on some data, like batch mode? Will you present some analytical results of the processing? How can it be re-run on different source data?
Nope, so far we have not decided to implement any external data.
Will it be interactive? Can you show it working? This project involves a live demo, so interactivity is good.
Yes, the game will be fully playable and demonstrable.
### Evaluation of Results
How will you know if you are successful? 
If you include some kind of _quantitative analysis,_ that would be good.
Simply put if the games plays, then we have achieved success, if not testing will be necessary to see what is going wrong.
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
Be able to place block on each of the tiles of the game 

### Second Milestone (Sun Apr 16)
Be able to combine the blocks and recognize when matching blocks are next to eachother 

### Public Presentation (Mon Apr 24, Wed Apr 26, or Fri Apr 28 [your date to be determined later])
What additionally will be completed before the public presentation?

## Group Responsibilities
Here each group member gets a section where they, as an individual, detail what they are responsible for in this project. Each group member writes their own Responsibility section. Include the milestones and final deliverable.

Please use Github properly: each individual must make the edits to this file representing their own section of work.

**Additional instructions for teams of three:** 
* Remember that you must have prior written permission to work in groups of three (specifically, an approved `FP3` team declaration submission).
* The team must nominate a lead. This person is primarily responsible for code integration. This work may be shared, but the team lead has default responsibility.
* The team lead has full partner implementation responsibilities also.
* Identify who is team lead.

In the headings below, replace the silly names and GitHub handles with your actual ones.

### Henry Walker @viceroyvonsalsa
will write the gui, user input, and block structures.

### Leonard Lambda @lennylambda
will work on...

### Frank Funktions @frankiefunk 
Frank is team lead. Additionally, Frank will work on...   
