# Rails Coding Challenge

Write code that represents 3D objects in space - to keep it real simple, only "rectangular cuboids." That way you could represent one by having an origin (z,y,x) and length, width, height. Of course, you should be able to create (initialize) an object at a certain origin, with a certain length/width/height. You should also be able to move your object to a different origin. Additionally, you should be able to get a list of the vertices that represent the cuboid (a total of 8 vertices). 

Now here's the important part - write a method that tests whether or not 2 cuboids are overlapping. 

Bonus points:
Allow your objects to rotate (to keep it simple, only at 90 degree angles). The "tricky" part about the rotation is that - imagine the origin is walled - a rotation of an object that is up against a corner would also require the object to shift if you are rotating the object around its origin. This restriction exists because the objects are actually part of a bin packing algorithm - meaning the objects are inside a box and can only exist within the walls of the outer box. 




