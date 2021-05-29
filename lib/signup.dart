import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'login.dart';

final dbref2 = FirebaseDatabase.instance.reference().child("signup");

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController t1 = new TextEditingController();
  final TextEditingController t2 = new TextEditingController();
  final TextEditingController t3 = new TextEditingController();

  void checks() {
    dbref2.once().then((DataSnapshot printtt) {
      Map<dynamic, dynamic> values = printtt.value;
      values.forEach((key, values) {
        setState(() {
          checking.add(values);
          // print(pnames);
        });
      });
    });
    print(checking);
  }

  String fetchcheck(String str) {
    // check = "";
    for (int i = 0; i < checking.length; i++) {
      if (checking[i]["username"] == str) {
        check = checking[i]["password"].toString();
        print(check + "--" + str + "--" + checking[i]["password"]);
      }
    }
    return check;
  }

  void fetchdata() {
    dbref2.once().then((DataSnapshot printtt) {
      Map<dynamic, dynamic> values = printtt.value;
      values.forEach((key, values) {
        setState(() {
          ldata1.add(values["username"]);
          // print(pnames);
        });
      });
    });
    setState(() {
      ldata2 = ldata1.toSet().toList();
    });
    print(ldata2);
  }

  String uname, email, pass;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      // resizeToAvoidBottomPadding: false,
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 130.0, 0.0, 0.0),
                      child: Text(
                        'Signup',
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'USERNAME',
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
                      controller: t1,
                      onChanged: (String str) {
                        setState(() {
                          uname = str;
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'EMAIL',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                      controller: t2,
                      onChanged: (String str) {
                        setState(() {
                          email = str;
                        });
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                      controller: t3,
                      obscureText: true,
                      onChanged: (String str) {
                        setState(() {
                          pass = str;
                        });
                      },
                    ),
                    SizedBox(height: 50.0),
                    Container(
                      height: 50.0,
                      child: GestureDetector(
                        onTap: () {
                          dbref2.push().set({
                            "username": uname,
                            "email": email,
                            "password": pass,
                          });
                          checks();
                          fetchcheck(uname);
                          fetchdata();
                        },
                        child: Container(
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
                                  "SINGUP",
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
        ],
      ),
    );
  }
}
