import 'package:flutter/material.dart';
import 'package:webapp/Models/User.dart';
import 'package:webapp/Services/MessageApi.dart';
import 'package:webapp/Models/Message.dart';

class ChatBox extends StatelessWidget {
  final String roomId;
  final User user;
  ChatBox({this.roomId, this.user});

  final TextEditingController chatController = TextEditingController();
  Widget build(BuildContext context) {
    return Padding(
      padding:
          MediaQuery.of(context).viewInsets,
      child: Expanded(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Container(
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                          child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(30.0)),
                        child: TextField(
                          onSubmitted: (value) async => callMsgSend(),
                          textInputAction: TextInputAction.unspecified,
                          maxLines: 1,
                          controller: chatController,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "Insert message here",
                          ),
                        ),
                      )),
                      IconButton(
                        icon: Icon(
                          Icons.message,
                          color: Colors.black,
                        ),
                        onPressed: () async => callMsgSend(),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  callMsgSend() async {
    // check if chat message is empty
    if (chatController.text.trim().isEmpty) {
      return;
    }
    Message msg =
        Message(content: chatController.text, name: user.name, roomID: roomId, senderID: user.id);
    // push object to cloud
    await MessageApi.sendMessage(msg: msg);
    // clear chat
    chatController.clear();
  }
}
