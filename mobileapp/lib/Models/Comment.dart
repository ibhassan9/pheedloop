import 'dart:convert';

List<Comment> commentFromJson(String str) =>
    List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

class Comment {
  static const ID = "id";
  static const TEXT = "text";
  static const DATE = "date";
  static const PARENT_ID = "parentId";

  String id;
  String text;
  String date;
  String parentId;
  List<Comment> children;

  Comment({this.id, this.text, this.date, this.parentId, this.children});

  Map toJson() => {ID: id, TEXT: text, DATE: date, PARENT_ID: parentId};

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
      id: json[ID],
      text: json[TEXT],
      date: json[DATE],
      parentId: json[PARENT_ID]);
}
