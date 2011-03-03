#!/usr/bin/env ruby

# require 'gameobject.rb'

class Paddle < GameObject

    def initialize(x, y)
        surface = Rubygame::Surface.new([20, 100])
        surface.fill([255, 255, 255])
        
        super(x, y, surface)
    end

    def center_y(h)
        @y = h/2-@height/2
    end

end

