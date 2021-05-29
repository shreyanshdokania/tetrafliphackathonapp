import 'package:flutter/material.dart';
import 'signup.dart';
import 'homepage.dart';
import 'general.dart';
import 'package:firebase_database/firebase_database.dart';

final dbref1 = FirebaseDatabase.instance.reference().child("login");

List<String> ldata1 = [];
List<String> ldata2 = [];
String check;
List<dynamic> checking = [];
String username;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController text1 = new TextEditingController();
  final TextEditingController text2 = new TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchdata();
    checks();
    fetch1();
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
  }

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

  String fetchcheck(String str) {
    // check = "";
    for (int i = 0; i < checking.length; i++) {
      if (checking[i]["username"] == str) {
        check = checking[i]["password"].toString();
      }
    }
    return check;
  }

  String luname, lpass;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                      child: Text(
                        'Login',
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
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                      ),
                      controller: text1,
                      onChanged: (String str) {
                        setState(() {
                          luname = str;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'PASSWORD',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                          ),
                        ),
                      ),
                      controller: text2,
                      obscureText: true,
                      onChanged: (String str) {
                        setState(() {
                          lpass = str;
                        });
                      },
                    ),
                    SizedBox(height: 45.0),
                    Container(
                      height: 50.0,
                      child: GestureDetector(
                        onTap: () {
                          fetchdata();
                          checks();
                          for (int i = 0; i < ldata2.length; i++) {
                            if (ldata2[i] == luname) {
                              fetchcheck(luname);
                              if (check == lpass) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                );
                                dbref1.push().set({
                                  "username": luname,
                                  "password": lpass,
                                });
                                username = luname;
                              }
                            } else {
                              // print("false");
                            }
                          }
                          fetch1();
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
                                  "LOGIN",
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
                    SizedBox(height: 20),
                    Container(
                      height: 50.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupPage()),
                          );
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
