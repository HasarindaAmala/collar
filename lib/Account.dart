import 'package:flutter/material.dart';

class AcoountScreen extends StatefulWidget {
  final String id;
  const AcoountScreen(this.id, {super.key});

  @override
  State<AcoountScreen> createState() => _AcoountScreenState();
}

class _AcoountScreenState extends State<AcoountScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: width,
            height: height*0.6,
            color: Colors.pink,
            child: Center(child: Text(widget.id,style: TextStyle(color: Colors.blueAccent),)),
          ),


        ],
      ),
    );
  }
}
