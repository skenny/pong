#!/usr/bin/env ruby

require 'gameobject.rb'

class Text < GameObject

    def initialize(x=0, y=0, text="Hello World!", size=48)
        @font = Rubygame::TTF.new("Freshman.ttf", size)
        @text = text
        
        super(x, y, render())
    end

    def render
        @width, @height = @font.size_text(@text)
        @surface = @font.render(@text, true, [255, 255, 255])
    end
    
    def text
        @text
    end

    def text=(str)
        @text = str
        render
    end

end

