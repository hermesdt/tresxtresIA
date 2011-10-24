#!/usr/bin/env ruby

class Tablero < Array

        attr_accessor :moves

        def initialize
                @moves = []
        end

        def to_s
                s = "\n"
                s << "0 [" << self[0][0] << " " << self[0][1] << " "<< self[0][2] << "]\n"
                s << "1 [" << self[1][0] << " " << self[1][1] << " " << self[1][2] << "]\n"
                s << "2 [" << self[2][0] << " " << self[2][1] << " " << self[2][2] << "]\n"
                s << "   0 1 2\n"
        end

        def add_move(card, x, y)
                if self.flatten.select{|e| e == card}.count == 3
                        if @moves[0][0] == card
                                self[@moves[0][1][0]][@moves[0][1][1]] = "-"
                                @moves.delete_at(0)
                        else
                                puts "FIN DEL MUNDO!!!"
                                exit
                        end
                end
                @moves << [card, [x, y]]
                self[x][y] = card
        end

        def serialize
                s = ""
                self.each do |line|
                        line.each do |cell|
                                s << cell
                        end
                end
                s
        end
end

