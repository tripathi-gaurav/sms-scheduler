**SCHEDULED SMS**

**TEAM MEMBERS**

- _Gaurav Tripathi_
- _Saurabh Bothra_

**URL OF DEPLOYED APP**

- sms.saurabhbothra.xyz
- sms.webassembly.site

**GITHUB URL**

- [https://github.com/tripathi-gaurav/sms-scheduler.git](https://github.com/tripathi-gaurav/sms-scheduler.git)

**APP DEPLOYED AND WORKING?**

Yes, the app is deployed and is working.

**ROLES OF TEAM MEMBERS**

**Saurabh Bothra:**

- Worked on creating migrations, context and schemas for **users**
and **messages** tables.
- Created controllers and templates for all tables.
- Created a plug to hold the user&#39;s state.
- Created session for user.
- Implemented login functionality for the app.
- Implemented password functionality for the app using Comeonin
library in elixir.
- Integrated individual templates to avoid scaffolding.
- Created channel and webhook for receiving the messages from twilio.
- Implemented UI using Bootstrap.
- Worked on handling error messages.

**Gaurav Tripathi:**

- Implemented OAuth functionality using GITHUB.
- Added profile picture for each user by retrieving the avatar url
from github.
- Integrated the Twilio API with our app for sending messages.
- Created webhook for receiving messages.
- Implemented the scheduling functionality for sending messages using
GenServer and Supervisor.
- Involved in modifications of certain fields for our tables.
- Designed the entire flow of our app.
- Worked on handling error messages.
- Worked on improving the UI using Bootstrap.

**WHAT DOES OUR PROJECT DO?**

The app &quot;Scheduled SMS&quot; lets you send messages both in real
time and scheduled for later. Once the user signs in, he will see his
dashboard page wherein the user can see his profile details. He can
see his message history and also send messages. He can either send
messages immediately or schedule it for a later time to send the
message. The user can receive immediate replies from the person he
has sent the message. For sending the message, the user needs to get
a Twilio number and then he can send the message using this number.

**HOW DO USERS INTERACT WITH YOUR APPLICATION? WHAT CAN THEY
ACCOMPLISH BY DOING SO?**

The user needs to first register in our app by creating an account.
S/He needs to provide her/his name, email, phone and set a password
for creating his account. Once the account is created, he is
redirected to the login page for signing in the app. The user can
also sign in using his/her GitHub account. The purpose of having the
user to register or login is to provide a secure access to our app
and to protect user&#39;s personal information. A user won&#39;t be
able to see the message history or personal information of other
users.

The user after signing in will be redirected to his dashboard page
wherein the user can see his profile details and his message history.
He can then securely send messages or schedule it for a later time.

**FOR EACH PROJECT REQUIREMENT, HOW DOES YOUR APP MEET THAT
REQUIREMENT?**

This app has significant complex features like implementing OAuth
functionality for users, integrating TWILIO API with our app for
sending and scheduling messages which involves using Application
Supervisor. It also involves implementing a webhook which will be
used by twilio to send back the reply messages as a json body which
is then accessed through the phoenix channel and displayed to UI. The
features of the app is implemented on the server side in Elixir. The
app is completely deployed on the VPS. The app has user accounts and
supports local password authentication implemented securely. The user
information and its message history is completely stored in Postgres
Database. The app also supports OAuth feature where the user can
login to the app using GITHUB. The app is also using phoenix channels
to send immediate reply messages back to the sender.

We are using lot of elixir libraries in our app.

- comeonin library for implementing the password functionality for
our app.
- ex-twilio library for sending the messages.
- auth2 library for allowing the user to sign in to the app using
GITHUB.
- timex library for handing data and time management.
- sched\_ex library for handling scheduling of messages.

**WHAT&#39;s THE COMPLEX PART OF YOUR APP? HOW DID YOU DESIGN THAT
COMPONENT AND WHY?**

There were many complex parts in our app. One of them was to handle
the scheduling of messages wherein we had to create a worker process
and add it to the Application Supervisor. Sched\_Ex library in Elixir
creates and manages similar things which cronn jobs does. We created
a worker process and added it to the Application Supervisor with the
restart strategy set to **:temporary** so that it does not restart
after execution.

Handling date and time management was also another complex part
wherein new timezone requires the TZ database to be added.

**WHAT ADDITIONAL FEATURES DID YOU IMPLEMENT?**

The app is also using phoenix channels to send immediate reply
messages back to the sender. We created a webhook which will receive
the JSON Body from Twilio containing the reply. This reply is then
sent to the UI for display using Phoenix channels.

We are using lot of elixir libraries in our app.

- comeonin library for implementing the password functionality for
our app.
- ex-twilio library for sending the messages.
- auth2 library for allowing the user to sign in to the app using
GITHUB.
- timex library for handing data and time management.
- sched\_ex library for handling scheduling of messages.

**WHAT INTERESTING STUFF DOES YOUR APP INCLUDE BEYOND THE PROJECT
REQUIREMENTS?**

Beyond the project requirements, app is using phoenix channels to
send replies back to the sender. We have also created a webhook to
which Twilio send the json body which has the replies. We have
created a worker process for handling the scheduling of messages.
This process is added to the Application Supervisor with the restart
strategy set to **:temporary** so that it does not restart after
execution. We have used a lot of elixir libraries for implementing
features like passwords, sending messages, user authentication, date
and time management.



**WHAT WAS THE MOST SIGNIFICANT CHALLENGE YOU ENCOUNTERED AND HOW DID
YOU SOLVE IT?**

We faced a lot of significant challenges during the course of the
project.

One of them was to handle the scheduling of messages wherein we had
to create a worker process and add it to the Application Supervisor.
Sched\_Ex library in Elixir creates and manages similar things which
cronn jobs does. We created a worker process and added it to the
Application Supervisor with the restart strategy set to
**:temporary** so that it does not restart after execution.

Handling date and time management was also another complex part
wherein new timezone requires the TZ database to be added.

We also faced problem using the ex\_twilio library. We had to go
through the library and Twilio APIs before implementing it.

We even faced significant difficulty using Bootstrap which we used
for improving the look ad feel of our app. We followed the Bootstrap
documentation and studied about lot of styles used.

Design the flow of UI was another challenge we faced and it took us
time to come up with the final look of the app.