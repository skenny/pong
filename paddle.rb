#!/usr/bin/env ruby

require 'gameobject.rb'

class Paddle < GameObject

    @@movementSpeed = 5

    def initialize(x, y, upKey, downKey, y_upLimit, y_downLimit)
        #puts "constructing paddle(#{x}, #{y}, #{upKey}, #{downKey}, #{y_upLimit}, #{y_downLimit})"
    
        surface = Rubygame::Surface.new([20, 100])
        surface.fill([255, 255, 255])
        
        @upKey = upKey
        @downKey = downKey
        
        @y_upLimit = y_upLimit
        @y_downLimit = y_downLimit
        
        @movingUp = false
        @movingDown = false
        
        super(x, y, surface)
    end

    def center_y(h)
        @y = h/2-@height/2
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

end

