h1. Weekly Report #2

h2. Structure Document

h3. Core functionality

This last we was spent doing some hard thinking on the structure of the application. Assignments are at the core of the Roomies experience, but determining exactly how to handle them based on the specific needs of each group of roommates is trickier than it sounds.

During our discovery process we identified basic assignements: tasks and expenses. These basic assignements both have repeating versions (chores and bills) which relatively straightforward as they simply add a repetition frequency and inherit the same properties.

During development we will focus on locking down functionality for these 4 types of assignments. Yet, we identified interesting use cases in other types of assignments that would be both more modular and give Roomies a stronger personality.

h3. Composition vs. Inheritance

As you will be able to see on the UML diagram we produced for the structure document, there are 4 types of assignments standing apart from those 4 other basic ones I just described.

Those assignments do not inherit their properties and functionality directly from tasks and expenses. Instead they receive the basic properties of the assignment model and add a very limited set of features. Freebies and Bounties implement the commissionable trait that allows one roommate to create an assignment.

Gifts and Wishes inherit their properties directly from Freebies and Bounties, to which they add the Payable "trait".

h3. Traits

Traits are stripped down modules of functionality designed to be aggregated together to create a specific set of features. We've always said the way Roomies is used in a real environment is likely to surprise us and defy any boundaries that we set up. Using traits we can ensure that adapting to scenarios we didn't envision for the application will be as easy as adding a trait to any of these assignment types, or simply to create a brand new assignment type based on a different combination of traits.
gv
h2. Technologies
* MongoDB & Mongoid (the Rails ODM for MongoDB) to define the new Trait system and make it work properly in practice.
* CoffeeScript to add basic AJAX in order to edit a user's profile, create a new house, and leave a house through modal panels. We had to test 
roomies to a house
* Haml & Sass to turn all wireframes into equivalent protosite pages
  with basic functionality.

h2. Upcoming
1. At the begining of the week we will proceed with turning all
   wireframes into static comps to define a baseline for how we will
incorporate our branding and visual identity into the protosite.
2. Before we resume development we will start writing unit tests for all
   the functionality defined in our requirements. Once those tests
running (continually in our development environement) we will make sure
they are positive before adding any functionality outside the scope we
defined.
3. Once tests are green, we will start incorporating UI elements from
   the comps into the protosite and define integration tests to ensure
all required UI elements are present.

h2. Contacts

h3. John Allsopp

During a casual exchange on Twitter I (Olivier), established contact
with John Allsopp, a reknowned software developer from Australia who
specializes in HTML and CSS. He wrote Developing with Web Standards, the
companion to the acclaimed Designing with Web Standards from Jeffrey
Zeldman. He was extremely friendly and I plan on asking him for feedback
on Roomies early in our development cycle.

h3. Andrew Smith

In our early testing of several Rails libraries (OAuth authentication,
user signup, MongoDB integration, object & document-oriented database)
design Andrew has once again been an invaluable resource thanks to his
experience at EnvyLabs and beyond.

h3. Rick Osborne

After our change of direction with the database modeling, I went to
consult with Rick in order to see whether we were missing important details in our design.
