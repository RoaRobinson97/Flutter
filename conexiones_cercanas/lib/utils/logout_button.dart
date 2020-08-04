

import 'package:conexiones_cercanas/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'alarm.dart';
 
Widget logout_button(BuildContext context,_user,_googleSignIn, Alarma alarma){

  return Container(
    decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(247, 131, 97, 1),
                  Color.fromRGBO(245, 75, 100, 1),
                  ]),
              ),
    child: FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    onPressed: () {
                   // alarma.stop();
                    _googleSignIn.signOut();
                    Navigator.pop(context);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPageWidget())
                    );
                  },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.exit_to_app, color: Colors.white70),
                      ],
                    )
            
                ),
  );
  
}