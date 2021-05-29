import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

List<String> commands = [
  'refresh.mp3',
  'post.mp3',
  'sendmail.mp3',
  'credits.mp3',
];

List<String> comms = [
  "Refresh",
  "Post",
  "Send Mail",
  "Credits",
];

class CommHelp extends StatefulWidget {
  @override
  _CommHelpState createState() => _CommHelpState();
}

class _CommHelpState extends State<CommHelp> {
  bool playing = false;
  IconData playbtn = Icons.play_arrow_outlined;
  AudioPlayer _player;
  AudioCache cache;

  Duration position = new Duration();
  Duration musiclength = new Duration();

  Widget slider() {
    return Container(
      width: 300.0,
      child: Slider.adaptive(
          activeColor: Colors.white,
          inactiveColor: Colors.blueGrey[800],
          value: position.inSeconds.toDouble(),
          max: musiclength.inSeconds.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player.durationHandler = (d) {
      setState(() {
        musiclength = d;
      });
    };

    _player.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          for (int i = 0; i < commands.length; i++)
            FlatButton(
              onPressed: () {
                if (!playing) {
                  print("sd");
                  cache.play(commands[i]);

                  setState(() {
                    playing = true;
                  });
                  setState(() {
                    playing = false;
                  });
                } else {
                  print("dsd");
                  _player.pause();
                  setState(() {
                    playing = false;
                  });
                }
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
                    child: Icon(
                      Icons.play_arrow_outlined,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    // postdet[i]["requirement"],
                    comms[i],
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.pause_circle_outline,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
