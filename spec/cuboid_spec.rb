require 'cuboid'

#This test is incomplete and, in fact, won't even run without errors.  
#  Do whatever you need to do to make it work and please add your own test cases for as many
#  methods as you feel need coverage
describe Cuboid do
 
  describe "move_to" do
    it "changes the origin in the simple happy case" do
      expect(subject.move_to!(1,2,3)).to be true
    end
  end    
  
  describe "intersects?" do
  end

end
