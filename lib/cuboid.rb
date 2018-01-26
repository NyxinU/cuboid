class OuterBox
  attr_reader :dimensions

  def initialize(dimensions)
    @dimensions = dimensions
  end 
end 

class Cuboid
  attr_reader :origin, :dimensions

  def initialize(origin, dimensions)
    @origin = origin
    @dimensions = dimensions

    validate!
  end 
  
  def move_to!(x, y, z)
    @origin = [x,y,z]
  end
  
  def vertices
    vertices_finder
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
    case axis 

    when "x"
      @origin[2] -= height 
    when "y"
      @origin[2] -= width 
    when "z"
      @origin[1] -= width 
    end 
  end 

  # private 

  def validate!
    if @origin.length != 3 || @dimensions.length != 3 
      raise "ORIGIN AND DIMENSIONS MUST HAVE 3 NUMBERS"
    elsif @origin.any? { |num| num < 0 }
      raise "ORIGIN VALUES CANNOT BE LESS THAN 0"
    elsif @dimensions.any? { |num| num < 1}
      raise "DIMENSION VALUES CANNOT BE LESS 1"
    end 
  end 

  def range_finder
    range = {
      x:[x, x + width],
      y:[y, y + height],
      z:[z, z + depth]
    }
  end 

  def vertices_finder 
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

  # def x=(value)
  #   @origin[0] = value
  # end 

  # def y=(value)
  #   @origin[1] = value
  # end 

  # def z=(value)
  #   @origin[2] = value
  # end 

  def width
    @dimensions[0]
  end 

  def height
    @dimensions[1]
  end 

  def depth
    @dimensions[2]
  end

  # def width=(value)
  #   @dimensions[0] = value
  # end 

  # def height=(value)
  #   @dimensions[1] = value
  # end 

  # def depth=(value)
  #   @dimensions[2] = value
  # end

end

if __FILE__ == $PROGRAM_NAME
  outer = OuterBox.new(10,10,10)
  cuboid1 = Cuboid.new([0,1,0],[3,5,9])
  cuboid2 = Cuboid.new([0,0,0],[2,1,3])
end


