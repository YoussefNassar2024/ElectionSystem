import 'package:flutter/material.dart';

class HistoryCard extends StatefulWidget {
  HistoryCard({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Ahmed Mohamed won by',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            Text(
              '53% of votations',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                print('Congratulations! Button pressed');
              },
              child: Text('Congratulations!'),
            ),
          ],
        ),
      ),
    );
  }
}
