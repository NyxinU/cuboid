require 'cuboid'

#This test is incomplete and, in fact, won't even run without errors.  
#  Do whatever you need to do to make it work and please add your own test cases for as many
#  methods as you feel need coverage
describe Cuboid do
  subject { Cuboid.new([0, 0, 0],[2, 1, 3]) }

  describe "initialize" do
    it "creates cuboid at specified origin" do 
      expect(subject.origin).to eq [0, 0, 0]
    end 

    it "creates a cuboid with specified dimensions" do 
      expect(subject.dimensions).to eq [2, 1, 3]
    end

    # let (:out_of_bounds) {Cuboid.new([1, 1, -,1][1, 1, 1])}
    context "invalid argument" do 

      it "raise error if invalid number of elements in origin" do 
        expect { Cuboid.new([0,0,0,0],[1,1,1])}.to raise_error("ORIGIN AND DIMENSIONS MUST HAVE 3 NUMBERS")
      end 

      it "raise error if invalid number of elements dimensions" do 
        expect { Cuboid.new([0,0,0],[1,1,1,1])}.to raise_error("ORIGIN AND DIMENSIONS MUST HAVE 3 NUMBERS")
      end 

      it "raises error if origin coordinates are out of bounds" do 
        expect { Cuboid.new([-1, 1, 1],[1, 1, 1]) }.to raise_error("ORIGIN VALUES CANNOT BE LESS THAN 0")
      end 

      it "raises error if dimensions are less than one" do 
        expect { Cuboid.new([1, 1, 1],[0, 1, 1]) }.to raise_error("DIMENSION VALUES CANNOT BE LESS 1")
      end 

    end 

  end 
 
  describe "move_to" do
    it "changes the origin in the simple happy case" do
      expect(subject.move_to!(1,2,3)).to be true
    end
  end    
  
  describe "intersects?" do
  end

end
