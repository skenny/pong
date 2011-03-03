#!/usr/bin/env ruby

require 'gameobject.rb'

class Background < GameObject

    def initialize(width, height)
        surface = Rubygame::Surface.new([width, height])
        
        white = [255, 255, 255]
        linewidth = 10
        
        # draw_box_s draws filled box
        # ([upper left x, y], [bottom-right x, y], color)
        
        # top line
        surface.draw_box_s([0, 0], [surface.width, linewidth], white)
        # left line
        surface.draw_box_s([0, 0], [linewidth, surface.height], white)
        # bottom line
        surface.draw_box_s([0, surface.height-linewidth], [surface.width, surface.height], white)
        # right line
        surface.draw_box_s([surface.width-linewidth, 0], [surface.width, surface.height], white)
        # middle divider
        surface.draw_box_s([(surface.width/2)-(linewidth/2), 0], [(surface.width/2)+(linewidth/2), surface.height], white)
        
        super(0, 0, surface)
    end

end

