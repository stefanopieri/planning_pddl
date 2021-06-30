(define (problem CANDYCRUSH)
(:domain CANDYCRUSH)
(:objects   rA rB rC rD - row 
            c1 c2 c3 c4 - col 
            G H R S X - tile)
    (:init
        (tile_at rA c1 X)  (tile_at rA c2 S)  (tile_at rA c3 G)  (tile_at rA c4 H)
        (tile_at rB c1 S)  (tile_at rB c2 H)  (tile_at rB c3 G)  (tile_at rB c4 R)
        (tile_at rC c1 S)  (tile_at rC c2 H)  (tile_at rC c3 R)  (tile_at rC c4 G)
        (tile_at rD c1 H)  (tile_at rD c2 H)  (tile_at rD c3 H)  (tile_at rD c4 R)
        (adjacent-rows rA rB)
        (adjacent-rows rB rC) 
        (adjacent-rows rC rD) 
        (adjacent-columns c1 c2) 
        (adjacent-columns c2 c3)
        (adjacent-columns c3 c4)
        
        (empty X)
        
        (movable G)
        (movable H)
        (movable R)
        (movable S)
        
        (magically-disappear G S)

        )
        
(:goal (and 
        (tile_at rA c1 X)  (tile_at rA c2 X)  (tile_at rA c3 X)  (tile_at rA c4 X)
        (tile_at rB c1 X)  (tile_at rB c2 X)  (tile_at rB c3 X)  (tile_at rB c4 X)
        (tile_at rC c1 X)  (tile_at rC c2 X)  (tile_at rC c3 X)  (tile_at rC c4 X)
        (tile_at rD c1 X)  (tile_at rD c2 X)  (tile_at rD c3 X)  (tile_at rD c4 X) )
)
)

