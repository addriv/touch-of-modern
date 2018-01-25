class Cuboid
  attr_reader :origin_x, :origin_y, :origin_z, :width, :height, :length

  def initialize(x, y, z, width, height, length)  
    @origin_x = x
    @origin_y = y
    @origin_z = z
    @width = width
    @height = height
    @length = length
    raise 'Must have x, y, and z origin' unless x && y && z
    raise 'Must have width, height, and length' unless width && height && length
  end

  def move_to!(x, y, z)
    @origin_x = x
    @origin_y = y
    @origin_z = z
  end
  
  # Returns an array of vertices [x,y,z] 
  def vertices
    face1 = [
      [@origin_x, @origin_y, @origin_z],
      [@origin_x, @origin_y + @height, @origin_z],
      [@origin_x + @width, @origin_y, @origin_z],
      [@origin_x + @width, @origin_y + @height, @origin_z]
    ]
    face2 = face1.map do |vertex|
      vertex[0..1] << vertex[2] + @length
    end

    face1 + face2
  end
  
  #returns true if the two cuboids intersect each other.  False otherwise.
  def intersects?(other)
    return false if other.origin_x + other.width < @origin_x || other.origin_x > @origin_x + width
    return false if other.origin_y + other.height < @origin_y || other.origin_y > @origin_y + @height
    return false if other.origin_z + other.length < @origin_z || other.origin_z > @origin_z + @length
    true
  end

  #END public methods that should be your starting point  
end
