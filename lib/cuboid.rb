class OuterBox
  attr_reader :dimensions

  def initialize(width, height, depth)
    @width, @height, @depth = width, height, depth 
  end 
end 

class Cuboid
  attr_reader :origin, :dimensions

  def initialize(origin, dimensions)
    @origin = origin 
    @dimensions = dimensions
  end 
  
  def move_to!(x, y, z)
    @origin = [x,y,z]
  end
  
  def vertices
    range = range_finder
    
    vertices = {
      v1:[x,y,z],
      v2:[range[:x][1],y,z],
      v3:[x, range[:y][1],z],
      v4:[range[:x][1], range[:y][1],z],
      v5:[x,y, range[:z][1]],
      v6:[range[:x][1],y, range[:z][1]],
      v7:[x, range[:y][1], range[:z][1]],
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

  def rotate!(axis)

  end 

  # private 

  def range_finder
    range = {
      x:[x, x + width],
      y:[y, y + height],
      z:[z, z + depth]
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

  def x 
    @origin[0]
  end 

  def y 
    @origin[1]
  end 

  def z 
    @origin[2]
  end 

  def width
    @dimensions[0]
  end 

  def height
    @dimensions[1]
  end 

  def depth
    @dimensions[2]
  end 

end

if __FILE__ == $PROGRAM_NAME
  outer = OuterBox.new(10,10,10)
  cuboid1 = Cuboid.new([0,1,0],[3,5,9])
  cuboid2 = Cuboid.new([0,0,0],[2,1,3])
end


