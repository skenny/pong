#!/usr/bin/env ruby

require 'gameobject.rb'

class Background < GameObject

    attr_accessor :lineWidth

    def initialize(width, height)
        surface = Rubygame::Surface.new([width, height])
        
        white = [255, 255, 255]
        @lineWidth = 10
        
        # draw_box_s draws filled box
        # ([upper left x, y], [bottom-right x, y], color)
        
        # top line
        surface.draw_box_s([0, 0], [surface.width, @lineWidth], white)
        # left line
        surface.draw_box_s([0, 0], [@lineWidth, surface.height], white)
        # bottom line
        surface.draw_box_s([0, surface.height-@lineWidth], [surface.width, surface.height], white)
        # right line
        surface.draw_box_s([surface.width-@lineWidth, 0], [surface.width, surface.height], white)
        # middle divider
        surface.draw_box_s([(surface.width/2)-(@lineWidth/2), 0], [(surface.width/2)+(@lineWidth/2), surface.height], white)
        
        super(0, 0, surface)
    end

end

