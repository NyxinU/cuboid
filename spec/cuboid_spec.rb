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
      expect(subject.dimensions).to eq [2,1,3]
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
