class Grid

  attr_reader :state

  def initialize(width = 7, height = 6)
    @state = Array.new(height) { |col| Array.new(width)}
  end

  def update(col_index, token)
    col_index -= 1
    row_index = @state.length-1
    while !@state[row_index][col_index].nil? do
      row_index -= 1
    end
    @state[row_index][col_index] = token
  end

end