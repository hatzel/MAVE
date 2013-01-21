function love.load()
	love.physics.setMeter(64)
	world = love.physics.newWorld(0, 9.81*64, true)

objects = {}
    objects.ground = {}
        objects.ground.body = love.physics.newBody(world, 1000/2, 530)
        objects.ground.shape = love.physics.newRectangleShape(1050, 0)
        objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)

    objects.ceiling = {}
        objects.ceiling.body = love.physics.newBody(world, 1000/2, -600)
        objects.ceiling.shape = love.physics.newRectangleShape(1050, 0)
        objects.ceiling.fixture = love.physics.newFixture(objects.ceiling.body, objects.ceiling.shape)

    objects.sideleft = {}
        objects.sideleft.body = love.physics.newBody(world, 1000, 0)
        objects.sideleft.shape = love.physics.newRectangleShape(0, 1250)
        objects.sideleft.fixture = love.physics.newFixture(objects.sideleft.body, objects.sideleft.shape)

    objects.sideright = {}
        objects.sideright.body = love.physics.newBody(world, 0, 0)
        objects.sideright.shape = love.physics.newRectangleShape(0, 1250)
        objects.sideright.fixture = love.physics.newFixture(objects.sideright.body, objects.sideright.shape)

    objects.cutie1 = {}
        objects.cutie1.body = love.physics.newBody(world, 333, 400, "dynamic")
        objects.cutie1.shape = love.physics.newCircleShape( 20) 
        objects.cutie1.fixture = love.physics.newFixture(objects.cutie1.body, objects.cutie1.shape, 1) -- Attach fixture to body and give it a density of 1.
        objects.cutie1.fixture:setRestitution(1) 
        objects.cutie1.life = 100
        objects.cutie1.cuteness = 1
        objects.cutie1.mobbelligkeit = 1

    objects.cutie2 = {}
        objects.cutie2.body = love.physics.newBody(world, 666, 380, "dynamic")
        objects.cutie2.shape = love.physics.newCircleShape( 20) 
        objects.cutie2.fixture = love.physics.newFixture(objects.cutie2.body, objects.cutie2.shape, 1)
        objects.cutie2.fixture:setRestitution(1.0) 
        objects.cutie2.life = 100
        objects.cutie2.cuteness = 1
        objects.cutie2.mobbelligkeit = 1

        love.graphics.setMode(1000, 600, false, true, 0)

        background = love.graphics.newImage('gfx/arena.png')
        cutie1 = love.graphics.newImage('gfx/cutie-0.png')
        cutie2 = love.graphics.newImage('gfx/cutie-1.png')
        bgmenu = love.graphics.newImage('gfx/bambus.png')
        
        dtotal = 0
end

function love.update(dt)
     world:update(dt)
   dtotal = dtotal + dt  

   if dtotal >= 1 then

      dtotal = -dtotal

   end
end


function love.draw() 

    if objects.cutie1.life > 0 and objects.cutie2.life > 0 then

    love.graphics.draw(background, 0, 0)
    love.graphics.draw(cutie1, objects.cutie1.body:getX(), objects.cutie1.body:getY(), 0, 0.3, 0.3)
    love.graphics.draw(cutie2, objects.cutie2.body:getX(), objects.cutie2.body:getY(), 0, 0.3, 0.3)

    -- love.graphics.setColor(50, 50, 50)
    -- love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
    -- love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))

    if objects.cutie1.body:getX() < objects.cutie2.body:getX() then
        objects.cutie1.body:applyForce( 100, 5)
        objects.cutie2.body:applyForce( -100, 5)
    end

    if objects.cutie2.body:getX() < objects.cutie1.body:getX() then
        objects.cutie2.body:applyForce( 100, 5)
        objects.cutie1.body:applyForce( -100, 5)
    end

    if objects.cutie2.body:getY() < 545 then
        objects.cutie2.body:applyLinearImpulse( 0, 5)
    end

    if objects.cutie1.body:getY() < 545 then
       objects.cutie1.body:applyLinearImpulse( 0, 5)
    end

    if math.abs(objects.cutie1.body:getY() - objects.cutie2.body:getY()) < 35 and math.abs(objects.cutie1.body:getX() - objects.cutie2.body:getX()) < 35 then
        objects.cutie2.body:applyLinearImpulse( math.random(100, 200), math.random(50, 110))
        objects.cutie1.body:applyLinearImpulse( math.random(100, 200), math.random(50, 110))
        objects.cutie2.life = objects.cutie2.life - math.random(5) * objects.cutie1.cuteness
        objects.cutie1.life = objects.cutie1.life - math.random(5) * objects.cutie2.cuteness
    end

elseif objects.cutie1.life <= 0 and objects.cutie2.life <= 0 then


    if objects.cutie1.life <= 0 then

        love.graphics.draw(bgmenu, 0, 0)

    elseif objects.cutie2.life <= 0 then

        love.graphics.draw(bgmenu, 0, 0)

    elseif objects.cutie1.life <= 0 and objects.cutie2.life <= 0 then

        love.graphics.draw(bgmenu, 0, 0)

    end
end


end