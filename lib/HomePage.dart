/*

This page is responsble for showing the Home Page where 
all the starting and eding station willl be selected by the user.
The data will be then sent to next page for selecting slots.

*/

import 'dart:ui';
import 'package:delhimetro/ConfirmationPage.dart';
import 'package:delhimetro/StartStationPage.dart';
import 'package:delhimetro/global.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String startStationText;
  String endStationText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startStationText = "Select start station...";
    endStationText = "Select end station..."; 
  }

  int currentTab = 0; // to keep track of active tab index

  // For now we are using same screen on all tabs
  final List<Widget> screens = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
  ]; 
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(Icons.camera_alt),
          onPressed: () {},
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        
        body: Container(
          child: Stack(
            children: <Widget>[

              /*Backend image of delhi metro*/
              
              Align(
                alignment: Alignment.topCenter,
                child:Container(
                      padding: EdgeInsets.only(left:50, top: 100),
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                        image: AssetImage("images/metro_1.png"),
                        fit: BoxFit.cover,
                      ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Text("Welcome to\nDelhi Metro", style: pageTitleStyle),
                    
                    ),
                    ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: _buildBottomCard()
              ),
            ],),
        ),

        /* Bottom navigation bar */
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomePage(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.train,
                          color: currentTab == 0 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Book Ticket',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomePage(); // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.chat,
                          color: currentTab == 1 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Support',
                          style: TextStyle(
                            color: currentTab == 1 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            HomePage(); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.history,
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'History',
                          style: TextStyle(
                            color: currentTab == 2 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            HomePage(); // if user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.settings,
                          color: currentTab == 3 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(
                            color: currentTab == 3 ? Colors.blue : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),

      ),
    );
  }


  /*Bottom floating card where starting and end station has to be entered*/
  
  Widget _buildBottomCard(){
    return Container(
                child: 
                Wrap(
                  children: <Widget>[
                    _buildStationCard(),

                    Container(
                      height: 50.0,
                      margin: EdgeInsets.only(top:20.0,bottom:40),
                      width: MediaQuery.of(context).size.width*0.8,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        onPressed: (){
                          (startStationText != "Select start station..." && endStationText != "Select end station...")
                                ? pushtoPage() : _scaffoldKey.currentState
                                .showSnackBar(SnackBar(
                                  content: Text("Select Starting and Ending Stations"),
                                  duration: Duration(milliseconds: 2000)
                                  ));
                        },
                        child: Text("Search",style: selectedTimeText,),
                        color: (startStationText != "Select start station..." && endStationText != "Select end station...")
                                ? Color(0xFFE84B1B)
                                : Colors.grey[600],
                        ),
                    ),


                  ],
                )
              );
  }

  Widget _buildStationCard(){
    return Container(
      width: MediaQuery.of(context).size.width*0.8,
      height: 200.0,
      decoration: BoxDecoration(
                  color:  Color(0xFF283992),
                  
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15), 
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15), 
                    bottomRight: Radius.circular(15),
                  ),
                  boxShadow: [
                    new BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10.0,
                      ),
                  ]
                ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Text("From",style: blogDateStyle,),

          Container(
            height: 40.0,
            width: MediaQuery.of(context).size.width*0.6,
            margin: EdgeInsets.only(top:10.0,bottom: 10.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              elevation: 8.0,
              color: Color(0xFFFFFFFF),
              padding: EdgeInsets.all(8.0),
              child: Text(startStationText,style: stationText,),
              onPressed: () async{

                String result = await Navigator.push(context, MaterialPageRoute(builder: (context) => StartStationPage()));
                setState(() {
                  (result == null) ? startStationText =  "Select start station..." : startStationText = result;
                });

            }),
          ),

          Text("To",style: blogDateStyle,),

          Container(
            height:40.0,
            width: MediaQuery.of(context).size.width*0.6,
            margin: EdgeInsets.only(top:10.0,bottom: 10.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              elevation: 8.0,
              color: Color(0xFFFFFFFF),
              padding: EdgeInsets.all(8.0),
              child: Text(endStationText,style: stationText,),
              onPressed: () async{

                String result = await Navigator.push(context, MaterialPageRoute(builder: (context) => StartStationPage()));
                setState(() {
                  (result == null) ? endStationText =  "Select end station..." : endStationText = result;
                });
                
            }),
          ),


        ],
      ),
    );
  }
  
  void pushtoPage(){
    Navigator.push(context, 
      MaterialPageRoute(
        builder: (_) => ConfirmationPage(
          start: startStationText,
          end: endStationText,
          )));
  }

}