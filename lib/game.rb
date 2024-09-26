require_relative "player"
require_relative "grid"

class Game

  attr_reader :height, :width
  def initialize()
    @players = [Player.new('R'), Player.new('B')]
    @width = get_width
    @height = get_height
    @grid = Grid.new(@width, @height)
  end

  def play
    turn = 0
    until game_over? do
      msg = "Player's turn: #{turn};\nChoose an available slot (1-#{@width}): "
      for row in @grid.state do
        print(row, "\n")
      end
      column = get_number(1, @width, [full_columns], msg)
      @grid.update(column, @players[turn].token)
      turn = (turn+1) % @players.length
    end
    winner = (turn-1+@players.length) % @players.length
    win_message(winner)
  end

  def full_columns
    ans = []
    for col_index in 0...@width do
      ans.push(col_index) if @grid.state[0][col_index]
    end
    return ans
  end
  
  def win_message(winner)
    for row in @grid.state do
      print(row, "\n")
    end
    if !(col_win? || row_win? || diag_win?) && board_full? then
      puts("It's a tie!")
      return
    end
    puts("#{winner} won the game!")
  end

  def game_over?
    print(col_win?, row_win?, diag_win?, board_full?,"\n")
    return col_win? || row_win? || diag_win? || board_full?
  end

  def board_full?
    if @grid.state[0].include?(nil) then
      return false
    else 
      return true
    end
  end

  def col_win?
    for col_index in 0...@width do
      matches = 0
      matching = nil
      for row_index in 0...@height do
        token = @grid.state[row_index][col_index]
        if token == matching && !token.nil? then
          matches += 1
          if matches >= 4 then
            return true
          end
        else
          matching = token
          matches = 1
        end
      end
    end
    return false
  end

  def row_win?
    for row_index in 0...@height do
      matches = 0
      matching = nil
      for col_index in 0...@width do
        token = @grid.state[row_index][col_index]
        if token == matching && !token.nil? then
          matches += 1
          if matches >= 4 then
            return true
          end
        else
          matching = token
          matches = 1
        end
      end
    end
    return false
  end

  def diag_win?
    for row_index in 0...(@height-3) do
      for col_index in 0...(@width-3) do
        token = @grid.state[row_index][col_index]
        matches = 1
        ntoken = @grid.state[row_index+matches][col_index+matches]
        while token == ntoken && !token.nil? && matches < 4 do
          matches += 1
          if matches < 4 then
            ntoken = @grid.state[row_index+matches][col_index+matches]
          end
        end
        if matches >= 4 then
          return true
        end
      end
    end
    for row_index in 0...(@height-3) do
      for col_index in 3...@width do
        token = @grid.state[row_index][col_index]
        matches = 1
        ntoken = @grid.state[row_index+matches][col_index-matches]
        while token == ntoken && !token.nil? && matches < 4 do
          matches += 1
          if matches < 4 then
            ntoken = @grid.state[row_index+matches][col_index-matches]
          end
        end
        if matches >= 4 then
          return true
        end
      end
    end
    return false
  end

  def get_width
      msg = "Choose width (1-9): "
      width = get_number(1, 9, [], msg)
      return width
  end

  def get_height
    msg = "Choose height (1-9): "
    height = get_number(1, 9, [], msg)
    return height
  end

  def get_number(min, max, exclude = [], msg = "Choose a number between #{min} and #{max}#{", excluding #{exclude}" if exclude.length > 0}: ")
    ans = nil
    until /^[#{min}-#{max}]+$/.match(ans) && ans.to_i >= min && ans.to_i <= max && !exclude.include?(ans.to_i) do
      print(msg)
      ans = gets.chomp
    end
    return ans.to_i
  end
end

game = Game.new
game.play