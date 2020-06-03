/*

This page is responsible to show the booked ticket with starting, itermediate and end stations.

*/ 

import 'package:delhimetro/content.dart';
import 'package:delhimetro/model.dart';
import 'package:flutter/material.dart';

class TicketConfirmed extends StatefulWidget {

  final TicketDetails ticket;

  TicketConfirmed({Key key, this.ticket}) : super(key: key);

  @override
  _TicketConfirmedState createState() => _TicketConfirmedState();
}

class _TicketConfirmedState extends State<TicketConfirmed> {

  

  @override
  Widget build(BuildContext context) {

    bool inter1exists = widget.ticket.intermediate1!=null;
    bool inter2exists = widget.ticket.intermediate2!=null;
    
    String inter1;
    String inter2;
    Map trains = Content().mapAllStations;
    
    inter1exists ? trains.forEach((key, value) {
      if(value is List){
        if(value[0] == widget.ticket.intermediate1 || value[1] == widget.ticket.intermediate1 ){
          inter1 = key;
        }
      }else if(value == widget.ticket.intermediate1){
        inter1 = key;
      }
     })
     : inter1 = "N/A";
    
    inter2exists ? trains.forEach((key, value) {
      if(value is List){
        if(value[0] == widget.ticket.intermediate2 || value[1] == widget.ticket.intermediate2 ){
          inter2 = key;
        }
      }else if(value == widget.ticket.intermediate2){
        inter2 = key;
      }
     })
     : inter2 = "N/A";
     
    return Scaffold(
      body: Card(
        elevation: 20,
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(50),
        ),
        margin: EdgeInsets.fromLTRB(50, 125, 50, 125),
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text(
                  'Your Booked Ticket',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, color: Colors.white),
                ),
              ),
              Icon(
                Icons.verified_user,
                color: Colors.white,
                size: 30.0,
              ),
              SizedBox(
                height: 30,
              ),

              /*Start Station*/
              ListTile(
                title: Text(
                  widget.ticket.start,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
              
              Icon(
                Icons.arrow_downward,
                color: Colors.white,
                size: 30.0,
              ),
              
               inter1exists ? _buildTrainStation(inter1.toString()) 
               
               : _buildTrainStation(widget.ticket.end),
               inter1exists ? _buildIcon() : Container(),

               inter2exists  ? _buildTrainStation(inter2.toString()) : inter1exists ? _buildTrainStation(widget.ticket.end) : Container(),
               inter2exists ? _buildIcon() : Container(),

              (inter1exists == true && inter2exists == true) ? _buildTrainStation(widget.ticket.end):Container(),
              


              ListTile(
                title: Text(
                  'Slot alloted: ${widget.ticket.time}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrainStation(String station){
    return ListTile(
                title: Text(
                  station ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              );
  }

  Widget _buildIcon(){
    return Icon(
                Icons.arrow_downward,
                color: Colors.white,
                size: 30.0,
              );
  }
}