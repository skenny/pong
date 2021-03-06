#!/usr/bin/env ruby

require 'rubygems'
require 'rubygame'
require 'background.rb'
require 'paddle.rb'
require 'ball.rb'
require 'text.rb'

# prep fonts
Rubygame::TTF.setup

=begin

    Pong, from rubygame tutorial:
        http://manwithcode.com/making-games-with-ruby/
        http://devel.manwithcode.com/making-games-with-ruby.html

=end

class Game

    def initialize
        # [x, y], depth, flags
        # HWSURFACE = hardware accelerated if available
        @screen = Rubygame::Screen.new([640,480], 0, [Rubygame::HWSURFACE, Rubygame::DOUBLEBUF])
        @screen.title = "P0NG"
        
        @queue = Rubygame::EventQueue.new
        
        @clock = Rubygame::Clock.new
        # fps - if not capped, the game will go as fast as possible
        @clock.target_framerate = 60
        
        @background = Background.new(@screen.width, @screen.height)
        
        # calculate movement limits for player & ball game objects
        borderPx = @background.lineWidth
        x_lowLimit = y_lowLimit = borderPx
        x_highLimit = @screen.width - borderPx
        y_highLimit = @screen.height - borderPx

        @player1 = Paddle.new(50, 10, @screen.width*0.20, 35, Rubygame::K_W, Rubygame::K_S, y_lowLimit, y_highLimit)
        @player2 = Paddle.new(@screen.width-50-@player1.width, 10, @screen.width*0.70, 35, Rubygame::K_UP, Rubygame::K_DOWN, y_lowLimit, y_highLimit)
        @player1.center_y(@screen.height)
        @player2.center_y(@screen.height)
        
        @ball = Ball.new(@screen.width/2, @screen.height/2, x_lowLimit, x_highLimit, y_lowLimit, y_highLimit)
    end

    def run!
        loop do
            update
            draw
            @clock.tick
        end
    end

    def update
        @player1.update
        @player2.update
        @ball.update(@screen, @player1, @player2)
    
        @queue.each do |event|
            @player1.handle_event(event)
            @player2.handle_event(event)
            @ball.handle_event(event)
            
            case event
                when Rubygame::KeyDownEvent
                    # wire ESC to quit
                    if event.key == Rubygame::K_ESCAPE
                        @queue.push(Rubygame::QuitEvent.new)
                    end
                # close window button / ALT+F4
                when Rubygame::QuitEvent
                    Rubygame.quit
                    exit
            end
        end
        
        if collision?(@ball, @player1)
            @ball.collision(@player1, @screen)
        elsif collision?(@ball, @player2)
            @ball.collision(@player2, @screen)
        end
    end

    def draw
        # [r, g, b]
        # fill() is unnecessary here, as @background fills the window
        @screen.fill([0, 0, 0])
        
        # draw from the bottom up!
        @background.draw(@screen)
        @player1.draw(@screen)
        @player2.draw(@screen)
        @ball.draw(@screen)
        
        # drawing is done "off-screen", so we have to flip() it into view
        @screen.flip
    end

    def collision?(obj1, obj2)
        # if the bottom of obj1 is higher than the top of obj2
        if (obj1.y + obj1.height < obj2.y)
            return false
        end
        
        # if the top of obj1 is lower than the bottom of obj2
        if (obj1.y > obj2.y + obj2.height)
            return false
        end
        
        # if the right of obj1 is to the right of the right of obj2
        if (obj1.x + obj1.width < obj2.x)
            return false
        end
        
        # if the left of obj1 is to the right of the right of obj2
        if (obj1.x > obj2.x + obj2.width)
            return false
        end
        
        return true
    end

end

# fire it up
Game.new.run!

