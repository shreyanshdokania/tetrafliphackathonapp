import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:turtle/login.dart';
import 'package:toast/toast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'signup.dart';

final dbref3 = FirebaseDatabase.instance.reference().child("posts");

List<dynamic> postdet = [];
List<String> lis1 = [];
List<String> lis2 = [];
List<String> list1 = [];
List<String> list2 = [];
List<String> l1 = [];
List<String> l2 = [];

List<dynamic> checking2 = [];
String check2;
String sender;

class General extends StatefulWidget {
  @override
  _GeneralState createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  @override
  void initState() {
    super.initState();
    fetch1();
    checks();
  }

  void fetch1() {
    // postdet.clear();
    dbref3.once().then((DataSnapshot printtt) {
      Map<dynamic, dynamic> values = printtt.value;
      values.forEach((key, values) {
        setState(() {
          postdet.add(values);
          lis1.add(values["requirement"]);
          list1.add(values["shortnote"]);
          l1.add(values["username"]);
        });
      });
    });
    setState(() {
      lis2 = lis1.toSet().toList();
      list2 = list1.toSet().toList();
      l2 = l1.toSet().toList();
    });
  }

  void checks() {
    dbref2.once().then((DataSnapshot printtt) {
      Map<dynamic, dynamic> values = printtt.value;
      values.forEach((key, values) {
        setState(() {
          checking2.add(values);
          // print(pnames);
        });
      });
    });
  }

  String fetchcheck(String str) {
    // check = "";
    for (int i = 0; i < checking2.length; i++) {
      if (checking2[i]["username"] == str) {
        check2 = checking2[i]["email"].toString();
      }
    }
    print(check2);
    return check2;
  }

  String fetchcheck2(String stri) {
    // check = "";
    for (int i = 0; i < checking2.length; i++) {
      if (checking2[i]["username"] == stri) {
        sender = checking2[i]["email"].toString();
      }
    }
    print("$sender");
    return sender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: RaisedButton(
                      color: Colors.transparent,
                      child: Text(
                        "Post",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildPopupDialog(context),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: RaisedButton(
                    color: Colors.transparent,
                    child: Text(
                      "Refresh",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      fetch1();
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            for (int i = 0; i < lis2.length; i++)
              FlatButton(
                onPressed: () {
                  checks();
                  fetchcheck(l2[i]);
                  fetchcheck2(username);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => MyHomePage(title: "okay")),
                  // );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildPopupDialog2(context),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  color: Colors.grey[800],
                  elevation: 8.0,
                  margin: new EdgeInsets.symmetric(
                    horizontal: 0.0,
                    vertical: 10.0,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 5.0,
                    ),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            width: 1.0,
                            color: Colors.white24,
                          ),
                        ),
                      ),
                      child:
                          Icon(Icons.play_circle_outline, color: Colors.white),
                    ),
                    title: Text(
                      // postdet[i]["requirement"],
                      lis2[i],
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          // postdet[i]["shortnote"],
                          list2[i],
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  final TextEditingController txt1 = new TextEditingController();
  final TextEditingController txt2 = new TextEditingController();

  String str1, str2;

  void fetch1() {
    // postdet.clear();
    dbref3.once().then((DataSnapshot printtt) {
      Map<dynamic, dynamic> values = printtt.value;
      values.forEach((key, values) {
        postdet.add(values);
        lis1.add(values["requirement"]);
        list1.add(values["shortnote"]);
      });
    });
    lis2 = lis1.toSet().toList();
    list2 = list1.toSet().toList();
    print(lis2);
    print(list2);
  }

  return AlertDialog(
    backgroundColor: Colors.black,
    title: Center(
      child: Text(
        'Details',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
          child: Column(
            children: <Widget>[
              TextField(
                style: TextStyle(color: Colors.white),

                decoration: InputDecoration(
                  labelText: 'Requirement Of',
                  labelStyle: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                  // hintText: 'EMAIL',
                  // hintStyle: ,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                // controller: t1,
                onChanged: (String str) {
                  str1 = str;
                },
              ),
              SizedBox(height: 10.0),
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Small Desciption',
                  labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                // controller: t2,
                onChanged: (String str) {
                  str2 = str;
                },
              ),
              SizedBox(height: 30.0),
              Container(
                height: 50.0,
                child: GestureDetector(
                  onTap: () {
                    dbref3.push().set({
                      "requirement": str1,
                      "shortnote": str2,
                      "username": username,
                    });
                    fetch1();
                    lis2.add(str1);
                    list2.add(str2);
                    print(lis2);
                    print(list2);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Text(
                            "POST",
                            style: TextStyle(
                              color: Colors.green,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPopupDialog2(BuildContext context) {
  sendMail() async {
    String username = 'shreyanshvitchn@gmail.com';
    String password = 'Q2g-5M4k8HGye!K';

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username)
      ..recipients.add('$check2')
//      ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
//      ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'U have got some help :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Contact at this email address : </h1>\n<p>$sender</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      Toast.show("You have clicked the Button! and email sent", context,
          duration: 3, gravity: Toast.CENTER);
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  return AlertDialog(
    backgroundColor: Colors.black,
    title: Center(
      child: Text(
        'CLICK TO SEND MAIL',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 50.0,
                child: GestureDetector(
                  onTap: () {
                    sendMail();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Text(
                            "SEND",
                            style: TextStyle(
                              color: Colors.green,
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ],
    ),
  );
}
