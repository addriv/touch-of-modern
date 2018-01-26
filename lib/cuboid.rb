class Cuboid
  attr_reader :origin_x, :origin_y, :origin_z, :width, :height, :length

  def initialize(x, y, z, width, height, length)  
    raise 'Must have x, y, and z origin' unless x && y && z
    raise 'Must have width, height, and length' unless width > 0 && height > 0 && length > 0
    @origin_x = x
    @origin_y = y
    @origin_z = z
    @width = width
    @height = height
    @length = length
  end

  def move_to!(x, y, z)
    raise 'Must have x, y, and z origin' unless x && y && z
    @origin_x = x
    @origin_y = y
    @origin_z = z
    true
  end
  
  # Returns an array of vertices [x,y,z] 
  def vertices
    face1_vertices = [
      [@origin_x, @origin_y, @origin_z],
      [@origin_x, @origin_y + @height, @origin_z],
      [@origin_x + @width, @origin_y, @origin_z],
      [@origin_x + @width, @origin_y + @height, @origin_z]
    ]

    face2_vertices = face1_vertices.map do |vertex|
      vertex[0..1] << vertex[2] + @length
    end

    face1_vertices + face2_vertices
  end
  
  #Returns true if the two cuboids intersect each other.  False otherwise.
  def intersects_in_axis?(other_cuboid, axis)
    dimensions = {
      x: "width",
      y: "height",
      z: "length"
    }

    min_axis = self.send("origin_#{axis}")
    max_axis = min_axis + self.send(dimensions[axis])
    other_min_axis = other_cuboid.send("origin_#{axis}")
    other_max_axis = other_cuboid.send(dimensions[axis])


    if (other_min_axis >= min_axis && other_min_axis <= max_axis) ||
       (min_axis >= other_min_axis && min_axis <= other_max_axis)
      true
    else
      false
    end
  end

  def intersects?(other)
    [:x, :y, :z].each do |axis|
      return true if intersects_in_axis?(other, axis)
    end

    false
  end
end
