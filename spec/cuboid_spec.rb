require 'cuboid'

describe Cuboid do
  subject { Cuboid.new(0, 0, 0, 1, 1, 1) }

  describe "#initialize" do
    context "when invalid arguments" do
      it "requires an x origin" do
        expect { Cuboid.new(nil, 0, 0, 1, 1, 1) }.to raise_error
      end

      it "requires a y origin" do
        expect { Cuboid.new(0, nil, 0, 1, 1, 1) }.to raise_error
      end

      it "requires a z origin" do
        expect { Cuboid.new(0, 0, nil, 1, 1, 1) }.to raise_error
      end

      it "requires a width" do
      expect { Cuboid.new(0, 0, 0, nil, 1, 1) }.to raise_error
      end
      
      it "requires a height" do
        expect { Cuboid.new(0, 0, 0, 1, nil, 1) }.to raise_error
      end

      it "requires a length" do
        expect { Cuboid.new(0, 0, 0, 1, 1, nil) }.to raise_error
      end
    end

    context "when using valid arguments" do
      it "creates a cuboid with good input" do
        10.times do 
          valid_input = Array.new(6) { rand(1000) }
          cuboid = Cuboid.new(*valid_input)
  
          expect(cuboid).to be_instance_of(Cuboid)
          expect(cuboid.origin_x).to eq(valid_input[0])
          expect(cuboid.origin_y).to eq(valid_input[1])
          expect(cuboid.origin_z).to eq(valid_input[2])
          expect(cuboid.width).to eq(valid_input[3])
          expect(cuboid.height).to eq(valid_input[4])
          expect(cuboid.length).to eq(valid_input[5])
        end
      end
    end

  end

  describe "#move_to!" do
    it "changes the origin in the simple happy case" do
      expect(subject.move_to!(1, 2, 3)).to be true
    end

    context "when using bad coordinates" do
      it "requires an x coordinate" do
        expect { subject.move_to!(nil, 1, 1) }.to raise_error
      end

      it "requires a y coordinate" do
        expect { subject.move_to!(1, nil, 1) }.to raise_error        
      end

      it "requires a z coordinate" do
        expect { subject.move_to!(1, 1, nil) }.to raise_error
      end
    end

    context "when using valid coordinates" do
      it "moves the cuboid to given coordinates" do
        10.times do
          valid_coordinates = Array.new(3) { rand(1000) }
          subject.move_to!(*valid_coordinates)

          expect(subject.origin_x).to eq(valid_coordinates[0])
          expect(subject.origin_y).to eq(valid_coordinates[1])
          expect(subject.origin_z).to eq(valid_coordinates[2])
        end
      end
    end
  end    
  
  describe "#vertices" do
    let(:vertices) { subject.vertices.uniq }

    it "returns an array of vertices" do
      expect(vertices).to be_instance_of(Array)
    end

    it "returns each vertex as an array" do
      vertices.each do |vertex|
        expect(vertex).to be_instance_of(Array)
      end
    end

    it "returns 8 unique vertices" do
      expect(vertices.length).to eq(8)
    end

    it "returns the correct coordinates for all vertices" do
      dimensions = {
        x: "width",
        y: "height",
        z: "length"
      }

      [:x, :y, :z].each_with_index do |axis, i|
        min_axis_coordinate = subject.send("origin_#{axis}")
        max_axis_coordinate = subject.send("origin_#{axis}") + subject.send(dimensions[axis])

        count1 = vertices.count { |vertex| vertex[i] == min_axis_coordinate}
        count2 = vertices.count { |vertex| vertex[i] == max_axis_coordinate}

        expect(count1).to eq(4)
        expect(count2).to eq(4)
      end
    end
  end

  describe "intersects?" do
    context "when two cuboids intersect" do
      it "returns true" do
        expect(subject.intersects?(subject)).to be true
      end
    end

    context "when two cuboids do not intersect" do
      it "returns false" do
        other_cuboid = Cuboid.new(2, 2, 2, 1, 1, 1)
        expect(subject.intersects?(other_cuboid)).to be false
      end
    end
  end
end
