# Communication log
## Instructors

### Thursday, March 24th 2010
* Olivier went to see Rick Osborne to discuss MongoDB table associations and asked him whether relational (references) or embedded associations had advantages over one another. 
The goal was to help him define how to associate the tables for each of the models in the Roomies UML structure. Rick admitted he didn't know of any performance advantage. Olivier concluded that Models that need to be accessed independently should use references (relational associations) and Models that don't could safeluy be embedded within other Models using MongoDB's unique capabilities.


