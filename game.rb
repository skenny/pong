#!/usr/bin/env ruby

require 'rubygems'
require 'rubygame'
require 'background.rb'
require 'paddle.rb'

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
        
        wallThickness = 10
        y_upLimit = wallThickness
        y_downLimit = @screen.height - wallThickness
        @player1 = Paddle.new(50, 10, Rubygame::K_W, Rubygame::K_S, y_upLimit, y_downLimit)
        @player1.center_y(@screen.height)
        
        @player2 = Paddle.new(@screen.width-50-@player1.width, 10, Rubygame::K_UP, Rubygame::K_DOWN, y_upLimit, y_downLimit)
        @player2.center_y(@screen.height)
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
    
        @queue.each do |event|
            @player1.handle_event(event)
            @player2.handle_event(event)
            
            case event
                # close window button / ALT+F4
                when Rubygame::QuitEvent
                    Rubygame.quit
                    exit
            end
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
        
        # drawing is done "off-screen", so we have to flip() it into view
        @screen.flip
    end

end

# fire it up
Game.new.run!

