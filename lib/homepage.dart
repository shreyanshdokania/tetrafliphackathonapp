import 'package:flutter/material.dart';
import 'package:turtle/help.dart';
import 'general.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.only(top: 10),
        child: Scaffold(
          appBar: AppBar(
            title: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "                  Turtle",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Spacer(),
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
                        "Create",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.black,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  // isScrollable: true,
                  indicatorColor: Colors.green[500],
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 2.5,

                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        "GENERAL",
                        style: TextStyle(
                          fontFamily: 'SpotifyFont',
                          fontSize: 15.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "HELP",
                        style: TextStyle(
                          fontFamily: 'SpotifyFont',
                          fontSize: 15.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                child: General(),
                // child: Playlist(),
              ),
              Container(
                // color: Colors.grey,
                child: CommHelp(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
