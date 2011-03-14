# requirements for Roomies 

version 1.2
March 9th, 2010

## table of contents

1. Introduction (p.3)
2. Revision History (p.4)
3. Approvals (p.5)
4. Reviewers (p.5)
5. General Notes (p.6)
6. Detailed Requirements (p.7)
7. Legal & Copyright Information (p.11)

## introduction

This document outlines the business requirements for 
roomies. The requirements may be updated or revised when 
necessary. Revisions for the project will be noted here along 
with final approvals.

### revision history
1. 03-02-2011 – Zachary Nicoll – 1.0
  Created document
2. 03-07-2011 – Olivier Lacan – 1.1
  Added page-speciﬁc requirements for Home, About, Tasks/Expenses,  Notiﬁcations
3. 03-09-2011 – Zachary Nicoll – 1.2
  Added page-speciﬁc requirements for Achievements and cleaned up some copy for the official deliverable

## approvals

## reviewers

## general notes

Roomies saves time by dealing with tedious or repetitive tasks. It saves money by helping you to not forget to pay rent, utilities, and bills. It saves friendships by saving everything else. 

Roomies takes care of reminding your roomies that they owe you money for rent or groceries. You don't have to nag or be passive aggressive about it, and it makes living together easier. 

Roomies gives you peace of mind. Once you set roomies up, it's our responsibility to remind you of what is due. If we ever mess up, you get one month of free service. If it happens again (we don't count on it) you get two months. Again? Four months. You get the picture. It's not in our best interest to disappoint you, and if we did we wouldn't just be losing your trust, we would be losing money as well.And we really can't afford to lose either.

Think about what matters. Sure, bills are important, but it's not something you want to think about all the time. When you have something better to do, like studying for a final, going out with friends, spending all night refreshing Twitter & Reddit, or working on getting your dream job doing what you love, you dedicate yourself to it without worrying if your forgot to pay this or that.

## user stories

### home page
  * 1.1.1 – Users should be able to sign in/log in.
  * 1.1.2 – Users should be shown screenshots of the application.
  * 1.1.3 – Users should be shown a screencast of the application workflow.
  * 1.1.4 – Users should be able to register directly from the home.
    page.
  * 1.1.5 – Users should be able to read testimonials from existing
    Roomies users.

### about page
  * 1.2.1 – Users should be able to learn more about us and what motivated us to create Roomies.
  * 1.2.2 – Users should be able to read our mantra.
  * 1.2.3 – Users should be able to see a character from James Cameron's
    Avatar.

### corkboard page
  * 1.3.1 – Users should be able to quickly notice urgent and past due
    tasks & expenses.
  * 1.3.2 – Users should be able to view a present-centric calendar of 
    tasks & expenses due in the near-future.
  * 1.3.3 – Users should be able to view lower in the page a long-term
    list of tasks & expenses.
  * 1.3.4 – Users should be able to click on "Add task" & "Add
    expense" buttons taking them to the expense & task creation page
  * 1.3.5 – Users should be able to click on a listed task or expense
    and view a page with more details.
  * 1.3.6 – Users should be able to see what tasks where completed or
    not by their roomies.

### expenses & task creation/update page
  * 1.4.1 – Users should be able to create/edit/delete a task.
  * 1.4.2 – Users should be able to create/edit/delete an expense.
  * 1.4.3 – Users can change the status of a task/expense (active or
    completed)

### achievements page
  * 1.5.1 – Users should be able to view recent achievements.
  * 1.5.2 – Users should be able to view progress on gaining other achievements.
  * 1.5.3 – Users should be able to compare their achievements with other roomies.

### privacy policy page
  * 1.6.1 – Users should be able to clearly understand what we do with
    the data they enter in Roomies.

### terms of service page
  * 1.7.1 – Users should understand that if they try to abuse any aspect
    of the application, we will ask them to stop doing so and if they
don't comply we reserve the right to suspend their account.
  * 1.7.2 – Users should know that any interruption of service will
    trigger automatic refunds and free months of subscriptions in case
of repeated interruptions.

## detailed requirements

These thorough descriptions of page contents follow the same structure
as the user stories above.

### home page
  * 1.1.1.1 – sign in form : email field, password field, sign in
    button, remember me checkbox
  * 1.1.2.1 – screenshot assets
  * 1.1.3.1 – screencast asset
  * 1.1.4.1 – sign up form : name field, email field, password, sign up button
  * 1.1.5.1 – testimonials copy from beta testers

### about page
  * 1.2.1.1 – story of roomies copy
  * 1.2.2.1 – our philosophy copy
  * 1.2.3.1 – team photo assets

### corkboard page
  * 1.3.1.1 – corkboard-like background
  * 1.3.1.2 – large display of urgent & past due tasks & expenses
  * 1.3.2.1 – calendar-like list of tasks & expenses due today and tomorrow
  * 1.3.3.1 – list-view of tasks & expenses due in the long term
  * 1.3.3.2 – label on each list item indicating the assignees for the
    task or expense 
  * 1.3.6.1 – list-view of tasks & expenses that have more than one
    person assigned to them
  * 1.3.6.2 – shows whether or not that particular roommate completed
    their part of the task or expense

### expenses & tasks creation/update pages
  * 1.4.1.1 – task creation/edit form: purpose field, due date field (with
    automatic date parsing), recurring date checkbox, assignees field,
create/edit button (if edit, display status radio button & delete task link)
  * 1.4.2.1 – expense creation/edit form: purpose field, due date field (with
    automatic date parsing), recurring date checkbox, cost field,
assignees field, create/edit button (if edit, display status radio button & delete task link)

### achievements page
  * 1.5.1.1 – grid-view of recently earned achievement badges
  * 1.5.2.1 – list-view of achievements the user is closest to earning
    with progress bar
  * 1.5.3.1 – list-view of the user's and their roommates achievements
    comparing each person and who has earned what
  * 1.5.3.2 – shows a total score for each person for easy comparison

## legal & copyright

This document is not a formal project plan. It is simply a way for us to
organize what we want to offer users inside each section of the site.

We trust that you will keep this production document private, if you
wish to make it public, please ask us beforehand. Thank you.

© cleverCode LLC. All rights reserved.

