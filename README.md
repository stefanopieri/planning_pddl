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

### Domain
In the current implementation, four PDDL files were created, one for the domain and three for the problem instances. The domain is composed of six actions, which make use of three types and six predicates. The types are:
   
1. tile - the tile type. It can take one value among the set (G, S, R, H, X), with X representing the ‘empty’ tile
2. row - the row coordinate of the position of the tile on the board
3. column - the column coordinate of the position of the tile on the board

The predicates are:
1. tile_at ?row ?col ?tile - links the tile type ?tile to its row and column coordinates ?row
?col
2. adjacent-rows ?row1 ?row2 - whether the two rows ?row1 and ?row2 are adjacent
3. adjacent-columns ?col1 ?col2 - whether the two columns ?col1 and ?col2 are adjacent
4. movable ?tile - whether a tile type can be moved or not. This predicate was introduced as it is asked that the types S, G, R, H should move while the empty tile X should not
5. empty ?tile - true if ?tile is the empty tile
6. magically-disappears ?tile1 ?tile2 - This predicate links the two tiles ?tile1 and ?tile2. It is used to encode the required condition of S becoming ‘empty’ once switched with G for magical reasons and it is used within the swap-up-down-special and swap-left-right-special actions.
The actions of the domain are the following:
1. swap-up-down parameters (?col - col ?tile1 ?tile2 - tile ?row1 ?row2 - row)
If two tiles ?tile1 ?tile2 are movable and are not the same tile type, have the same column coordinate ?col, have adjacent row coordinates ?row1 ?row2 and their types do not make true a (magically-disappear ?tile1 ?tile2) predicate, their row coordinates are swapped

 2. swap-left-right parameters (?row1 - row ?tile1 ?tile2 - tile
?col1 ?col2 - col)
If two tiles ?tile1 ?tile2 are movable and are not the same tile type, have the same row coordinate ?row1, have adjacent column coordinates ?col1 ?col2 and their types do not make true a (magically-disappear ?tile1 ?tile2) predicate, their column coordinates are swapped
3. swap-up-down-special parameters (?col1 - col ?tile1 ?tile2 - tile
?row1 ?row2 - row ?empty - tile)
If two tiles ?tile1 ?tile2 are movable and are not the same tile type, have the same column coordinate ?col1, have adjacent row coordinates ?row1 ?row2 and make true a (magically-disappear ?tile1 ?tile2) predicate, then swap their row coordinates and and transform ?tile2 into the ‘empty’ tile X
4. swap-left-right-special parameters (?row1 - row ?t1 ?t2 - tile
?col1 ?col2 - col
?empty - tile)
If two tiles ?tile1 ?tile2 are movable and are not the same tile type, have the same row coordinate ?row1, have adjacent column coordinates ?col1 ?col2 and make true a (magically-disappear ?tile1 ?tile2) predicate, then swap the column coordinates and transform ?tile2 into the ‘empty’ tile X
5. match-three-row - parameters (?tile1 - tile ?r1 - row
?c1 ?c2 ?c3 - col ?empty - tile)
If three tiles of the same type ?t1 are not ‘empty’, have the same row coordinate ?row1, and their column coordinates ?col1 ?col2 ?col3 are adjacent two by two, then all three tiles are transformed into ‘empty’ tiles X
6. match-three-column parameters (?t1 - tile ?col1 - col ?row1 ?row2 ?row3 - row ?empty - tile)
If three tiles of the same type ?t1 are not ‘empty’, have the same column coordinate ?col1 two by two have adjacent row coordinates and are not the ‘empty’ tile, then all three tiles are transformed into ‘empty’ tiles X

### Problem Instances

## Planners
### ENHSP

### Fast Downward

## Analysis

## Conclusions

## References

## Purpose
