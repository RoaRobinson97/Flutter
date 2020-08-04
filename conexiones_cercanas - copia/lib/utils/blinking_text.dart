import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

Widget blinkingText(String string){
  return SizedBox(
  width: 250.0,
  child: FadeAnimatedTextKit(

    repeatForever: true,
    text: [
      string
    ],
    textStyle: TextStyle(
        fontSize: 20, 
        fontWeight: FontWeight.bold,
        color: Colors.white
    ),
    textAlign: TextAlign.center,
    alignment: AlignmentDirectional.topStart // or Alignment.topLeft
  ),
);
}