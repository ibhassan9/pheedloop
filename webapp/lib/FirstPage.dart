import 'package:flutter/material.dart';
import 'package:webapp/MainPage.dart';
import 'package:webapp/Models/User.dart';
import 'package:webapp/Services/UserService.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {


  TextEditingController nameController = new TextEditingController();


  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  Widget body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue, Colors.purple])
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('PheedLoop Chat Room', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 40.0),),
          SizedBox(height: 20.0),
          nameContainer(),
          SizedBox(height: 40.0),
          btnContinue()
        ],
      ),
    );
  }

  Widget nameContainer() {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(5.0)),
      child: TextField(
        controller: nameController,
        onSubmitted: (value) {
          callContinue();
        },
        maxLines: 1,
        decoration: new InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          hintText: "Enter your name here",
        ),
      ),
    );
  }

  Widget btnContinue() {
    return InkWell(
      onTap: () {
        callContinue();
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 5,
        height: 60,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
        child: Center(child: Text('Continue', style: TextStyle(fontWeight: FontWeight.w500),)),
      ),
    );
  }


  void callContinue() {

    if (nameController.text.trim().isEmpty) {
      // call back with 'name needed error'
      return;
    }

    User user = User(id: UserService.getUniqueId(), name: nameController.text.trim());

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(user: user)));
  }
}