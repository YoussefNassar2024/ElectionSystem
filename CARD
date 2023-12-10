//import 'package:flutter/material.dart';

//class Card extends StatefulWidget {
  //const Card({super.key});

  //@override
  //State<Card> createState() => _CardState();
//}

//class _CardState extends State<Card> {
  //@override
  //Widget build(BuildContext context) {
    //return const Placeholder();
  //}
//}
import 'package:flutter/material.dart';

void main() {
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NU Poll 11/4/2023',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'NU Poll 11/4/2023'),
    );
 }
}

class MyHomePage extends StatefulWidget {
 MyHomePage({Key? key, required this.title}) : super(key: key);

 final String title;

 @override
 _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              style: TextStyle(fontSize: 24),
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