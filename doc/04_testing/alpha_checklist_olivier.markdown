* If the user does not belong to a house, they will see a build a house button to view the house creation modal.
* The user can click on the add assignment button if they have a house to see the new assignment modal.
* The user's avatar is generated from gravatar.

# Works
- Users can log in using their credentials
- Users can log out
- Users ask to reset their password and receive a notification from the UI and an email with a reset link.
- Users can try to change their password once that reset link has been accessed, it doesn't work because of email validation.
- Even though sign up work without JavaScript, the name field mysteriously disappears on click to the submit button. The second click successfully signs up the user.
- The JS-less sign in form works like a charm.

## Home
- Users can sign up with Twitter & OAuth
- Users can sign up with their email account
- Users can add Facebook as a sign in method from /authentications
- There are screenshots of the application under the ben
* Users can click the sign in button to see a sign in modal.
* Users can choose to have their own password or have one generated for them.
* A registration email is sent to a new user when they sign up.efits, but they should link to larger images or play an inline video.

## Corkboard
- Users can switch between present-centric and week-centric calendar
- Users can switch between their assignments and everyone's assignments
* The user will see a notice to tell them if they have past due assignments.
* The user will see a notice to prompt them to fill in their name if they haven't done so.
* The user will see a notice to let them know if they've been invited to someone's house.
* The user will see a link to accept invitations to a house
* The user can click on the my assignments or everyone's assignments to filter their own assignments from everyone's.
* The user can click on the upcoming or monthly links to switch between a present centric view and a traditional calendar.


## Assignments
- Users can see past due assignments
- Users can see all current assignments: past due, completed and still due

## Profile
- Users can change their name from their user profile
- Users can change their email (no confirmation)
- Users can change their password (no confirmation)
* The user can click on the edit profile link under their avatar to view the edit profile modal.
* The user can change their profile information, and see how to change their avatar from the edit profile modal.
* The user can click the change house name link on their profile page to view the change house name modal.
* The user can click the add roomies link on their profile page to view the invite Roomie to house modal.
* An invitation email is sent to the invited user.
* The user can click the move out link on the profile page to remove themselves from their current house.
* The user can view the total number of tasks from the profile page.


## Content pages
- Users can submit a support request through the support page
* A support email is sent to us containing the user's message.

---
# Doesn't Work
- The password reset form doesn't ask users for their email address.
- The password reset link from the email the user receives doesn't have a dynamic URL to the app.
- The password change page refuses to change password claiming the email field can't be blank even though there is no email field. The user's email needs to be fetched based on the reset password token.
- Vertical text alignment with input text field isn't correct.

## Home
- Users can't sign up with Facebook or Google
- Users can't sign in with Google

## Corkboard
- The user preference for which calendar to display by default is not stored on the user model.
- Some UI strings need to be lowercased with CSS
- Users can't hover over the color badge of an assignment to see a check mark and complete the assignment in place.

## Assignments
- Users can't create recurring assignments
- Users can't choose an assignment category (relates to Achievements)
- If users forget to enter a due date, assignments are not visible on the corkboard, only on the assignments page.
- The layout of the assignment creation panel needs fixing.
- Users can't confirm assignments that have been completed by other roomies they assigned to a task or expense.
- The complete assignment button is not styled yet.

## Profile
- Users can't see/add/remove their authentication methods on their profile settings
- The Task and Expense counts on the user profile is not accurate
- The point count on the user profile is not accurate
- The next achievement on the user profile is not accurate
- There is no confirmation when users change their password
- There is no confirmation when users change their email

## Achievements
- Users are notified when they receive rewards but cannot see the list of their past rewards
- Users don't receive achievements after receiving a specific number of rewards
- Users can't see a list of their past Achievements
- Users can't see an overview of their progress towards their next achievement on their Profile
- Users can't see an overview of their roomies' progress on their profile

## Content pages
- There is no About Us page
- There is no Privacy Policy
- There are no terms of service
