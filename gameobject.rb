#!/usr/bin/env ruby

class GameObject

    # auto getters, setters
    attr_accessor :x, :y, :width, :height, :surface

    def initialize(x, y, surface)
        @x = x
        @y = y
        @surface = surface
        @width = surface.width
        @height = surface.height
    end

    def draw(screen)
        # blit(surface to draw to, surface coordinates)
        # draws a surface onto another surface
        @surface.blit(screen, [@x, @y])
    end

    # ---- abstract ---------------------------------------

    def update
    end

    def handle_event(event)    
    end

end

