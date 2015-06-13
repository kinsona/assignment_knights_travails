require "./move_tree"

class KnightSearcher

  def initialize(tree)
    @tree = tree
    @queue = []
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


  private


  def clear_bfs
    @queue = []
    @tree.clear_all_depths
  end


  def match?(square, target_coords)
    [square.x, square.y] == target_coords
  end


  def match_found(square)
    puts "Found in #{square.depth.size} moves:"
    square.depth.each { |step| print "#{step}\n"}
  end


  def queue_children(square)
    square.children.each do |child|
      if child.depth.nil?
        child.depth = square.depth.dup
        @queue << child
      end
    end
  end

end