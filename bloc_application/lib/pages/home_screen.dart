import 'package:flutter/material.dart';
import 'counter_screen.dart';
import 'package:bloc_application/blocs/counter_bloc.dart';
import 'package:bloc_application/flutter_bloc/bloc_builder.dart';
import 'package:bloc_application/bloc/bloc_provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  void _pushScreen(BuildContext context, Widget screen){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen)
    );
  }

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('BLoC example'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: Text('Counter'),
            trailing: Chip(
              label: Text('Local State'),
              backgroundColor: Colors.blue[800],
            ),
          onTap: () => _pushScreen(context, CounterScreenWithLocalState()),
          ),
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: Text('Counter'),
            subtitle: BlocBuilder(
              bloc: counterBloc,
              builder: (BuildContext context, int state){
                return Text('$state');
              }
            ),
            trailing: Chip(
              label: Text('Global State'),
              backgroundColor: Colors.green[800],
            ),
          onTap: () => _pushScreen(context, CounterScreenWithGlobalState()),
          onLongPress: (){
            counterBloc.dispatch(CounterEvent.increment); 
          },
          )
        ],
      ),
    );
  }
}