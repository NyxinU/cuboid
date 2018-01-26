require 'cuboid'

#This test is incomplete and, in fact, won't even run without errors.  
#  Do whatever you need to do to make it work and please add your own test cases for as many
#  methods as you feel need coverage
describe Cuboid do
  subject { Cuboid.new([10, 10, 10],[2, 1, 3]) }
  let(:decimal_cuboid) { Cuboid.new([10.5, 0.5, 10.5],[2.5, 0.5, 3.5]) }

  describe "#initialize" do
    it "initialize cuboid at specified origin" do 
      expect(subject.origin).to eq [10, 10, 10]
      expect(decimal_cuboid.origin).to eq [10.5, 0.5, 10.5]
    end 

    it "initialize cuboid with specified dimensions" do 
      expect(subject.dimensions).to eq [2, 1, 3]
      expect(decimal_cuboid.dimensions).to eq [2.5, 0.5, 3.5]
    end

    context "invalid arguments" do 
      it "raise error if invalid number of elements in origin" do 
        expect { Cuboid.new([0, 0, 0, 0],[1, 1, 1]) }.to raise_error("ORIGIN AND DIMENSIONS MUST HAVE 3 NUMBERS")
      end 

      it "raise error if invalid number of elements dimensions" do 
        expect { Cuboid.new([0, 0, 0],[1, 1, 1, 1]) }.to raise_error("ORIGIN AND DIMENSIONS MUST HAVE 3 NUMBERS")
      end 

      it "raises error if origin coordinates are out of bounds" do 
        expect { Cuboid.new([-1, 1, 1],[1, 1, 1]) }.to raise_error("ORIGIN VALUES CANNOT BE LESS THAN 0")
      end 

      it "raises error if dimensions are less than one" do 
        expect { Cuboid.new([1, 1, 1],[0, 1, 1]) }.to raise_error("DIMENSION VALUES CANNOT BE LESS OR EQUAL TO 0")
      end 
    end 
  end 
 
  describe "#move_to" do
    it "changes the origin in the simple happy case" do
      expect(subject.move_to!(1, 2, 3)).to be true
      expect(subject.origin).to eq [1, 2, 3]
    end

    it "takes decimals for origin" do 
      expect(subject.move_to!(0.5, 1.5, 2.5)).to be true 
      expect(subject.origin).to eq [0.5, 1.5, 2.5]
    end 

    context "invalid arguements" do 
      it "raises error if origin coordinates are out of bounds" do 
        expect { subject.move_to!(-1, 0, 0) }.to raise_error("ORIGIN VALUES CANNOT BE LESS THAN 0")
        expect(subject.origin).to eq [10, 10, 10]
      end 
    end 
  end
  
  describe "#vertices" do
    s_origin = [[10, 10, 10],[12, 10, 10],[10, 11, 10],[12, 11, 10],[10, 10, 13],[12, 10, 13],[10, 11, 13],[12, 11, 13]]
    d_origin = [[10.5, 0.5, 10.5],[13.0, 0.5, 10.5],[10.5, 1.0, 10.5],[13.0, 1.0, 10.5],[10.5, 0.5, 14.0],[13.0, 0.5, 14.0],[10.5, 1.0, 14.0],[13.0, 1.0, 14.0]]

    it "returns vertices" do 
      expect(subject.vertices).to match_array(s_origin)
      expect(decimal_cuboid.vertices).to match_array(d_origin)
    end 

    it "updates vertices after moved" do 
      subject.move_to!(0, 0, 0)
      expect(subject.vertices).not_to match_array(s_origin)
      decimal_cuboid.move_to!(0, 0, 0)
      expect(decimal_cuboid.vertices).not_to match_array(d_origin)
    end 
  end 
  
  describe "#intersects?" do
    let(:other_cuboid) { Cuboid.new([10, 10, 10],[2, 1, 3]) }
    let(:big_cuboid) { Cuboid.new([9, 9, 9,],[4, 2, 5]) }
    

    it "true when intersecting" do 
      expect(subject.intersects?(other_cuboid)).to be true
      other_cuboid.move_to!(10, 10, 9)
      expect(subject.intersects?(other_cuboid)).to be true
    end 

    it "handle intersection by a decimal amount" do 
      other_cuboid.move_to!(10, 9.01, 10)
      expect(subject.intersects?(other_cuboid)).to be true
    end 

    it "handle bigger cuboid encompassing smaller cuboid" do 
      expect(subject.intersects?(big_cuboid)).to be true
    end 

    it "false when sides are touching" do 
      other_cuboid.move_to!(10, 9, 10)
      expect(subject.intersects?(other_cuboid)).to be false
    end 

  end

  describe "#rotate!" do 
    it "rotates in the simple happy case" do 
      expect(subject.rotate!(["x", "y", "z"].sample)).to be true
    end 

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

    context "invalid axis" do
      it "raise error" do  
        expect { subject.rotate!("a") }.to raise_error("INVALID AXIS")
      end 
    end 
    
    context "shifts if out of bounds after rotate" do

      let (:walled_cuboid) { Cuboid.new([1, 1, 1],[3, 7, 12]) }

      it "x axis" do
        walled_cuboid.rotate!("x")
        expect(walled_cuboid.origin).to eq [1, 1, 0]
        expect(walled_cuboid.dimensions).to eq [3, 12, 7]
      end  
      it "y axis" do
        walled_cuboid.rotate!("y")
        expect(walled_cuboid.origin).to eq [1, 1, 0]
        expect(walled_cuboid.dimensions).to eq [12, 7, 3]
      end  
      it "z axis" do
        walled_cuboid.rotate!("z")
        expect(walled_cuboid.origin).to eq [1, 0, 1]
        expect(walled_cuboid.dimensions).to eq [7, 3, 12]
      end  
    end
  end 
end
