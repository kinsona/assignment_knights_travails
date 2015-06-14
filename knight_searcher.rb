require "./move_tree"

class KnightSearcher

  def initialize(tree)
    @tree = tree
    @queue = []
    @stack = []
  end


  def bfs_for(target_coords)

    failed = true

    @queue << @tree.root

    until @queue.empty? do

      square = @queue.shift

      square.depth ||= []
      square.depth << [square.x, square.y]

      if match?(square, target_coords)
        failed = false
        match_found(square)
        break

      elsif !square.children.nil?
        queue_children(square)

      end

    end

    clear_bfs
    puts "Search complete: no matches found." if failed

  end


  def dfs_for(target_coords)

    failed = true

    @stack << @tree.root

    until @stack.empty? do

      square = @stack.pop
      #puts square.x.to_s + square.y.to_s

      square.depth ||= []
      square.depth << [square.x, square.y]

      if match?(square, target_coords)
        failed = false
        match_found(square)
        break

      elsif !square.children.nil?
        stack_children(square)

      end

    end

    clear_dfs
    puts "Search complete: no matches found." if failed
  end


  private


  def clear_bfs
    @queue = []
    @tree.clear_all_depths
  end


  def clear_dfs
    @stack = []
    @tree.clear_all_depths
  end


  def match?(square, target_coords)
    [square.x, square.y] == target_coords
  end


  def match_found(square)
    puts "#{square.depth.size} move(s):"
    square.depth.each { |step| print "#{step}\n"}
  end


  def queue_children(square)
    square.children.each do |child|
      if child.depth.nil?
        child.depth = square.depth.dup
        print child.depth.to_s + ">> #{child.x},#{child.y}\n"
        @queue << child
      end
    end
  end


  def stack_children(square)
    # sort in a more preferable order?
    # Check to see why 5,4 keeps showing up?
    square.children.each do |child|
      if child.depth.nil?
        child.depth = square.depth.dup
        print child.depth.to_s + ">> #{child.x},#{child.y}\n"
        @stack << child
      end
    end
  end

end