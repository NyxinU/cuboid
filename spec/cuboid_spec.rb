require 'cuboid'

#This test is incomplete and, in fact, won't even run without errors.  
#  Do whatever you need to do to make it work and please add your own test cases for as many
#  methods as you feel need coverage
describe Cuboid do
  subject { Cuboid.new([10, 10, 10],[2, 1, 3]) }

  describe "initialize" do
    it "creates cuboid at specified origin" do 
      expect(subject.origin).to eq [10, 10, 10]
    end 

    it "creates a cuboid with specified dimensions" do 
      expect(subject.dimensions).to eq [2, 1, 3]
    end

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

  describe "rotate!" do 
    it "rotates along the x axis" do 
      subject.rotate!("x")
      expect(subject.origin).to eq [10, 10, 9]
      expect(subject.dimensions).to eq [2, 3, 1]
    end 

    it "rotates along the y axis" do 
      subject.rotate!("y")
      expect(subject.origin).to eq [10, 10, 8]
      expect(subject.dimensions).to eq [3, 1, 2]
    end 

    it "rotates along the z axis" do 
      subject.rotate!("z")
      expect(subject.origin).to eq [10, 8, 10]
      expect(subject.dimensions).to eq [1, 2, 3]
    end
    
    context "shift if out of bound after rotation" do

      let (:walled_cuboid) {Cuboid.new([1, 1, 1],[3, 7, 12])}

      it "fixes out of bounds rotation along x axis" do
        walled_cuboid.rotate!("x")
        expect(walled_cuboid.origin).to eq [1, 1, 0]
        expect(walled_cuboid.dimensions).to eq [3, 12, 7]
      end  
      it "fixes out of bounds rotation along y axis" do
        walled_cuboid.rotate!("y")
        expect(walled_cuboid.origin).to eq [1, 1, 0]
        expect(walled_cuboid.dimensions).to eq [12, 7, 3]
      end  
      it "fixes out of bounds rotation along z axis" do
        walled_cuboid.rotate!("z")
        expect(walled_cuboid.origin).to eq [1, 0, 1]
        expect(walled_cuboid.dimensions).to eq [7, 3, 12]
      end  
    end

  end 
end
