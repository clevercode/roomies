Hi everyone,

The past week has been fairly busy, between locking down the project plan and requirements and ironing out the structure of the project we also got a head start on wireframing and prototyping.

h1. Accomplishments

h2. Project Plan

We produced a concise project plan addressing more thoroughly our vision for Roomies, what our philosophy is and what we do so you can know what to expect. We went over the tools and technologies we use, our production process, budget & timeline for the project. Finally we talked about the launching pad for Roomies, our marketing campaign, pricing model and how we expect Roomies to be a successful product both technically and financially.

!http://clevercode.net/assets/images/roomies/week01_graphic.jpg(Documentation)!

h2. Requirements

We kept our requirements streamlined to short user stories because we can't promise you that we know the ending for all of those. This is why we put such a strong emphasis on testing. We currently have 20 users subscribed to our private beta which will be an invaluable tool for us to refine our common vision of what Roomies should do and how.

h2. Data Modeling

Following weeks of intense brainstorming, sketches, filled up whiteboards and debates we produced an initial internal structure for the internal data model of Roomies. We initially built this model using inheritance from basic assignable tasks, only to realize that the variety of tasks (repeatable, payable, assignable, etc) warranted a different approach. On monday we revised our entire structure to create a more flexible and future-proof structure using object-oriented composition. 

!http://clevercode.net/assets/images/roomies/week01_uml.png(UML)!
* The first iteration of the data modeling diagram *

We now have different types of tasks that each implement specific features. Since more than one user can be assigned to each specific task, we decoupled users from those by created an intermediary assignee that simply refers to one user and one task. This allows use to create a more loosely coupled internal architecture, which, in a project as likely to evolve as Roomies, can only be beneficial.

The last part left for us to define will be the intricacies of our achievement system, which will be composed of points and achievements with specific point values. Points are awarded upon successful (and confirmed) completions of tasks.

The original classical UML diagram I produced was not presenting this intricate structure properly. Instead I started sketching a series of nested Venn diagrams in order to represent the shared functionality of our composed data models.

h2. Wireframing

!http://clevercode.net/assets/images/roomies/week01_wireframes.png(Wireframes)!
*A preview of the initial batch of wireframes*

After several rounds of rough initial sketches on paper and whiteboards, we produced wireframes for each of the sections detailed in our requirements document. We presented initial iterations of those wireframes to Marianne and will present new ones to our working group on Monday. I also reached out to Gus Hernandez in order to receive his input on the information architecture presented on these wireframes, we will meet this week.

Zach has already begun turning these wireframes into HTML views (composed in "Haml":http://haml-lang.com/ & "Sass":http://sass-lang.com/) so that we can use them with our protosite and iterate quickly on them until we are ready to turn them into full-fledged live comps that we will be able to click through in order to test page flow, initially without functionality.

!http://clevercode.net/assets/images/roomies/week01_protosite.png(Protosite)!

This will give us the opportunity to make our core functionality usable and especially user-testable as soon as possible so we can confront our information architecture and user experience to reality.

h2. Sitemapping

In the spirit of better defining the structure of the site we produced a rough sitemap with the public facing pages available for users. Now there are more actions available on the site than this diagram below presents, but since one of our main goals is to reduce the time people spend dealing with household tasks many of these actions will be aggregated inside of the same page. A good example being the Corkboard and Profile which will allow users to add tasks and edit existing data inline without having to be redirected to additional pages.

!http://clevercode.net/assets/images/roomies/week01_sitemap.png(Sitemap)!

This will require AJAX calls throughout the site to fetch relevant forms and data while allowing users with no JavaScript enabled to access a more basic but functional version of the site.

h2. Prototyping and Technology demos

In parallel with my work on the data modeling of Roomies, I experimented with the JavaScript libraries we will use throughout the project during our client-side development phase to see if any problems might arise. 

The natural language date parser (DateJS) we chose to use to allow users to not only pick dates from a calendar when creating tasks but also be able to write them down in plain english is relatively old but interacts extremely well with jQuery and the jQuery UI components (datepicker for instance) we will be using throughout the project to accelerate and simplify data entry.

h1. Technologies

Over the past week we have become familiar with or have started working with the following technologies.

* "MongoDB":http://www.mongodb.org/ (document-oriented storage with a JSON-like storage structure) to produce aggregated data models in Ruby on Rails.
* "Mongoid":http://mongoid.org/ a beautifully maintained and documented ODM (Object Data Manager) that allows our Rails models to communicate seamlessly with MongoDB in very similar fashion to how Rails interacts with more common MySQL, SQLite or PostgreSQL databases.
* "CoffeeScript":http://jashkenas.github.com/coffee-script/ to produce clean, legible and more object-oriented JavaScript with a more Ruby-like syntax in its precompiled state.
* "DateJS":http://www.datejs.com/, "jQuery":http://jquery.com and "jQuery UI":http://jqueryui.com/ as explained earlier.
* "Haml":http://haml-lang.com/ & "Sass":http://sass-lang.com, two meta-languages that allow us to write clean, non-repetitive and more functional HTML markup and CSS styles. Notably by adding primitive functions (mixins) and variables to CSS which greatly improves our ability to support multiple browsers and keep our views organized and coherent.

h1. Upcoming work

Here are a few items we will complete or start working on this week.
* Wireframes (completion and refinements)
* UML (remodeled after the modifications discussed above)
* Initial protosite (click through) release based on Wireframes
* Enhancement of protosite with high quality UI elements (background, color schemes, interactive buttons, basic client-side behavior) to reach initial comp quality
* Initial task & expense core functionality
* Initial work on laying down Test-driven development groundwork based on our requirements
* Etc.

h1. Contacts

h2. Rick Osborne

We have reached out to Rick Osborne since he has been presented the MongoDB technology to his students during the most recent SSL/DBS course, he provided us with some advice and information about it.

h2. Gus Hernandez

As explained earlier, we will present our wireframes to Gus Hernandez this week for thorough inspection and deconstruction. User experience matters to us especially for Roomies, so his experience and Chris Burke's will be invaluable to us throughout this project.

h2. Andrew Smith

Andrew Smith has provided us – in his role of technology consultant for Rails and MongoDB on this project - with countless advice and guidance regarding best practices in Object-oriented data modeling for Rails using MongoDB. We discussed pricing schemes and billing systems with him as well. He is currently developing an internal application for cleverCode using similar technologies as the ones we chose to use on Roomies. He regularly saves us countless hours of aimless research by pointing us in the right direction and giving us his perspective on our work so far.

h2. External contacts

h3. Gregg Pollack

We have been in loose contact with his employer, Gregg Pollack, with whom we previously worked as freelancers before Andrew was hired at "Envy Labs":http://envylabs.com/ regarding a potential opportunity once we complete this project. He asked to be the first person we talk to.

h3. Tim Van Damme

In the hopes of obtaining advice and perspective on user experience and design, I've been in regular contact with "Tim Van Damme":http://timvandamme.com/, interface designer at "Made by Elephant":http://madebyelephant.com/ and "Gowalla":http://gowalla.com/ after we met with Anthony Colangelo, Andrew Smith and Alicia Brooks at the Future of Web Apps conference in New York City last November.

h3. Aral Balkan

We also had the pleasure of meeting "Aral Balkan":http://aralbalkan.com/, experience designer and creator of "Avit":http://avitapp.com/ and "Feathers":http://feathersapp.com/, at the same conference. We expect to ask him his opinion about Roomies as soon as we have a working beta since he has been a great inspiration for our vision of the user experience on this project.

h3. Others

Other notable contacts we plan on reaching out to include "Paul Irish":http://paulirish.com/ and "John Allsopp":http://johnfallsopp.com/ since their respective expertise in JavaScript and HTML/CSS was essential to several of the technologies we will use on this project. But most importantly they are among the surprisingly nice and easy to approach people we have been in contact with in the industry over the past few months and we can't wait to hear what they think of Roomies.

