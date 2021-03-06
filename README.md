# Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# DelhiMetro

This app is a protoype concept of a metro system that can be used while maintaining social distancing during the COVID-19 pandemic.
The app assumes that the local officials/authorities will help out with smooth flow of traffic and that all data of the existing trains,
stations and other systems will be available to us.

# How the App works:

The user will first download the app and book his/her seat from Station A to Station B using the app and pay for it using online transactions
like credit card, debit card, digital wallets and UPI. The user will first be logged in and verified and then directed to book their ticket from Station A 
to Station B, after which they will proceed to another page which will limit the time slots that they can book, these time slots will vary from 30 to
90 minutes from the time of booking. This is done to prevent sudden rush and that things go smooth.

The user will enter the metro station, given that they ticket has been booked, then proceed to scan the QR code at the station;s barricades.
The barricades will then open and let the user proceed to platform. They will take the train assigned to them at the given time and a new train will
come to station at a frequency of 5 minutes.

If the user has to change lines(like from yellow to magenta line), the system works such a way that when user booked the ticket, 5 minutes of travel time
will be given to user. For example, user books for a train at 4pm and at 4:30 pm reaches the station where he/she is supposed to change lines, the system
would have automatically booked a train from 4:35pm to further take the user to his/her destination. On reaching destination, user will scan the 
QR code on the barrier to open it and the onsite help will be there as usual to help out in case of any issues.

# Tech Stack:

1. For mobile application, we used Flutter SDK, which is a cross platform SDK.
2. Firebase to handles the database.
3. Python server written from scratch, that communicates using Socket programming between app and database.
4. Google Cloud Platform for hosting the server (it creates a new IP address every 24hrs, so it is hardcoded for now).

# Server:

The server works on Google Cloud platform and the IP changes every 24hrs, so it is recommended to run the app on a localhost for testing purpose.

 # 1.To run Locally:

The server python file is included in the project under the folder "server".
First cahnge the "host" variable to your own IPv4 address and set the post to 8080.
Then run the python file using command:
'python app.py' or 'python3 app.py'

The server will be live and show the message in terminal that the Socket is listening.

# 2.To run on GCP:

The server will runon it's own IP and the app has to make sure that it is connected to the same IP, so after you
upload it on the GCP, note down the IP address that GCP provides and enter the same in the Flutter app in "./lib/ConfirmationPage.dart"

Server can check which trains to take given that station A and station B has been entered, and also if there is a seat avaliable in the train or not.
The server also makes sure that not more than 50(arbitary number,it can vary later on) seats are booked for each station, to prevent case,
of all seats getting booked at first station itself.

Server performs the basic functions to allow user to book ticket. The server can be scaled to computer other details too, but siunce this was done in less than one week's time, 
we could'nt have done any better than this.

# 3. Installing dependencies:

Assuming that python 3.x has been installed already along with pip package installer.
Dependecies: firebase-admin, socket, os, threading

To install firebase admin library:
pip install firebase-admin

Rest of the dependecies should be installed when you download python itself.

NOTE: server folder includes a key.json which is important file as it contains important details needed for connecting to firebase.


# HOW TO RUN APP:

The IP at which server is running needs to be hard coded for now in "./lib/ConfirmationPage.dart" and set port to 8080.
After this you can run the app using:

flutter run
(to run in debug mode)
OR
flutter run --profile
(to run in release mode)

Perform this command in the root directory of the project. Assumming you have installed FLutter,if not go to 
https://flutter.dev/docs/get-started/install , andthe app should work fine.

We have attached some screenshots for the app in action.

NOTE: If you get an error while runing app.py locally, saying that key.json not found, then just copy the folder
to some other location, and open the folder with your IDE, I Use VS Code, and then retry.

NOTE: Limited station only exist for testing purpose, so it may haapen that not all slots will book ticket for now 
as it is not completely developed but developed enough to prove the concept.

# Screenshots
<img src="screenshots/screen_1.jpg" width="25%"><img src="screenshots/screen_2.jpg" width="25%"><img src="screenshots/screen_3.jpg" width="25%">
<img src="screenshots/screen_4.jpg" width="25%"><img src="screenshots/screen_5.jpg" width="25%"><img src="screenshots/screen_6.jpg" width="25%">
<img src="screenshots/screen_7.jpg" width="25%">
