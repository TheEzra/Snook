require('game')

window_w=600
window_h=600

local font = love.graphics.newFont( "04B_19__.ttf", 12 * 1 )
love.graphics.setFont(font)

local gameendfont = love.graphics.newFont( "04B_19__.ttf", 12 * 3 )

interval = 15

function love.load()
    add_apple()
end

function love.draw()
    game_draw()
    if state==GameState.game_over then
        love.graphics.setFont(gameendfont)
        love.graphics.print("Game over!", window_w/3, 200, 0, 1, 1, 0, 0, 0, 0)
        love.graphics.print("Press [SPACE] to restart!", window_w/8, 350, 0, 1, 1, 0, 0, 0, 0)
    end
end

function love.update()
    if state == GameState.running then
        interval=interval-1
        if interval<0 then
          game_update()
          interval=15
        end
        playgamemusic()
    end

    if state == GameState.game_over then
        stopgamemusic()
    end
end


function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
       love.event.quit()
    elseif key == "space" and state == GameState.game_over then
        state=GameState.running
        snake.x = SIZE/2
        snake.y = SIZE/2
        tail_len={ }
        tail = {}
        love.graphics.setFont(font)
    elseif key == "w" then
        up=true
        down=false
        left=false
        right=false
    elseif key == "s" then
        down=true
        up=false
        left=false
        right=false
    elseif key == "a" then
        left=true
        right=false
        up=false
        down=false
    elseif key == "d" then
       right=true
       left=false
       up=false
       down=false

    end
 end