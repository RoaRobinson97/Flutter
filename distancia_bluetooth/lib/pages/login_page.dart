import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: instagramButtom())
    );
  }

  Widget instagramButtom() {

    return RaisedButton(
      child: Text("Entrar con instagram"),
      onPressed: logear,
            color: Colors.red,
            textColor: Colors.yellow,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            splashColor: Colors.grey);
        }
      
       void logear() {
        Navigator.pushNamed(context, 'home');
       }


}