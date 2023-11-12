import 'package:flutter/material.dart';

import 'game/caller.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData iconData; // Icon data for your button
  final Color color;
  final VoidCallback onPressed;

  CustomButton({
    required this.text,
    required this.iconData,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(2, 107, 31, 1),
            offset: Offset(0, 4),
            blurRadius: 0,
          ),
        ],
        color: color,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.width * 0.09,
                ),
                SizedBox(width: 8), // Adjust the spacing between icon and text
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Jomhuria',
                    fontSize: MediaQuery.of(context).size.width * 0.09,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class Frame11Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromRGBO(222, 251, 255, 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/tetris/tetbg.png'), // Replace 'assets/background_image.jpg' with your actual image path
                    fit: BoxFit.cover,
                  ),
                  color: Color.fromRGBO(52, 220, 78, 0.9), // Semi-transparent green
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Block',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Jomhuria',
                          fontSize: MediaQuery.of(context).size.width * 0.25,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                      Text(
                        'Tetris',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Jomhuria',
                          fontSize: MediaQuery.of(context).size.width * 0.25,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          color: Color.fromRGBO(255, 255, 255, 0.9), // Semi-transparent white
                        ),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              CustomButton(
                                text: 'Tutorial',
                                color: Color.fromRGBO(0, 169, 47, 1), // Green color
                                onPressed: () {
                                  _showInstructions(context);
                                }, iconData: Icons.bookmark_added_outlined,
                              ),

                              CustomButton(
                                text: 'Play',
                                color: Color.fromRGBO(226, 154, 46, 1), // Orange color
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TetApp()),
                                  );
                                },
                                iconData: Icons.play_arrow,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Other components as needed
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.55,
                height: MediaQuery.of(context).size.height * 0.05,
                child: InkWell(
                  onTap: () {
                 Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(2, 107, 31, 1),
                          offset: Offset(0, 4),
                          blurRadius: 0,
                        ),
                      ],
                      color: Color.fromRGBO(179, 54, 15, 0.9), // Semi-transparent red
                    ),
                    child: Center(
                      child: Text(
                        'Back',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontFamily: 'Jomhuria',
                          fontSize: MediaQuery.of(context).size.width * 0.09,
                          letterSpacing: 0,
                          fontWeight: FontWeight.normal,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              )

            ],
          ),
        ),
      ),
    );
  }
}



void _showInstructions(BuildContext context) {
  // Implement the logic to show the instructions here, e.g., a dialog or a new screen.
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
                'Welcome to Block Tetris!',
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
                'Arrange the falling blocks to create complete rows and clear them.',
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 13),
              Text(
                'How to Play:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 12),
              Text(
                '1. Swipe up to hold the current piece.',
                style: TextStyle(
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                '2. Swipe down for fast fall - drop the piece quickly.',
                style: TextStyle(
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                '3. Tap anywhere on the screen to rotate the piece.',
                style: TextStyle(
                  fontSize: 13,
                ),
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