#!/usr/bin/env ruby

require 'gameobject.rb'

class Ball < GameObject

    def initialize(x, y, x_lowLimit, x_highLimit, y_lowLimit, y_highLimit)
        surface = Rubygame::Surface.load("ball.png")

        @x_lowLimit = x_lowLimit
        @x_highLimit = x_highLimit
        @y_lowLimit = y_lowLimit
        @y_highLimit = y_highLimit
        
        # default x, y velocities
        @vx = @vy = 5
        
        super(x, y, surface)
    end

    def update
        @x += @vx
        @y += @vy
        
        if @x <= @x_lowLimit or @x+@width >= @x_highLimit
            @vx *= -1
        end
        
        if @y <= @y_lowLimit or @y+@height >= @y_highLimit
            @vy *= -1
        end        
    end

end

