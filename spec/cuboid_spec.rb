require 'cuboid'

#This test is incomplete and, in fact, won't even run without errors.  
#  Do whatever you need to do to make it work and please add your own test cases for as many
#  methods as you feel need coverage
describe Cuboid do
  describe "#initialize" do
    context "when using bad initialization arguments" do
      it "detects invalid x origin" do
        expect { Cuboid.new(nil, 0, 0, 1, 1, 1) }.to raise_error
      end

      it "detects invalid y origin" do
        expect { Cuboid.new(0, nil, 0, 1, 1, 1) }.to raise_error
      end

      it "detects invalid z origin" do
        expect { Cuboid.new(0, 0, nil, 1, 1, 1) }.to raise_error
      end

      it "detects invalid width" do
      expect { Cuboid.new(0, 0, 0, nil, 1, 1) }.to raise_error
      end
      
      it "detects invalid height" do
        expect { Cuboid.new(0, 0, 0, 1, nil, 1) }.to raise_error
      end

      it "detects invalid z origin" do
        expect { Cuboid.new(0, 0, 0, 1, 1, nil) }.to raise_error
      end
    end

    context "when using valid input" do
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

  describe "move_to" do
    subject { Cuboid.new(0, 0, 0,)}
    it "changes the origin in the simple happy case" do
      expect(subject.move_to!(1, 2, 3)).to be true
    end
  end    
  
  describe "intersects?" do
  end

end
