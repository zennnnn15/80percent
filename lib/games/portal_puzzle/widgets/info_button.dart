import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart' as k;
import 'widgets.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FancyButton(
      label: '?',
      surfaceColor: k.lightSlate,
      sideColor: k.slate,
      textColor: k.darkSlate,
      onPressed: () => showDialog(
        context: context,
        builder: (context) => const _InfoDialog(),
      ),
    );
  }
}

class _InfoDialog extends StatelessWidget {
  const _InfoDialog({Key? key}) : super(key: key);

  Future<void> openSimpleLink(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(16),
      title: const Center(child: Text(k.appName)),
      children: [
        const SizedBox(height: 16),
        const Text(
          'How to play',
          style: TextStyle(fontSize: 18),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('1. Press the Play button.'),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('2. Wait until the shuffling ends.'),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
              '3. Move the tiles horizontally or vertically until you find the solution.'),
        ),
        SizedBox(
          width: 200,
          height: 200,
          child: Image.asset('assets/images/game-play-min.gif'),
        ),
        const SizedBox(height: 16),
        const Text(
          'Tips & Tricks',
          style: TextStyle(fontSize: 18),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
              'You can select a difficulty. Maybe start from the Easy one.'),
        ),

        const SizedBox(height: 16),



      ],
    );
  }
}
