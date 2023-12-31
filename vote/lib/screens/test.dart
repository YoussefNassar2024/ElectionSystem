import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
            "https://firebasestorage.googleapis.com/v0/b/election-37353.appspot.com/o/voter_data%2F20231231142337%2FNpaZ4DKeeyd9R6SBJu8gapDUVzK2%2Fid%2F1704025438884.png?alt=media&token=4cfb9917-19ae-4567-bdd0-276f98859e6b"),
      ),
    );
  }
}
