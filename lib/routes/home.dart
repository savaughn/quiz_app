import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quizr'),
        ),
        body: Container(
          child: Center(
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/quiz');
              },
              elevation: 3,
              // padding: const EdgeInsets.all(5),
              child: Text(
                'Daily Quiz',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[50],
                ),
              ),
              color: Colors.blue[400],
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(20),
            ),
          ),
          margin: EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
        ),
      ),
    );
  }
}
