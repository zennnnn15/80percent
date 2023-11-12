import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../games/GiantDwarf/dwarforginat.dart';
import '../games/GiantDwarf/dwarfwelcomescreen.dart';
import '../games/Tetris/tetriswelcome.dart';
import '../games/spot_the_difference/levelSeleectstd.dart';

class ManageGames extends StatefulWidget {
  @override
  _ManageGamesState createState() => _ManageGamesState();
}

class _ManageGamesState extends State<ManageGames> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  Map<String, bool> gameVisibility = {

  };

  @override
  void initState() {
    super.initState();
    _getUserAndFetchGameVisibility();
  }

  Future<void> _getUserAndFetchGameVisibility() async {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _user = user;
      });

      await _fetchGameVisibility(user.uid);
    }
  }

  Future<void> _fetchGameVisibility(String userUID) async {
    final userGamesCollection =
    FirebaseFirestore.instance.collection('users/$userUID/games');
    for (final gameInfo in gamesData) {
      final gameDoc = await userGamesCollection.doc(gameInfo.key).get();
      if (gameDoc.exists) {
        final visibility = gameDoc.data()?['visibility'] ?? false;
        setState(() {
          gameVisibility[gameInfo.key] = visibility;
        });
      } else {
        setState(() {
          gameVisibility[gameInfo.key] = false;
        });
      }
    }
  }

  Future<void> _updateGameVisibility(String gameKey, bool visibility) async {
    final userUID = _user?.uid;
    if (userUID != null) {
      final userGamesCollection =
      FirebaseFirestore.instance.collection('users/$userUID/games');
      await userGamesCollection.doc(gameKey).set({'visibility': visibility});
      setState(() {
        gameVisibility[gameKey] = visibility;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Games"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (ctx, index) {
          final gameInfo = gamesData[index];
          return GameTile(
            gameInfo: gameInfo,
            isVisible: gameVisibility[gameInfo.key] ?? false,
            onToggle: (newValue) {
              _updateGameVisibility(gameInfo.key, newValue);
            },
          );
        },
        itemCount: gamesData.length,
      ),
    );
  }
}

class GameTile extends StatelessWidget {
  final GameInfo gameInfo;
  final bool isVisible;
  final ValueChanged<bool> onToggle;

  GameTile({
    required this.gameInfo,
    required this.isVisible,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Image.asset(
            gameInfo.imagePath,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Switch(
              value: isVisible,
              onChanged: onToggle,
            ),
          ),
        ],
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
  GameInfo(
    key: 'game1',
    imagePath: 'assets/gamelogos/game1.png',
    screen: DwarforGiant(),
  ),
  GameInfo(
    key: 'game2',
    imagePath: 'assets/gamelogos/game2.png',
    screen: TetrisWelcomeScreen(),
  ),
  GameInfo(
    key: 'game3',
    imagePath: 'assets/gamelogos/game3.png',
    screen: TetrisWelcomeScreen(),
  ),
  GameInfo(
    key: 'game4',
    imagePath: 'assets/gamelogos/game4.png',
    screen: DwarfWelcomeScreen(),
  ),
  GameInfo(
    key: 'game5',
    imagePath: 'assets/gamelogos/game5.png',
    screen: DwarfWelcomeScreen(),
  ),
  GameInfo(
    key: 'game6',
    imagePath: 'assets/gamelogos/game6.png',
    screen: SpotTheDiffLevelSelect(),
  ),
];
