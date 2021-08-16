import 'package:http/http.dart' as http;
import 'package:mobileapp/Models/Comment.dart';

class Api {
  static String endPoint =
      'https://df0ksgnmih.execute-api.ca-central-1.amazonaws.com/';

  static Future<List<Comment>> retreiveComments() async {
    var response = await http.get(Uri.parse(endPoint));
    List<Comment> comments = commentFromJson(response.body);
    // sort comments by date
    comments.sort((a, b) => (date(a.date)).compareTo(date(b.date)));
    // Generate a tree structure
    var treeComments = await buildStructure(comments);
    // Remove the replies
    treeComments = removeReplies(treeComments);
    // Change tree to list
    var commentArray = getListFromTree(treeComments, comments);
    return commentArray;
  }

  // convert to accepted format & return parsed date
  static DateTime date(String d) {
    d = d.replaceAll('/', '');
    return DateTime.parse(d);
  }

  static List<Comment> getListFromTree(
      List<Comment> newComments, List<Comment> commentArray) {
    if (commentArray.isEmpty) {
      commentArray = [];
    }

    for (var i = 0; i < newComments.length; i++) {
      var comment = newComments[i];
      commentArray.add(comment);
      if (comment.children.length != 0) {
        getListFromTree(comment.children, commentArray);
      }
    }

    return commentArray;
  }

  static List<Comment> removeReplies(List<Comment> comments) {
    List<Comment> newComments = [];

    for (var i = 0; i < comments.length; i++) {
      var comment = comments[i];
      if (comment.parentId == null) {
        newComments.add(comment);
      }
    }
    // returns list of replies to be removed from current structure
    return newComments;
  }

  static Future<List<Comment>> buildStructure(List<Comment> comments,
      {String parentId}) async {
    List<Comment> result = [];

    for (var i = 0; i < comments.length; i++) {
      var comment = comments[i];
      // check if parentId of comment is equivalent to parentId
      if (comment.parentId == parentId) {
        // recurse to get children of children....of children
        comment.children = await buildStructure(comments, parentId: comment.id);
        result.add(comment);
      }
    }

    // check if this is a subcomment
    if (parentId != null) {
      // sort by date
      result.sort((a, b) => (date(a.date)).compareTo(date(b.date)));
    }

    return result;
  }
}
