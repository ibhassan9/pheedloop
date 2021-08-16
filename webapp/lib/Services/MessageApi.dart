import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webapp/Models/Message.dart';

class MessageApi {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static sendMessage({Message msg}) {
    // initialize data
    Map<String, dynamic> data = {
      Message.NAME: msg.name,
      Message.CONTENT: msg.content,
      Message.ROOM_ID: msg.roomID,
      Message.TIMESTAMP: DateTime.now().millisecondsSinceEpoch,
      Message.SENDER_ID: msg.senderID
    };
    // upload data to the cloud
    firestore.collection(msg.roomID).doc().set(data).catchError((err) {
      print(err);
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> retreiveMessages({String roomID}) {
    // stream to retreive messages in realtime
     return firestore
        .collection(roomID)
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
