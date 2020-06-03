import 'package:flutter/material.dart';

Color darkBlueColor = Color(0xFF283A62);
Color lightBlueColor = Color(0xFF71B9EB);
Color lighterBlueColor = Color(0xFF71B9EB).withOpacity(0.5);
Color customBlueColor = Color(0xFF283992);
Color customGreyColor = Color(0xFF969EB4);

TextStyle pageTitleStyle = new TextStyle(
  fontFamily: 'Helvetica', 
  fontWeight: FontWeight.bold, 
  fontSize: 50,
  color: Colors.white
);

TextStyle tabTitleStyle = new TextStyle(
  fontFamily: 'Helvetica', 
  fontWeight: FontWeight.bold, 
  fontSize: 40,
  color: Colors.white
);

TextStyle textTitle = new TextStyle(
  fontFamily: 'Helvetica', 
  fontWeight: FontWeight.bold, 
  fontSize: 30,
  color: Colors.black
);

TextStyle blogTitleStyle = new TextStyle(
  fontFamily: 'Avenir',  
  fontSize: 20,
  color: Colors.white
);

TextStyle blogDateStyle = new TextStyle(
  fontFamily: 'Avenir',  
  fontSize: 16,
  color: Colors.white
);

TextStyle stationText = new TextStyle(
  fontFamily: 'Avenir',  
  fontSize: 16,
  color: customGreyColor
);

TextStyle selectedTimeText = new TextStyle(
  fontFamily: 'Avenir', 
  fontWeight: FontWeight.bold, 
  fontSize: 16,
  color: Colors.white
);
TextStyle unselectedTimeText = new TextStyle(
  fontFamily: 'Avenir', 
  fontWeight: FontWeight.bold, 
  fontSize: 14,
  color: Colors.white
);