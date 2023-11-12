import 'package:capstone_focus/games/GiantDwarf/dwarforginat.dart';
import 'package:capstone_focus/games/GiantDwarf/levelselect.dart';
import 'package:capstone_focus/games/find10/find10level.dart';
import 'package:capstone_focus/games/spot_the_difference/levelSeleectstd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Find10Welcome extends StatelessWidget {
  const Find10Welcome({Key? key}) : super(key: key);

  void _showInstructions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Find 10!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  'Instructions:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Pick  two balls which will make 10 in total.',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20,),
                Text(
                  'Remember that you need to choose two balls to reach 10. The location of the balls you choose doesnt matter.',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Got It!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Find10LevelSelector()));
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: Image.asset('assets/mainbg.png'),
                    ),
                    Text(
                      "Focus Finder",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 32.0,
              ),
            ),
            actions: [

            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 200,
                      child: Image.asset('assets/gamelogos/game5.png'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Find 10',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    AnimatedDefaultTextStyle(
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent,
                      ),
                      duration: Duration(milliseconds: 500),
                      child: Text('Tap to Start'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _showInstructions(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'How to Play',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ClipPath(
                clipper: WaveClipperTwo(reverse: true),
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.green,
                        Colors.lightBlueAccent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
