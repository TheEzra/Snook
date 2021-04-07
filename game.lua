GameState={pause="pause", running="running", game_over="game over"}
state = GameState.running

music = {
    get_apple = love.audio.newSource("apple-get.wav", "static"),
    dead_snake = love.audio.newSource("snake-die.wav", "static"),
    game_pause = love.audio.newSource("game-pause.wav", "static"),
    game_music = love.audio.newSource("happynes.mp3", "stream")
}

music.game_music:setVolume(0.5)

snake={
    x=15,
    y=15,
    w=30,
    h=30,
    rx=10,
    ry=10,
    xdir=0,
    ydir=0,
    tail_len=0
}

tail = {}

SIZE=24

apple = {
    x=0,
    y=0,
    w=30,
    h=30,
    rx=10,
    ry=10
}

up=false
down=false
left=false
right=false

function add_apple() -- adds apple in random pos
    math.randomseed(os.time())
    apple.x=math.random(SIZE-1)
    apple.y=math.random(SIZE-2)
end

function game_draw() -- draw snake head
    fps = love.timer.getFPS()

    love.graphics.setColor(0,1,0,1)
    love.graphics.rectangle('fill', snake.x*SIZE, snake.y*SIZE, snake.w, snake.h, snake.rx, snake.ry)

    love.graphics.setColor(0,1,0,1) --draw tail
    for _, v in ipairs(tail) do
        love.graphics.rectangle('fill', v[1]*SIZE, v[2]*SIZE, snake.w, snake.h, 0, 0)
    end

    love.graphics.setColor(1,0,0, 0.8) --draw apple
    love.graphics.rectangle('fill', apple.x*SIZE, apple.y*SIZE, apple.w, apple.h, apple.rx, apple.ry)

    if state==GameState.running then
        love.graphics.setColor(1,1,1,1) --draw text
     love.graphics.print('Fps: '.. fps, 10, 50, 0, 1.5, 1.5)

     love.graphics.setColor(1,1,1,1) --draw text
     love.graphics.print('Score: '.. snake.tail_len, 10, 10, 0, 1.5, 1.5)
    end
end

function game_update()
    if up then
        snake.xdir, snake.ydir=0,-1
    elseif down then
        snake.xdir, snake.ydir=0,1
    elseif left then
        snake.xdir, snake.ydir=-1,0
    elseif right then
        snake.xdir, snake.ydir=1,0
    end

    local oldx=snake.x
    local oldy=snake.y

    snake.x=snake.x+snake.xdir
    snake.y=snake.y+snake.ydir

    if snake.x==apple.x and snake.y==apple.y then
        add_apple()
        snake.tail_len = snake.tail_len+1
        table.insert(tail, {0, 0})
        music.get_apple:play()
    end

    if snake.x < 0 then
        state=GameState.game_over
        music.dead_snake:play()
    elseif snake.x > SIZE-1 then
        state=GameState.game_over
        music.dead_snake:play()
    end

    if snake.y < 0 then
        state=GameState.game_over
        music.dead_snake:play()
    elseif snake.y > SIZE-1 then
        state=GameState.game_over
        music.dead_snake:play()
    end

    if snake.tail_len > 0 then
        for _, v in ipairs(tail) do
            local x,y = v[1], v[2]
            v[1], v[2] = oldx, oldy
            oldx, oldy = x, y
        end
    end

    for _, v in ipairs(tail) do
        if snake.x == v[1] and snake.y == v[2] then
            state = GameState.game_over
            music.dead_snake:play()
        end
    end
end

function playgamemusic()
    if state==GameState.running then
        music.game_music:play()
    end
end

function stopgamemusic()
    music.game_music:stop()
end