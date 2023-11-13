import 'package:flutter/material.dart';


void main() {
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Create Poll'),
        ),
        body: Center(
          child: Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                 'Enter Your Poll Title',
                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 10),
                TextField(
                 decoration: InputDecoration(
                    hintText: 'Enter Your Poll Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                 ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here
          },
          backgroundColor: Colors.blue,
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      ),    
    );
 }
}