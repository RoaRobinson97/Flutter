import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avatar Page'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(2.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://talcualdigital.com/wp-content/uploads/2018/12/Chavez.jpg'),
              radius: 30.0,
              ),
          ),
            
          Container(
            margin: EdgeInsets.only(right: 25.0),
            child: CircleAvatar(
              child: Text('SL'),
              backgroundColor: Colors.brown,
            ),
          )
        ],
      ),
      body: Center(
        child: FadeInImage(
          placeholder: AssetImage('assets/original.gif'), 
          fadeInDuration: Duration(milliseconds: 200),
          image: NetworkImage('https://talcualdigital.com/wp-content/uploads/2018/12/Chavez.jpg')),
      ),
    );
  }
}