import 'package:flutter/material.dart';



class AddCandidatesScreen extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Candidates'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/addCandidates.png',
                width: 300,
                height: 300,
              ),
              SizedBox(height: 100),
              InkWell(
                onTap: () {
                 // Your function to add candidates
                },
                child: Container(
                 padding: EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                 decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                 ),
                 child: Text(
                    'Add Candidates',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                 ),
                ),
              ),
            ],
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