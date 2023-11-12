import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Games Played by Kids",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          // Display statistics about games here
          GameStatisticsWidget(),

          SizedBox(height: 24),

          Text(
            "Time Spent by Kids",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          // Display statistics about time spent here
          TimeStatisticsWidget(),
        ],
      ),
    );
  }
}

class GameStatisticsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your game statistics data
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: <Widget>[
          // Display game statistics here
          GameStatisticItem(name: "Game 1", count: 25),
          GameStatisticItem(name: "Game 2", count: 30),
          GameStatisticItem(name: "Game 3", count: 15),
          // Add more GameStatisticItem widgets as needed
        ],
      ),
    );
  }
}

class GameStatisticItem extends StatelessWidget {
  final String name;
  final int count;

  GameStatisticItem({required this.name, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(name),
        Text("Count: $count"),
      ],
    );
  }
}

class TimeStatisticsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this with your time statistics data
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: <Widget>[
          // Display time statistics here
          TimeStatisticItem(name: "Game 1", time: "2 hours"),
          TimeStatisticItem(name: "Game 2", time: "1.5 hours"),
          TimeStatisticItem(name: "Game 3", time: "3 hours"),
          // Add more TimeStatisticItem widgets as needed
        ],
      ),
    );
  }
}

class TimeStatisticItem extends StatelessWidget {
  final String name;
  final String time;

  TimeStatisticItem({required this.name, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(name),
        Text("Time: $time"),
      ],
    );
  }
}