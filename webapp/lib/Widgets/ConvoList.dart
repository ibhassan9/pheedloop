import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:webapp/Models/User.dart';
import 'package:webapp/Services/MessageApi.dart';
import 'package:webapp/Models/Message.dart';
import 'package:webapp/Models/Room.dart';
import 'package:webapp/Widgets/ChatBox.dart';
import 'package:webapp/Widgets/MessageWidget.dart';

class ConvoList extends StatefulWidget {
  final Room room;
  final User user;

  ConvoList({this.room, this.user});

  @override
  _ConvoListState createState() => _ConvoListState();
}

class _ConvoListState extends State<ConvoList> {
  ScrollController _scrollController = new ScrollController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      bottomNavigationBar: ChatBox(
        roomId: widget.room.id,
        user: widget.user,
      ),
      body: StreamBuilder(
        stream: MessageApi.retreiveMessages(roomID: widget.room.id),
        builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
          // check if snapshot has error/data
          if (snap.hasData && !snap.hasError && snap.data.docs != null) {
            Map data = snap.data.docs.asMap();
            // initialize messages list
            List<Message> messages = [];
            // loop through data keys
            for (var key in data.keys) {
              // initialize msg object
              Message msg = Message.fromSnapshot(data[key]);
              // push object to messages array
              messages.add(msg);
            }
            return ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              reverse: false,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                Message msg = messages[index];
                // scroll chat (listview) function
                Function scroll = () {
                  Timer(
                      Duration(milliseconds: 300),
                      () => _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn));
                };
                return Align(
                  alignment: widget.user.id == msg.senderID
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: MessageWidget(
                    message: msg,
                    isLastMessage: index ==
                        messages.length -
                            1, // checking if last message posted in order to scroll listview to latest
                    scroll: scroll,
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
}
