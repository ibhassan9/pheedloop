//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:webapp/Models/Message.dart';
import 'package:webapp/Models/Room.dart';
import 'package:webapp/Models/User.dart';
import 'package:webapp/Widgets/ChatBox.dart';
import 'package:webapp/Widgets/ConvoList.dart';
import 'package:webapp/Widgets/MessageWidget.dart';

class MainPage extends StatefulWidget {

  final User user;

  MainPage({this.user});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget convoList;
  String title;

  Room selectedRoom;

  Widget build(BuildContext context) {
    convoList = Expanded(
      child: Container(
        color: Colors.blueGrey.shade50,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Text(
                'Now chatting in: ${selectedRoom.name}',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Connected as: ${widget.user.name} ID: (${widget.user.id})',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 10.0),
              Expanded(child: ConvoList(room: selectedRoom, user: widget.user,)),
            ],
          ),
        ),
      ),
    );



    return Scaffold(
      body: renderBody(),
    );
  }

  Widget makeRoomList() {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Chat Rooms',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Expanded(
              child: ListView(
                children: renderDummyRooms(),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> renderDummyRooms() {
    List<Widget> dummies = [];
    for (var i = 0; i < 12; i++) {
      Room room = Room(id: 'Room' + i.toString(), name: 'Room' + i.toString());
      dummies.add(roomWidget(room));
    }

    return dummies;
  }

  Widget roomWidget(Room room) {
    return Container(
      color: selectedRoom == room ? Colors.blueGrey.shade50 : Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: InkWell(
          onTap: () {
            this.setState(() {
              selectedRoom = room;
            });
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 20.0,
              ),
              SizedBox(width: 5.0),
              Text(room.name)
            ],
          ),
        ),
      ),
    );
  }

  Widget renderBody() {
    return Row(
      children: [makeRoomList(), convoList],
    );
  }

  @override
  void initState() {
    super.initState();
    selectedRoom = Room(id: 'Room0', name: 'Room0');
  }
}
