module Turn
        def init_turn(t, card, ia = nil)
                return init_human_turn(t) unless ia
                return init_ia_turn(t, ia) if ia
        end

        def init_ia_turn(t, ia)
                return ia.play(t)
        end

        def init_human_turn(t)
                s = nil
                x = nil, y = nil
                while true
                        print "(x y)?: "
                        s = STDIN.gets.chomp
                        next unless s =~ /[0-2] [0-2]/

                        x, y = s.split(" ")
                        break if t[x.to_i][y.to_i] == "-" 
                end
                
                return x, y
        end


        def end_turn(t, move, ia = nil)
                card = move[0]
                x = move[1][0].to_i
                y = move[1][1].to_i

#t[x][y] = card
                t.add_move(card, x, y)

                
                if winner? t, move
                        puts t.to_s
                        exit
                end
        end

        def winner?(t, move)
                card = move[0]
                encontrado = false
                #horizontal
                for i in 0..2
                        encontrado |= t[i][0] == card && t[i][1] == card && t[i][2] == card 
                end unless encontrado
                #vertical
                for i in 0..2
                        encontrado |= t[0][i] == card && t[1][i] == card && t[2][i] == card 
                end unless encontrado

                #diagonal 1
                encontrado |= t[0][0] == card && t[1][1] == card && t[2][2] == card unless encontrado
                #diagonal 2
                encontrado |= t[2][0] == card && t[1][1] == card && t[0][2] == card unless encontrado

                encontrado
        end

        def end_human_turn(t, move)
        end

        def end_ia_turn(t, move, ia)
        end
end
