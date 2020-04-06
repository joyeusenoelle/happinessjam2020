-- Fantasy Console Game Jam #5: Happiness
-- By Noelle Anthony, Maple Syrup, Millie, and Lindsay

playing = false
music_going = false

SPRITESIZE = 16
NPCHEIGHT = 24

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
pl.dir = 1
pl.cbox = {pl.x, pl.x + pl.width, pl.y + pl.height - 8, pl.y + pl.height}
pl.ibox = {pl.cbox[0] - 2, pl.cbox[1] + 2, pl.cbox[2] - 2, pl.cbox[3] + 2}

actors = {}

function calculateboxes(ent)
    ent.cbox = {ent.x, ent.x + ent.width, ent.y + ent.height - 8, ent.y + ent.height}
    ent.ibox = {ent.cbox[0] - 2, ent.cbox[1] + 2, ent.cbox[2] - 2, ent.cbox[3] + 2}
end

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

-- horiz and vert should each be one of (-1, 0, 1)
function jostle(ent, horiz, vert)
    ent.x = ent.x + horiz
    ent.y = ent.y + vert
    calculateboxes(ent)
end

-- ent is the entity that's moving
-- dctn is one of LEFT, RIGHT, UP, or DOWN
-- TODO: change this so that it's arbitrary, but
-- the top half of the sprite is "transparent"
function move(ent, dctn)
    colliding = 0 
    if dctn == LEFT then
        clsns = {}
        for i in ent.cbox[2], ent.cbox[3], 1 do
            if not iswalkable(ent.cbox[0]-1, i) then
                table.insert(clsns, 1)
            else
                table.insert(clsns, 0)
            end
        end
        c = 0
        for j in clsns do
            c = c + j
        end
        if j == 1 then
            if clsns[1] == 1 then
                jostle(ent, -1, 1)
            else if clsns[8] == 1 then
                jostle(ent, -1, -1)
            end
        end
        if j == 0 then
            jostle(ent, -1, 0)
        end
    else if dctn = RIGHT then
        clsns = {}
        for i in ent.cbox[2], ent.cbox[3], 1 do
            if not iswalkable(ent.cbox[1]+1, i) then
                table.insert(clsns, 1)
            else
                table.insert(clsns, 0)
            end
        end
        c = 0
        for j in clsns do
            c = c + j
        end
        if j == 1 then
            if clsns[1] == 1 then
                jostle(ent, 1, 1)
            else if clsns[8] == 1 then
                jostle(ent, 1, -1)
            end
        end
        if j == 0 then
            jostle(ent, 1, 0)
        end
    else if dctn = UP then
        clsns = {}
        for i in ent.cbox[0], ent.cbox[1], 1 do
            if not iswalkable(i, ent.cbox[2] - 1) then
                table.insert(clsns, 1)
            else
                table.insert(clsns, 0)
            end
        end
        c = 0
        for j in clsns do
            c = c + j
        end
        if j == 1 then
            if clsns[1] == 1 then
                jostle(ent, 1, -1)
            else if clsns[16] == 1 then
                jostle(ent, -1, -1)
            end
        end
        if j == 0 then
            jostle(ent, 0, -1)
        end
    else if dctn = DOWN then
        clsns = {}
        for i in ent.cbox[0], ent.cbox[1], 1 do
            if not iswalkable(i, ent.cbox[3] + 1) then
                table.insert(clsns, 1)
            else
                table.insert(clsns, 0)
            end
        end
        c = 0
        for j in clsns do
            c = c + j
        end
        if j == 1 then
            if clsns[1] == 1 then
                jostle(ent, 1, 1)
            else if clsns[16] == 1 then
                jostle(ent, -1, 1)
            end
        end
        if j == 0 then
            jostle(ent, 0, 1)
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


