import 'package:capstone_focus/games/spot_the_difference/levelSeleectstd.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../games/GiantDwarf/dwarforginat.dart';
import '../../games/GiantDwarf/dwarfwelcomescreen.dart';
import '../../games/Tetris/tetrisnewscreen.dart';
import '../../games/Tetris/tetriswelcome.dart';
import '../../games/find10/find10level.dart';
import '../../games/find10/newfind10welcome.dart';
import '../../games/portal_puzzle/home_page.dart';
import '../../games/portal_puzzle/main.dart';
import '../../games/spot_the_difference/level/game_levels_scrolling_map.dart';
import '../../games/spot_the_difference/level/map_vertical_example.dart';
import 'editprofile.dart';




//To do List WAG TAMADIN MAGASTOS KA TANDAAN MO

//REUI OF Select base on instructor reccomendation

//level select re ui

//





class MenuScreen extends StatefulWidget {
  final String userUID;




  const MenuScreen({Key? key, required this.userUID}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Future<void> _loadGameData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      print('User ID: $userId');
    } else {
      print('No user is currently logged in.');
    }
    await _initializeDefaultGameVisibility(user!.uid);
    await _initializeGameVisibility(user!.uid);
    setState(() {
      isDataLoaded = true;
    });
  }



  Future<void> _initializeDefaultGameVisibility(String userUID) async {
    final gamesCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userUID)
        .collection('games');
    gameVisibility.forEach((key, value) async {
      final doc = await gamesCollection.doc(key).get();
      if (!doc.exists) {
        print('Setting visibility for $key to $value in Firestore');
        gamesCollection.doc(key).set({'visibility': value});
      }
    });
  }

  Future<void> _initializeGameVisibility(String userUID) async {
    final gamesCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userUID)
        .collection('games');

    for (final gameKey in gameVisibility.keys) {
      final doc = await gamesCollection.doc(gameKey).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        final visibility = data['visibility'] as bool;
        setState(() {
          gameVisibility[gameKey] = visibility;
        });
      } else {
        //empty
      }
    }
  }


  Map<String, bool> gameVisibility = {
    'game1': true,
    'game2': true,
    'game3': true,
    'game4': true,
    'game5': true,
    'game6': true,
  };

  bool showAttentionGames = true; // Define these variables
  bool showMindGames = true;
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
 _loadGameData();
 //get data from firestore convert to map to check ig game visibilty is set to true/false
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userUID)
        .collection('games')
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data() as Map<String, dynamic>;
        print('Data from Firestore: $data');
        data.forEach((key, value) {
          if (gameVisibility.containsKey(key)) {
            setState(() {
              gameVisibility[key] = value as bool;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isDataLoaded) {
      return Scaffold(
        appBar: AppBar(
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
          automaticallyImplyLeading: false,
          backgroundColor: Colors.teal[800],
          elevation: 0,
        ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('users').doc(
              widget.userUID).snapshots(),

          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active &&
                snapshot.hasData) {
              var userData = snapshot.data!.data();
              var avatar = userData?['avatarSelected'];
              var username = userData?['username'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      color: Colors.teal[400],
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfileScreen(),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: AssetImage(avatar),
                                  ),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        'Welcome',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        username ?? 'Unknown',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: showGamesGrid(),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
    }
    else{
      return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Row(
                children: [

                  //fix
                  CircleAvatar(
                    radius: 20,
                    child: Container(
                      width: 50,
                      height: 50,
                      child: Image.asset('assets/mainbg.png'),
                    ),
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
          automaticallyImplyLeading: false,
          backgroundColor: Colors.teal[800],
          elevation: 0,
        ),
        body: Center(child: CircularProgressIndicator(),),
      );

    }
  }

  Widget showGamesGrid() {
    final filteredGames = gamesData.where((game) {
      if (!showAttentionGames && !showMindGames) {
        return true;
      }
      return (showAttentionGames && gameVisibility[game.key] == true) ||
          (showMindGames && gameVisibility[game.key] == true);
    }).toList();

    if (filteredGames.isEmpty) {
      return Center(
        child: Text(
          'No games to display',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: [
        for (final game in filteredGames)
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => game.screen),
              );
            },
            child: buildGameTile(game.imagePath),
          ),
      ],
    );
  }


  Widget buildGameTile(String imagePath) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.lightBlueAccent,
              Colors.lightGreenAccent,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class GameInfo {
  final String key;
  final String imagePath;
  final Widget screen;

  GameInfo({
    required this.key,
    required this.imagePath,
    required this.screen,
  });
}

final gamesData = [
  //DfG
  GameInfo(
    key: 'game1',
    imagePath: 'assets/gamelogos/game1.png',
    screen: MyApp(),
  ),
  GameInfo(
    key: 'game2',
    imagePath: 'assets/gamelogos/game2.png',
    screen: Frame11Widget(),
  ),
  GameInfo(
    key: 'game3',
    imagePath: 'assets/gamelogos/game3.png',
    screen: Frame11Widget(),
  ),
  GameInfo(
    key: 'game4',
    imagePath: 'assets/gamelogos/game4.png',
    screen: DwarfWelcomeScreen(),
  ),
  GameInfo(
    key: 'game5',
    imagePath: 'assets/gamelogos/game5.png',
    screen: Find10WelcomeScreen(),
  ),
  GameInfo(
    key: 'game6',
    imagePath: 'assets/gamelogos/game6.png',
    screen: MapHorizontalExample(),
  ),
];
