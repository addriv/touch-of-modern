require 'cuboid'

#This test is incomplete and, in fact, won't even run without errors.  
#  Do whatever you need to do to make it work and please add your own test cases for as many
#  methods as you feel need coverage
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
    it "returns an array of vertices" do
      expect(subject.vertices).to be_instance_of(Array)
    end

    it "returns each vertex as an array" do
      subject.vertices.each do |vertex|
        expect(vertex).to be_instance_of(Array)
      end
    end

    it "returns a total of 8 vertices" do
      expect(subject.vertices.length).to eq(8)
    end

    it "returns the correct coordinates for all vertices" do
      x_count1 = subject.vertices.count { |vertex| vertex[0] == subject.origin_x }
      x_count2 = subject.vertices.count { |vertex| vertex[0] == subject.origin_x + subject.width }
      y_count1 = subject.vertices.count { |vertex| vertex[1] == subject.origin_y }
      y_count2 = subject.vertices.count { |vertex| vertex[1] == subject.origin_y + subject.height }
      z_count1 = subject.vertices.count { |vertex| vertex[2] == subject.origin_z }
      z_count2 = subject.vertices.count { |vertex| vertex[2] == subject.origin_z + subject.length}

      expect(x_count1).to eq(4)
      expect(x_count2).to eq(4)
      expect(y_count1).to eq(4)
      expect(y_count2).to eq(4)
      expect(z_count2).to eq(4)
      expect(z_count2).to eq(4)
    end
  end

  describe "intersects?" do
  end
end
