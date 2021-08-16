import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  static const NAME = "name";
  static const CONTENT = "content";
  static const ROOM_ID = "roomID";
  static const TIMESTAMP = "timestamp";
  static const SENDER_ID = "senderID";

  String name;
  String content;
  String roomID;
  int timestamp;
  String senderID;

  Message({this.name, this.content, this.roomID, this.timestamp, this.senderID});

  Message.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot.get(NAME);
    content = snapshot.get(CONTENT);
    roomID = snapshot.get(ROOM_ID);
    timestamp = snapshot.get(TIMESTAMP);
    senderID = snapshot.get(SENDER_ID);
  }
}
