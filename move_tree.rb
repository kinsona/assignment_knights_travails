Square = Struct.new(:x, :y, :depth, :children)

class MoveTree

  # use 0,0 as top-left square
  def initialize(start_coords, max_depth)
    @max_depth = max_depth
    # define basic knight movement possibilities
    @movements = knight_movement

    # create starting square
    @root = Square.new(start_coords[0], start_coords[1], 0, nil)
    @node_count = 1

    # create starting build_queue
    @build_queue = [@root]
    depth_counter = 1


    while depth_counter <= @max_depth do

      # run through current queue prior to updating depth_counter
      @build_queue.size.times do

        square = @build_queue.shift
        spawn_children(square)

      end

    depth_counter += 1

    end

  end

  # Pry appears to automatically run #inspect after #initialize?
  def inspect
    puts "Your tree has #{@node_count} nodes and a max depth of #{@max_depth}."
  end


  private


  def knight_movement
    steps = [-2, -1, 1, 2]

    moves = steps.permutation(2).to_a.select do |move|
      move[0].abs != move[1].abs
    end

    moves
  end


  def check_moves(x,y)
    possible_destinations = []

    @movements.each do |move|
      destination_x = x + move[0]
      destination_y = y + move[1]

      possible_destinations << [destination_x, destination_y] unless off_board?(destination_x, destination_y)
    end

    possible_destinations
  end


  def off_board?(x, y)
    !x.between?(1,5) || !y.between?(1,5)
  end


  def spawn_children(square)

    square.children = []

    moves = check_moves(square.x, square.y)
    moves.each do |move|
      child = Square.new(move[0], move[1], nil, nil)
      square.children << child
      @build_queue.push(child)
      @node_count += 1
    end

  end

end