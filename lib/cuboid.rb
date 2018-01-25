class OuterBox
  attr_reader :dimensions

  def initialize(width, height, depth)
    @width = width
    @height = height
    @depth = depth 
  end 
end 

class Cuboid

  def initialize(origin, dimensions)
    @x, @y, @z = origin 
    @width, @height, @depth = dimensions
  end 
  
  #BEGIN public methods that should be your starting point

  def move_to!(x, y, z)
    @x = x
    @y = y
    @z = z 
  end
  
  def vertices
    range = range_finder
    
    vertices = {
      v1:[@x, @y, @z],
      v2:[range[:x][1], @y, @z],
      v3:[@x, range[:y][1], @z],
      v4:[range[:x][1], range[:y][1], @z],
      v5:[@x, @y, range[:z][1]],
      v6:[range[:x][1], @y, range[:z][1]],
      v7:[@x, range[:y][1], range[:z][1]],
      v8:[range[:x][1], range[:y][1], range[:z][1]]
    }
  end
  
  #returns true if the two cuboids intersect each other.  False otherwise.
  def intersects?(other)
    self_range = range_finder
    other_range = other.range_finder

    self_range.each do |k,_|
      return false unless overlap?(self_range[k], other_range[k])
    end 

    true 
  end

  def range_finder
    range = {
      x:[@x, @x + @width],
      y:[@y, @y + @height],
      z:[@z, @z + @depth]
    }
  end 

  def overlap?(self_range, other_range)
    return true if self_range == other_range 
    overlap_helper(self_range, other_range) || overlap_helper(other_range, self_range)
  end

  def overlap_helper(range1, range2)
    range1.each do |i|
      return true if i > range2[0] && i < range2[1]
    end 

    false 
  end 

end

if __FILE__ == $PROGRAM_NAME
  outer = OuterBox.new(10,10,10)
  cuboid1 = Cuboid.new([0,0,0],[3,5,9])
  cuboid2 = Cuboid.new([0,0,0],[2,1,3])
  print cuboid1.intersects?(cuboid2)
end


