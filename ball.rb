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

    def update(screen, player1, player2)
        @x += @vx
        @y += @vy
        
        if @x <= @x_lowLimit
            player2.score += 1
            score(screen)
        end
        
        if @x+@width >= @x_highLimit
            player1.score += 1
            score(screen)
        end
        
        if @y <= @y_lowLimit or @y+@height >= @y_highLimit
            @vy *= -1
        end        
    end

    def score(screen)
        @vx *= -1
        
        @x = screen.width/4 + rand(screen.width/2)
        @y = rand(screen.height-50)+25
    end

    def collision(obj, screen)
        # TODO get rid of the screen ref, there must be a nicer way to do this
        
        if (obj.x < screen.width/2)
            # left paddle
            unless @x < obj.x-5
                @x = obj.x + obj.width + 1
                @vx *= -1
            end
        else
            # right paddle
            unless @x > obj.x+5
                @x = obj.x - @width-1
                @vx *= -1
            end
        end
    end

end

