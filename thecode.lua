-- Fantasy Console Game Jam #5: Happiness
-- By Noelle Anthony, Maple Syrup, Millie, and Lindsay

playing = false
music_going = false

SPRITESIZE = 16

LEFT  = {-1,0}
RIGHT = {1,0}
UP    = {0,-1}
DOWN  = {0,1}

pl = {}
pl.moving = false
pl.x = 0
pl.y = 0
pl.height = 16
pl.width = 16
pl.sprite = 0
pl.bsprite
pl.speed = 1
pl.dir = 0
pl.width = 16
pl.height = 16
pl.top = pl.y + pl.height - 8
pl.bottom = pl.y + pl.height
pl.right = pl.x + pl.width

actors = {}

function addactor(ent)
    table.insert(actors, ent)
end

function iswalkable(x, y)
    s = mget(x,y)
    if fget(s, 0) then -- the first flag set on a sprite determines whether it's walkable
        return true
    end
    return false
end

-- ent is the entity that's moving
-- dctn is one of LEFT, RIGHT, UP, or DOWN
-- TODO: change this so that it's arbitrary, but
-- the top half of the sprite is "transparent"
function move(ent, dctn) 
    if ent.moving == false then
        tarx = ent.x + dctn[0]*SPRITESIZE
        tary = ent.y + dctn[1]*SPRITESIZE
        if iswalkable(tarx, tary) then
            ent.moving = true
            ent.tarx = tarx
            ent.tary = tary
            ent.movedctn = dctn
        end
    end
    -- do things here
end

function collision_event(a1, a2)
    -- the player (a1) has collided with something (a2)!
end

function collide(a1, a2)
    if a1 == a2 then return end
    local dx == a1.x - a2.x
    local dy == a1.y - a2.y
    if (abs(dx) < a1.width + a2.width) then 
        if (abs(dy) < a1.height + a2.height) then
            collision_event(a1, a2)
        end
    end
end

function collisions()
    -- add collidable elements
    for a1 in all({}) do
        collide(pl, a1)
    end
end

function _init()
    -- do init things
    -- make the collection of actors
    addactor(pl)
end

function _update()
    -- run every frame
    for a1 in all(actors) do
        a1.top = a1.y + a1.height - 8
        a1.bottom = a1.y + a1.height
        a1.right = a1.x + a1.width
        a1.left = a1.x
    end
    pl.top = pl.x + pl.height - 8
    if pl.moving then
        pl.x = pl.x + pl.movedctn[0]
        pl.y = pl.y + pl.movedctn[1]
        if pl.x == pl.tarx and pl.y == pl.tary then
            pl.moving = false
        end
    else
        if btn(0) then move(pl, LEFT) end
        if btn(1) then move(pl, RIGHT) end
        if btn(2) then move(pl, UP) end
        if btn(3) then move(pl, DOWN) end
    end
end

function _draw()
    if playing == false then
        cls()
        cursor(7,2)
        print("It is a beautiful day")
        print("in the village and you") 
        print("are an AI who has been")
        print("sent out to discover")
        print("the meaning of")
        print("KINDNESS.")
        print("Press Z to start!")
        if btn(5) then
            playing=true
        end
    else
        cls()
        -- do stuff
    end
end


