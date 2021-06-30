(define (domain CANDYCRUSH)
  (:requirements :strips)
  (:types row col tile)
  (:predicates (tile_at ?r - row ?c - col ?t - tile) 
  (adjacent-rows ?row1  ?row2 - row)
  (adjacent-columns ?col1  ?col2 - col) 
  (empty ?t - tile) 
  (movable ?t - tile)
  (magically-disappear ?g ?s - tile)
	       )

  (:action swap-up-down
	     :parameters (?col - col 
			?t1 ?t2 - tile 
			?row1 ?row2 - row)
	     
	     :precondition (and 
	     ; linking the tiles to their coordinates 
	     (tile_at ?row1 ?col ?t1 ) 
	     (tile_at ?row2 ?col ?t2 )
	     
	     ; switch up-down on the same column and for adjacent rows
	     (adjacent-rows ?row1 ?row2)
	     
	     ; swapped tiles must ben different (ex. G with G not allowed) and move only movable tiles (so to exclude the empty tile)
	     (not (= ?t1 ?t2))
	     (movable ?t1)
	     (movable ?t2)
	     
	     ; G - S interactions are treated differently
	     (not (magically-disappear ?t1 ?t2)) 
	     (not (magically-disappear ?t2 ?t1))
	     )
	     
	     :effect
	     (and 
	     (tile_at ?row2 ?col ?t1)
		 (tile_at ?row1 ?col ?t2)
		 (not (tile_at ?row1 ?col ?t1 ))
		 (not (tile_at ?row2 ?col ?t2 )))
    )

 (:action swap-left-right
	     
	     :parameters (?row1 - row 
			?t1 ?t2 - tile 
			?col1 ?col2 - col)
	     
	     :precondition (and 
	     ; linking the tiles to their coordinates 
	     (tile_at ?row1 ?col1 ?t1 ) 
	     (tile_at ?row1 ?col2 ?t2 )
	     
	     ; switch left-right on the same row and for adjacent columns
	     (adjacent-columns ?col1 ?col2)
	     
	     ; do not switch the same tile (G with G) and move only movable tiles
	     (not (= ?t1 ?t2))
	     (movable ?t1)
	     (movable ?t2)
	     
	     ; G and S are treated differently
	     (not (magically-disappear ?t1 ?t2)) 
	     (not (magically-disappear ?t2 ?t1))
	     )
	     
	     :effect
	     (and 
	     (tile_at ?row1 ?col2 ?t1)
		 (tile_at ?row1 ?col1 ?t2)
		 (not (tile_at ?row1 ?col1 ?t1 ))
		 (not (tile_at ?row1 ?col2 ?t2 )))
    )


 (:action swap-up-down-special
	     :parameters (?col1 - col 
			?t1 ?t2 - tile    
	     		?row1 ?row2 - row
	     		?empty - tile)
	     
	     :precondition (and 
	     
	     ; action that deals with G and S 
	     (magically-disappear ?t1 ?t2)
	     
	     ; move only movable and different tiles
	     (not (= ?t1 ?t2))
	     (movable ?t1)
	     (movable ?t2)
	     
	     ; linking the tiles to their coordinates 
	     (tile_at ?row1 ?col1 ?t1 ) 
	     (tile_at ?row2 ?col1 ?t2 )
	     
	     ; switch up-down on the same column and for adjacent rows
	     (adjacent-rows ?row1 ?row2)
	     
	     ; do not switch the same tile (G with G) and a tile with an empty tile (G with X)
	     (empty ?empty)
	     )
	     
	     :effect
	     (and 
	     (tile_at ?row2 ?col1 ?t1)
		 (tile_at ?row1 ?col1 ?empty)
		 (not (tile_at ?row1 ?col1 ?t1 ))
		 (not (tile_at ?row2 ?col1 ?t2 )))


    ); end switch G-S action


(:action swap-left-right-special
    
	     :parameters (?row1 - row 
			 ?t1 ?t2 - tile   
	                  ?col1 ?col2 - col
	                  ?empty - tile)
	     
	     :precondition (and 
	     
	     ; action that deals with G and S 
	     (magically-disappear ?t1 ?t2)
	     
	     ; move only movable and different tiles
	     (not (= ?t1 ?t2))
	     (movable ?t1)
	     (movable ?t2)
	     
	     ; linking the tiles to their coordinates 
	     (tile_at ?row1 ?col1 ?t1 ) 
	     (tile_at ?row1 ?col2 ?t2 )
	     
	     ; switch left-right on the same row and for adjacent columns
	     (adjacent-columns ?col1 ?col2)
	     
	     ; do not switch the same tile (ex. G with G) and a tile with an empty tile (ex. G with X)
	     (empty ?empty)
	     )
	     
	     :effect
	     (and 
	     (tile_at ?row1 ?col2 ?t1)
		 (tile_at ?row1 ?col1 ?empty)
		 (not (tile_at ?row1 ?col1 ?t1 ))
		 (not (tile_at ?row1 ?col2 ?t2 )))
    

); end G-s left right action



(:action match-three-row
    
    :parameters (?t1 - tile 
		?r1 - row 
		?c1 ?c2 ?c3 - col
                 ?empty - tile)
                
                
    :precondition(and
    
    ;linking tiles with coordinates
    (tile_at ?r1 ?c1 ?t1)
    (tile_at ?r1 ?c2 ?t1)
    (tile_at ?r1 ?c3 ?t1)

    
    ;if the columns are adjacent
    (adjacent-columns ?c1 ?c2)
    (adjacent-columns ?c2 ?c3)
    
    ;if the tiles are the same type and movable
    (movable ?t1)
    (empty ?empty)
    
    
    )
    
    
    :effect(and
    
    (tile_at ?r1 ?c1 ?empty)
    (tile_at ?r1 ?c2 ?empty)
    (tile_at ?r1 ?c3 ?empty)
    
    (not (tile_at ?r1 ?c1 ?t1))
    (not (tile_at ?r1 ?c2 ?t1))
    (not (tile_at ?r1 ?c3 ?t1))
    )
    
    ) ; action free-row close


(:action match-three-column
    
    :parameters (?t1 - tile 
		?c1 - col 
		?r1 ?r2 ?r3 - row 
                 ?empty - tile)
                
                
    :precondition(and
    
    ;linking tiles with coordinates
    (tile_at ?r1 ?c1 ?t1)
    (tile_at ?r2 ?c1 ?t1)
    (tile_at ?r3 ?c1 ?t1)
    
    
    ;if the columns are adjacent
    (adjacent-rows ?r1 ?r2)
    (adjacent-rows ?r2 ?r3)
    
    ;if the tiles are the same type and movable
    (movable ?t1)
    (empty ?empty)
    
    ) ; precondition close
    
    
    :effect(and
    
    (tile_at ?r1 ?c1 ?empty)
    (tile_at ?r2 ?c1 ?empty)
    (tile_at ?r3 ?c1 ?empty)
    
    (not (tile_at ?r1 ?c1 ?t1))
    (not (tile_at ?r2 ?c1 ?t1))
    (not (tile_at ?r3 ?c1 ?t1))
    ) ; effect close
    
    ) ; action free-column close


)


