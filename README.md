# Sliding Tile Puzzle in PDDL 2.0

## Introduction
The aim of this project is to solve some instances of the sliding tile puzzle with the aid of AI Planning techniques. 
In particular, the work focuses on developing a domain and some instances of the problem in PDDL.
The presentation is organized as follows. Firstly, it presents the approach used during the development phases. Secondly, it provides an overview about the domain and the problem instances, with documentation of the PDDL domain file and description of the domains utilized as reference. Thirdly, the planners selected for the assignment are briefly described, along with some quick information about the compilation / build phases and the CLI launch commands for solving the problems. Lastly, the results of the planning tasks are proposed along with a critical analysis of what is obtained.

## Development
The problem was developed with a classical planning approach, so predicates depicting states in the state-space are boolean variables. A ‘closed-world assumption’ was used, as only the predicates regarding true facts were coded for both domain and problem instances. About the development methodology, it followed an iterative approach. For each action, an initial understanding of the action requirements was done by trying applications on easy problems with paper and pen. The code implementation was done via the editor tool of planning.domains, tested on some elementary instances and eventually debugged. Subsequently, an analysis of what was implemented was carried out, with the idea of evaluating the outcome, finding potential flaws and correcting them. Also, some PDDL models were studied before the implementation and used as references. The most influential are:

1. The implementations of the sliding tile problem found at:
  - https://github.com/SoarGroup/Domains-Planning-Domain-Definition-Language/blob/master/pddl/slidetile.pddl
  - https://github.com/SoarGroup/Domains-Planning-Domain-Definition-Language/blob/master/pddl/eight01x.pddl

2. Some domains available from the ‘All-IPC (STRIPS)’ folder in planning.domains. In particular:
  - Blocks-reduced
  - Gripper
  - Logistics00-reduced
  - Peg-solitaire

## Problem Definition, Domain and Problem Instances
### Problem Definition
There is a board that contains tiles of different kinds, represented by letters. One of those is the _empty_ tile, represented by the X letter.
The problem consists of finding a plan to reach a goal state from an initial state by swapping horizontally or vertically two adjacent tiles at a time. 
To solve the problem, there are some rules that must be followed. 
Only two tiles that are adjacent horizontally or vertically can be swapped. When they are swapped, the two tiles switch their coordinates.
Not all kinds of tiles are movable; if one tile is not movable it cannot be swapped in any direction.
Every time three tiles of the same type are aligned horizontally or vertically, all of them can be transformed into the _empty_ tile. 
Lastly, there are some particular tile pairs - named _special pairs_ for simplicity. When the tiles that compose a special pair is swapped, one tile of the two is transformed into the _empty_ tile.

### Domain
In the current implementation, four PDDL files were created, one for the domain and three for the problem instances. The domain is composed of six actions, which make use of three types and six predicates. 

#### Types
The types are:
   
1. _tile_ - the tile type. In the current implementation, it can take one value among the set (G, S, R, H, X), with X representing the ‘empty’ tile
2. _row_ - the row coordinate of the position of the tile on the board
3. _column_ - the column coordinate of the position of the tile on the board

#### Predicates
The predicates are:
1. _tile_at_ ?row ?col ?tile - links the tile type ?tile to its row and column coordinates ?row ?col
2. _adjacent-rows_ ?row1 ?row2 - whether the two rows ?row1 and ?row2 are adjacent
3. _adjacent-columns_ ?col1 ?col2 - whether the two columns ?col1 and ?col2 are adjacent
4. _movable_ ?tile - whether a tile type can be moved or not. This predicate was introduced as it is asked that the types S, G, R, H should move while the empty tile X should not
5. _empty_ ?tile - true if ?tile is the empty tile
6. _magically-disappears_ ?tile1 ?tile2 - This predicate links the two tiles ?tile1 and ?tile2. It is used to encode the required condition of S becoming ‘empty’ once switched with G for magical reasons and it is used within the swap-up-down-special and swap-left-right-special actions.  

#### Actions
The actions of the domain are the following: 
1. _swap-up-down_ <br>
parameters (?col - col ?tile1 ?tile2 - tile ?row1 ?row2 - row)<br>
If two tiles ?tile1 ?tile2 are movable and are not the same tile type, have the same column coordinate ?col, have adjacent row coordinates ?row1 ?row2 and their types do not make true a (magically-disappear ?tile1 ?tile2) predicate, their row coordinates are swapped

2. swap-left-right <br>
parameters (?row1 - row ?tile1 ?tile2 - tile ?col1 ?col2 - col) <br>
If two tiles ?tile1 ?tile2 are movable and are not the same tile type, have the same row coordinate ?row1, have adjacent column coordinates ?col1 ?col2 and their types do not make true a (magically-disappear ?tile1 ?tile2) predicate, their column coordinates are swapped

3. swap-up-down-special <br>
parameters (?col1 - col ?tile1 ?tile2 - tile ?row1 ?row2 - row ?empty - tile) <br>
If two tiles ?tile1 ?tile2 are movable and are not the same tile type, have the same column coordinate ?col1, have adjacent row coordinates ?row1 ?row2 and make true a (magically-disappear ?tile1 ?tile2) predicate, then swap their row coordinates and and transform ?tile2 into the ‘empty’ tile X

4. swap-left-right-special <br>
parameters (?row1 - row ?t1 ?t2 - tile ?col1 ?col2 - col ?empty - tile) <br>
If two tiles ?tile1 ?tile2 are movable and are not the same tile type, have the same row coordinate ?row1, have adjacent column coordinates ?col1 ?col2 and make true a (magically-disappear ?tile1 ?tile2) predicate, then swap the column coordinates and transform ?tile2 into the ‘empty’ tile X

5. match-three-row <br> 
parameters (?tile1 - tile ?r1 - row ?c1 ?c2 ?c3 - col ?empty - tile) <br>
If three tiles of the same type ?t1 are not ‘empty’, have the same row coordinate ?row1, and their column coordinates ?col1 ?col2 ?col3 are adjacent two by two, then all three tiles are transformed into ‘empty’ tiles X

6. match-three-column <br> 
parameters (?t1 - tile ?col1 - col ?row1 ?row2 ?row3 - row ?empty - tile) <br>
If three tiles of the same type ?t1 are not ‘empty’, have the same column coordinate ?col1 two by two have adjacent row coordinates and are not the ‘empty’ tile, then all three tiles are transformed into ‘empty’ tiles X

### Problem Instances
In the current implementation, in each instance the goal state is to have the board composed only by _empty_ tiles.
The instances are three:
- 3x3 board

|G H G|<br>
|H H R|<br>
|R R G|<br>

- 4x3 board

|G H G|<br>
|H H S|<br>
|S S G|<br>
|R R R|<br>

- 4x4 board

|X S G H|<br>
|S H G R|<br>
|S H R G|<br>
|H H H R|<br>

## Planners
### ENHSP
ENHSP was cloned from the official Gitlab page (https://gitlab.com/enricos83/ENHSP-Public), it was compiled and installed by executing the ‘compile’ and ‘install’ files provided in the repository (./compile and ./install commands run in the root folder). The build generated the ‘enhsp’ executable, which was then called to launch the planner.
The PDDL files were pasted in a folder called ‘assignment’ inside the root folder.
ENHSP was then launched in its optimal version, which makes use of A<sup>*</sup> with h<sub>max</sub> heuristics and redundant constraints. To do so, the planner was run with the following commands in the root folder:

./enhsp -o pdd_files/domain.pddl -f pdd_files/prob1.pddl -planner opt<br>
./enhsp -o pdd_files/domain.pddl -f pdd_files/prob2.pddl -planner opt<br>
./enhsp -o pdd_files/domain.pddl -f pdd_files/prob3.pddl -planner opt<br>

### Fast Downward
FD was downloaded from the public Git repo (available at https://github.com/aibasel/downward) and it was built using the Cmake 3.19 GUI tool. As for ENHSP, the PDDL files were pasted inside the root folder in a folder called ‘assignment’. The planner was used with A<sup>*</sup> search along with landmark-cut heuristic. The launch commands are:

./fast-downward.py pdd_files/domain.pddl pdd_files/prob1.pddl --search “astar(lmcut())”<br>
./fast-downward.py pdd_files/domain.pddl pdd_files/prob2.pddl --search “astar(lmcut())”<br>
./fast-downward.py pdd_files/domain.pddl pdd_files/prob3.pddl --search “astar(lmcut())”<br>

## Analysis
The solution plans are analyzed in the summary tables here below. To better understand the behaviour of the planners, some metrics were used. In particular, the metrics of interest are:
- _solved_: if the problem was solved or not
- _T(s)_: total planning time in seconds
-  _Q_ - quality of the solution plan. It is measured as the number of actions required to solve the problem
-  _Q ratio_ - the quantity Q/Q*, where Q is the quality of the solution plan found by the considered planner and Q* is the best plan found among all planners
-  _Nodes expanded_
-  _Nodes evaluated_

### Problem 1

|       | Solved | T(s)  | Q | Q ratio | Nodes expanded | Nodes evaluated |
|-------|--------|-------|---|---------|----------------|-----------------|
| ENHSP | yes    | 1.205 | 6 | 1.0     | 223            | 619             |
| FD    | yes    | 0.006 | 6 | 1.0     | 9              | 52              |

### Problem 2

|       | Solved | T(s)   | Q  | Q ratio | Nodes expanded | Nodes evaluated |
|-------|--------|--------|----|---------|----------------|-----------------|
| ENHSP | yes    | 19.934 | 10 | 1.0     | 54189          | 146181          |
| FD    | yes    | 0.214  | 10 | 1.0     | 1003           | 5367            |

### Problem 3 

|       | Solved | T(s)    | Q  | Q ratio | Nodes expanded | Nodes evaluated |
|-------|--------|---------|----|---------|----------------|-----------------|
| ENHSP | yes    | 167.845 | 11 | 1.0     | 378261         | 985296          |
| FD    | yes    | 0.601   | 11 | 1.0     | 1454           | 10552           |

It is possible to notice that both planners solved all instances, with the same plan quality. However, FD expands and evaluates far fewer nodes and takes way less time than ENHSP.

## Conclusions
The project aims at developing a planning-based solution to the sliding-tile problem. 
For such purpose, the domain file along with the problem instances were implemented in PDDL.

The domain and problem instances were fed into two popular planners available in literature, namely ENHSP and Fast Downward.
Results show that both planners were able to find solution plans of the same quality. However, there is a remarkable gap in performance between the two.
In particular, Fast Downward outperformed ENHSP in planning time, nodex expanded and nodes evaluated.

Some areas of this project could be explored more in depth. 
Future developments could concern:
- solving instances with larger grids
- evaluating correlation between the grid size and the quality metrics
- comparing the performance of more planners
- changing the existing domain rules
- adding other domain rules

## References
planning.domains<br>
https://gitlab.com/enricos83/ENHSP-Public<br>
https://github.com/aibasel/downward<br>
... work in progress ...

## Purpose
This project was developed during the AI Planning module of the MSc course in Artificial Intelligence offered by University of Huddersfield. This project was not created for deployment into a production environment. Also, the software could contain bugs.


