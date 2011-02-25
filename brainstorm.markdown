# Roomies

## Who needs it
* College students like us

## Why do they need it?
* Splitting rent & paying it on time
* Splitting utilities & paying them on time
* Splitting bills & paying them on time
* Splitting groceries and other expenses
* Assigning tedious tasks fairly
* Keep up with small personal loans to other roomies, friends &
  classmates

## Who wants it?
* Us
* People who aren't organized or are too busy (school, work, etc.)
* People who can afford it
* People who can trust the internet with their expenses

## Who doesn't want it?
* Neatly organized people
* Older people or people who don't trust computer & the internet to
  remind them what to do or to keep their data secure
* People who live alone (like bobo)
* People who already use task/cost management software they deem
  adequate

## What value does Roomies offer?
* Saves time: dealing with tedious/repetitive tasks
* Saves money: forgetting to pay rent/utilities/bills can be costly
* Saves friendships: "Good counts make good friends" (French saying).
  Roomies takes care of reminding your roomies that they owe you money
for rent or groceries. You don't have to nag or be passive aggressive
about it, and it makes living together easier.
* Peace of mind: once you set Roomies up, it's our responsibility to
  remind you of what is due. If we ever mess up, you get 1 month of free
service, if it happens again (we don't count on it) you get 2 months.
Again? 4 months. You get the picture. It's not in our best interest to
disappoint you, and if we did we wouldn't just be losing your trust, we
would be losing money as well. And we can't afford either.
* Think about what matters: sure bills are important, but it's not
  something you want to think about all the time. And when you have
something better to do - studying for a final, going out with friends,
spending all night refreshing Twitter & Reddit or working on getting
your dream job doing what you love - you dedicate yourself to it without
worrying if your forgot to pay this or that.

## Core features
* Expense management & sharing
* Task management & sharing
* Notifications & reminders

### Expenses
* Add rent/split rent
* Add utilities/split utilities
* Add internet/cable bills & split them
* Add personal loans

### Tasks
* Add recurring house chores
* Add special events (parties, birthdays, exams, vacation)
* Add groceries runs
* Add airport/train station pickups

### Notifications
* Notify roomies of:
  * Incoming / Due / Past Due:
    * Rent
    * Utilities
    * Bills
    * Personal loans
  * Incoming / Ongoing Events

## Technologies

### Server-side
Since the scope of this project extends beyond its Full Sail University
context we intend on using Ruby on Rails to power the application. 

1. We have used the technology in the past for our projects at
   cleverCode and would like to become comfortable enough to seek
employment in a company that uses Rails and Agile development in the
future

2. We understand that even if we restrict the scope of this first
   iteration of Roomies, using a technology that allows us to roll out
core functionality and concentrate on the details of the application -
the user experience - will make it possible for us to achieve the
product we have in mind.

3. The deployment platform we want to use - Heroku - allows us, as
   students to deploy at no cost in an industry-standard environment.
This means we Roomies will be fully usable once our final project is
complete. It also means we will have a lot of flexibility to clone the
source code for the application and evolve it without damaging the
integrity of the final project we turned in for presentation.

4. Considering the new technologies we plan on using (see later sections
   for details) Rails will save us time which we expect to use for
debugging and making sure the Roomies experience is consistent across
all platforms we choose to target.

5. We are fully aware that no instructors at Full Sail is familiar with
   either the Ruby programming language or the Rails framework but we
will enlist the help - as a credited consultant - of Andrew Smith, a
2010 Full Sail WDD graduate who has been working for the past months at
a local company specializing in Ruby development. He will not be allowed
to code on the project but his advice will be seeked for code reviews
that involve Ruby and Rails.

#### CRON Jobs
The notifications require that we use a specific server-side feature
called CRON jobs, basically it means our server-side code will register
a time and date to have a specific script executed in order to notify
users of a task or a due expense.

Thankfully we might find a solution that does not involve using our own
server for this (as we suspect Heroku might be starting to charge for
such a feature) and instead use a remote service that would either send
the email notifications on its own, or call our API periodically 

### Client-side
Since it requires a lot of user input and data manipulation, Roomies
would benefit greatly from modern in-browser technologies like
localStorage in order to reduce calls to a database as much as possible.

At the same time, several users are likely to be manipulating the same
data sets at the same time, which could provoke collisions (ex: one
roomie splits an expense 40/60 while another splits the same expense
30/70). We will have to develop a way to lock data that is currently
manipulated by a user by flagging it in the database.

1. jQuery: an obvious choice knowing the ambition to create a dynamic
   interface for the application. jQuery 1.5's AJAX promises in
particular would be a boon to data syncing concerns.

2. Backbone: unless we devise our own MVC architecture for the
   JavaScript framework powering the Roomies interface Backbone.js,
knowing how well it integrates with jQuery would be a great way to keep
our client-side code lean and extensible.



### Hosting
1. Source code: GitHub
The development of the application will be done inside of a private Git
repository on GitHub (which will be accessible by instructors) since we
plan on monetizing the application after graduation and the staging and
production servers will be hosted at Heroku.

2. Deployment: Heroku
The staging server where Roomies will be tested prior to public deployment 
will remain untouched once the project is completed and will stay available
as long as Full Sail University sees fit since there will be no hosting costs.

We will not deploy either the development, staging or production builds of the
application to Full Sail's server as they do not support the technology
we will use.

### Mobile
Although Mobile would be an interesting use case for such an application,
a great majority of the uses will be made from a home which will contain
either a laptop or a desktop computer or at work/school.

The task management features of Roomies lend themselves well to a mobile
application since they would allow users to (without
the use of notifications) take a look at their current tasks.

Limiting the scope of the project, we can imagine optimizing the Roomies
website for mobile use to a certain extent while keeping in mind that it
would not compare with the main interface for the application.

A case could be made for tablet computers as a more adequate interface
than either laptops or desktops in the near future.

