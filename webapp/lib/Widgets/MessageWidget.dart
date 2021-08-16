import 'package:flutter/material.dart';
import 'package:webapp/Models/Message.dart';

class MessageWidget extends StatefulWidget {
  final Message message;
  final bool isLastMessage;
  final Function scroll;

  MessageWidget({this.message, this.isLastMessage, this.scroll});

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                this.widget.message.name,
                style: nameStyle,
              ),
              Text(
                this.widget.message.content,
                style: messageStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // if object is the last one on the list, scroll listview to show object
    if (widget.isLastMessage) { widget.scroll(); }
  }
}

TextStyle messageStyle = TextStyle(fontSize: 14, color: Colors.white);
TextStyle nameStyle = TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold);
