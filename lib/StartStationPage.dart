import 'package:delhimetro/content.dart';
import 'package:delhimetro/global.dart';
import 'package:flutter/material.dart';

class StartStationPage extends StatefulWidget {
  StartStationPage({Key key}) : super(key: key);

  @override
  _StartStationPageState createState() => _StartStationPageState();
}

class _StartStationPageState extends State<StartStationPage> {

  List<String> sortedList = Content().listAllStations;
  
  @override
  Widget build(BuildContext context) {

    sortedList.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
      });

    return SafeArea(
      
      child:Scaffold(
        appBar: AppBar(
          title: Text("Select Starting Station"),
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(20.0),
          shrinkWrap: false,
          itemCount: sortedList.length,
          itemBuilder: (context,index){

            return _buildListItems(sortedList[index]);

          }),

      ),
    );
  }
  Widget _buildListItems(String stationName){
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width*0.6,
      margin: EdgeInsets.only(top:5.0,bottom: 5.0),
      child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            elevation: 5.0,
            color: Colors.white,
            padding: EdgeInsets.all(8.0),
            child: Text(stationName,style: stationText,),
            onPressed: (){
              Navigator.pop(context,stationName??null);
          }),
    );
  }
}