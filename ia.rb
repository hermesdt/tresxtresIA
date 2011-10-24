#!/usr/bin/env ruby

class IA

        attr_reader :tablero, :cards, :ia_card, :enemy_card

        def initialize t, cards, ia_card
                @tablero = t
                @cards = cards
                @ia_card = ia_card
                @enemy_card = (cards - [ia_card])[0]
        end

        def deffence_tactic
                unless (deffence_move = best_move(@enemy_card)).nil?
                        return parse_move(deffence_move)
                else
                        return nil
                end
        end

        def attack_tactic
                unless (attack_move = best_move(@ia_card)).nil?
                        return parse_move(attack_move)
                else
                        return nil
                end
        end

        def parse_move(move)
                case move[0]
                when "h"
                        for i in 0..2
                                return [move[1], i] if @tablero[move[1]][i] == "-"
                        end
                when "v"
                        for i in 0..2
                                return [i, move[1]] if @tablero[i][move[1]] == "-"
                        end
                when "d"
                        if move[1] == 0
                                return [0, 0] if @tablero[0][0] == "-"
                                return [1, 1] if @tablero[1][1] == "-"
                                return [2, 2] if @tablero[2][2] == "-"
                        else
                                return [2, 0] if @tablero[2][0] == "-"
                                return [1, 1] if @tablero[1][1] == "-"
                                return [0, 2] if @tablero[0][2] == "-"
                        end
                end
        end

        def best_move(target_card)
                
                #horizontal
                for i in 0..2
                        cards = @tablero[i]
                        return ["h", i] if two_or_more? cards, target_card
                end
                #vertical
                for i in 0..2
                        cards = []
                        cards << @tablero[0][i] << @tablero[1][i] << @tablero[2][i]
                        return ["v", i] if two_or_more? cards, target_card
                end

                #diagonal 1
                cards = [] << @tablero[0][0] << @tablero[1][1] << @tablero[2][2]
                        return ["d", 0] if two_or_more? cards, target_card

                #diagonal 2
                cards = [] << @tablero[2][0] << @tablero[1][1] << @tablero[0][2]
                        return ["d", 1] if two_or_more? cards, target_card

                nil
        end

        def two_or_more? cards, target_card
                return true if cards.select{|e| e == target_card}.count == 2 and
                                cards.select{|e| e == "-"}.count == 1
                false
        end

        def play(t)
                if (attack_move = attack_tactic).nil?
                        if (deffence_move = deffence_tactic).nil?
                                while true
                                        x = (rand * 3).to_i
                                        y = (rand * 3).to_i

                                        return x, y if t[x][y] == "-"
                                end
                        else
                                return deffence_move
                        end
                else
                        return attack_move
                end
        end
end
