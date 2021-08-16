import 'package:flutter/material.dart';
import 'package:mobileapp/Widgets/CommentWidget.dart';
import 'package:mobileapp/Models/Comment.dart';
import 'package:mobileapp/Services/api.dart';

class CommentsPage extends StatefulWidget {
  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage>
    with AutomaticKeepAliveClientMixin {
  List<Comment> retreivedComments;

  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        brightness: Brightness.dark,
        title: Text(
          'PheedLoop Comments',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            // retrieve new comment array and set state
            Api.retreiveComments().then((value) {
              setState(() {
                retreivedComments = value;
              });
            });
          },
          child: buildCommentList()),
    );
  }

  Widget buildCommentList() {
    return renderList(retreivedComments);
  }

  Widget renderList(List<Comment> comments) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: comments == null ? 0 : comments.length,
          itemBuilder: (context, index) {
            // get comment using index
            var comment = comments[index];
            // get comment replies
            List<Comment> replies = comments[index].children;
            var returnedReplies = renderReplies(replies, indent: 0);
            return returnedReplies.isEmpty
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // root comment
                        CommentWidget(
                          comment: comment,
                          indentIndex: 0,
                        ),

                        // replies
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                returnedReplies //render replies based on comment and indentation
                            )
                      ],
                    ),
                  );
          }),
    );
  }

  List<Widget> renderReplies(List<Comment> replies, {int indent}) {
    List<Widget> replyWidgets = [];
    // for each reply under the top comment
    // check if replies are null
    if (replies != null) {
      replies.forEach((element) {
        // check if element is null
        if (element != null) {
          // add comment widget
          replyWidgets.add(
            CommentWidget(
              comment: element,
              indentIndex: indent,
            ),
          );
          // run recursive to add reply widgets
          replyWidgets
              .addAll(renderReplies(element.children, indent: indent + 1));
        }
      });
    }

    // return widgets
    return replyWidgets;
  }

  @override
  void initState() {
    super.initState();
    Api.retreiveComments().then((value) {
      setState(() {
        retreivedComments = value;
      });
    });
  }

  @override
  bool get wantKeepAlive => true;
}
