#!/usr/bin/env ruby

require 'gameobject.rb'

class Paddle < GameObject

    @@movementSpeed = 5

    def initialize(x, y, score_x, score_y, upKey, downKey, y_upLimit, y_downLimit)
        #puts "constructing paddle(#{x}, #{y}, #{upKey}, #{downKey}, #{y_upLimit}, #{y_downLimit})"
    
        surface = Rubygame::Surface.new([20, 100])
        surface.fill([255, 255, 255])
        
        @upKey = upKey
        @downKey = downKey
        
        @y_upLimit = y_upLimit
        @y_downLimit = y_downLimit
        
        @movingUp = false
        @movingDown = false
        
        @score = 0
        @scoreText = Text.new(score_x, score_y, @score.to_s, 48)
        
        super(x, y, surface)
    end

    def handle_event(event)
        #puts "event: #{event}"
        case event
            when Rubygame::KeyDownEvent then
                #puts "pressed #{event.key}..."
                if event.key == @upKey
                    @movingUp = true
                elsif event.key == @downKey
                    @movingDown = true
                end
            when Rubygame::KeyUpEvent then
                #puts "released #{event.key}..."
                if event.key == @upKey
                    @movingUp = false
                elsif event.key == @downKey
                    @movingDown = false
                end
        end
    end

    def update
        if @movingUp and @y > @y_upLimit
            @y -= @@movementSpeed
        end
        if @movingDown and @y < @y_downLimit-@height
            @y += @@movementSpeed
        end
    end

    def draw(screen)
        super(screen)
        @scoreText.draw(screen)
    end

    def center_y(h)
        @y = h/2-@height/2
    end

    def score
        @score
    end
    
    def score=(n)
        @score = n
        @scoreText.text = @score.to_s
    end

end

