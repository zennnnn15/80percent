import 'package:capstone_focus/screens/menu/mainmenu.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone_focus/games/spot_the_difference/levels/level_1_ball_theme/1_screen.dart';
import 'package:capstone_focus/games/spot_the_difference/levels/level_2_cars_theme/level2_1_screen.dart';
import 'package:capstone_focus/games/spot_the_difference/levels/level_3_cats_theme/level3_1_screen.dart';
import 'package:capstone_focus/games/spot_the_difference/levels/level_4_clothes_theme/level4_1_screen.dart';
import 'package:capstone_focus/games/spot_the_difference/levels/level_5_cups_theme/level5_1_screen.dart';
import 'package:capstone_focus/games/spot_the_difference/levels/level_6_dishes_theme/level6_1_screen.dart';
import 'package:capstone_focus/games/spot_the_difference/levels/level_7_dogs_theme/level7_1_screen.dart';
import 'package:capstone_focus/games/spot_the_difference/levels/level_8_house_theme/level8_1_screen.dart';
import 'package:capstone_focus/games/spot_the_difference/levels/level_9_shoes_theme/level9_1_screen.dart';
import 'package:capstone_focus/games/spot_the_difference/levels/level_10_trees_theme/level10_1_screen.dart';

class SpotTheDiffLevelSelect extends StatefulWidget {
  @override
  _SpotTheDiffLevelSelectState createState() => _SpotTheDiffLevelSelectState();
}

class _SpotTheDiffLevelSelectState extends State<SpotTheDiffLevelSelect> {
  late User? _user;
  bool _isLoading = true;
  List<bool> _levelUnlocked = List.filled(10, false);

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      setState(() {
        _user = user;
      });

      await _checkLevelStatus();
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _checkLevelStatus() async {
    final userLevels =
    FirebaseFirestore.instance.collection('user_levels').doc(_user!.uid);
    final levelData = await userLevels.get();

    if (levelData.exists) {
      final levelStatus = levelData.data() as Map<String, dynamic>;
      for (int i = 1; i <= 10; i++) {
        _levelUnlocked[i - 1] = levelStatus['level_$i'] ?? false;
      }
    } else {
      // Initialize level 1 as unlocked if the document doesn't exist
      _levelUnlocked[0] = true;
      await userLevels.set({'level_1': true});
    }
  }

  Future<void> _unlockNextLevel(int level) async {
    if (level < 10 && _levelUnlocked[level - 1]) {
      // Check if the next level is locked and the current level is unlocked
      if (!_levelUnlocked[level]) {
        // Unlock the next level
        _levelUnlocked[level] = true;
        await FirebaseFirestore.instance
            .collection('user_levels')
            .doc(_user!.uid)
            .update({'level_$level': true});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MenuScreen(userUID: _user!.uid )));
        }, icon: Icon(Icons.arrow_back)),
        automaticallyImplyLeading: false,
        title: Column(
          children: [

            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: Image.asset('assets/gamelogos/game6.png'),
                ),
                Text(
                  "Spot The Difference",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ],
        ),
        backgroundColor: Colors.teal,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 1; i < 11; i++)
                GestureDetector(
                  onTap: () async {
                    if (i == 1 || _levelUnlocked[i - 2]) {
                      if (i == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GameScreen1(),
                          ),
                        );
                      } else if (i == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => level2_1_screen(),
                          ),
                        );
                      } else if (i == 3) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => level3_1_screen(),
                          ),
                        );
                      } else if (i == 4) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => level4_1_screen(),
                          ),
                        );
                      } else if (i == 5) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => level5_1_screen(),
                          ),
                        );
                      } else if (i == 6) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => level6_1_screen(),
                          ),
                        );
                      } else if (i == 7) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => level7_1_screen(),
                          ),
                        );
                      } else if (i == 8) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => level8_1_screen(),
                          ),
                        );
                      } else if (i == 9) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => level9_1_screen(),
                          ),
                        );
                      } else if (i == 10) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => level10_1_screen(),
                          ),
                        );
                      }
                      await _unlockNextLevel(i);
                    }
                  },
                  child: Column(
                    children: [
                      if (i > 0)
                        Container(
                          width: 5,
                          height: 30,
                          color: i < 10
                              ? Colors.green
                              : Colors.blue, // Jungle and Sea themes
                        ),
                      Container(
                        width: 80,
                        height: 80,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.green],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (i > 10)
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 36,
                                ),
                              SizedBox(height: 5),
                              Text(
                                i.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
