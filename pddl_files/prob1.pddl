(define (problem CANDYCRUSH)
(:domain CANDYCRUSH)
(:objects   rA rB rC - row 
            c1 c2 c3 - col 
            G H R S X - tile)
(:init  (tile_at rA c1 G)  (tile_at rA c2 H)  (tile_at rA c3 G) 
        (tile_at rB c1 H)  (tile_at rB c2 H)  (tile_at rB c3 R)
        (tile_at rC c1 R)  (tile_at rC c2 R)  (tile_at rC c3 G)
        (adjacent-rows rA rB)
        (adjacent-rows rB rC) 
        (adjacent-columns c1 c2) 
        (adjacent-columns c2 c3)
        (empty X)
        (movable G)
        (movable H)
        (movable R)
        (movable S)
        
        (magically-disappear G S)

        )
        
(:goal (and 

(tile_at rA c1 X) (tile_at rA c2 X) (tile_at rA c3 X)
(tile_at rB c1 X) (tile_at rB c2 X) (tile_at rB c3 X)
(tile_at rC c1 X) (tile_at rC c2 X) (tile_at rC c3 X)

)

)
)
