import 'package:flutter/material.dart';
import 'package:mobileapp/Models/Comment.dart';

class CommentWidget extends StatefulWidget {
  final Comment comment;
  final int indentIndex;

  CommentWidget({this.comment, this.indentIndex});

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  Widget build(BuildContext context) {
    return Container(
        child: widget.indentIndex == 0
            ? Text('${widget.comment.text} ${widget.comment.date}')
            : IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: indentWidget(),
                    ),
                    Flexible(
                        child: Text(
                            '${widget.comment.text} ${widget.comment.date}'))
                  ],
                ),
              ));
  }

  List<Widget> indentWidget() {
    List<Widget> widgets = [];
    for (var i = 0; i < widget.indentIndex; i++) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child: Container(width: 1.0, color: Colors.grey),
      ));
    }

    return widgets;
  }
}
