-- Fantasy Console Game Jam #5: Happiness
-- By Noelle Anthony, Maple Syrup, Millie, and Lindsay

playing = false
music_going = false

pl = {}
pl.moving = false
pl.x = 0
pl.y = 0
pl.sprite = 0
pl.bsprite
pl.speed = 1
pl.dir = 0
pl.width = 8
pl.height = 8

function move()
    pl.moving = true
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
end

function _update()
    -- run every frame
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
        if btn(5) then
            playing=true
        end
    else
        cls()
        -- do stuff
    end
end


