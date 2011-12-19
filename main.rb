#!/usr/bin/env ruby

require 'rubygems'

require_relative 'tablero.rb'
require_relative 'turn.rb'
require_relative 'ia.rb'

def init_tablero
        t = Tablero.new
        t << %w(- - -)
        t << %w(- - -)
        t << %w(- - -)
        t
end

def init_ia(t, cards, ia_card)
        IA.new t, cards, ia_card
end

def main
        include Turn

        t = init_tablero
        if (rand * 20).to_i % 2 == 0 
                cards = %w(X O)
        else
                cards = %w(O X)
        end

        ia_card = "O"

        ia = init_ia t, cards, ia_card

        turn = 0

        while t.flatten.include? "-"

                puts "\n#{cards[turn % 2]} plays"
                puts t.to_s

                if cards[turn % 2] == ia_card
                        x, y = init_turn(t, cards[turn % 2], ia)
                        end_turn(t, [cards[turn % 2], [x, y]], ia)
                else
                        x, y = init_turn(t, cards[turn % 2])
                        end_turn(t, [cards[turn % 2], [x, y]])
                end

                turn += 1
        end
end

main()
