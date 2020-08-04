import 'package:bloc_application/blocs/myBloc_delegate.dart';
import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
import 'package:bloc_application/bloc/bloc_supervisor.dart';
import 'package:bloc_application/bloc/bloc_delegate.dart';
import 'package:bloc_application/blocs/counter_bloc.dart';
import 'package:bloc_application/bloc/bloc_provider.dart';

void main(){

  BlocSupervisor.delegate = MyBlocDelegate();
  
  final counterBloc = CounterBloc();

  runApp(
    BlocProvider<CounterBloc>(
    bloc:   counterBloc,
    child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(),
     )
    )
  );
}