import 'package:flutter/material.dart';





class NextScreen extends StatefulWidget {
  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("هدا إعلان مثلاً",style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
