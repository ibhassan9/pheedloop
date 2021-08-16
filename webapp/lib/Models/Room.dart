import 'package:firebase/firestore.dart';

class Room {
  static const ID = "id";
  static const NAME = "name";

  String name;
  String id;

  Room({this.id, this.name});

  Room.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.get(ID);
    name = snapshot.get(NAME);
  }
}
