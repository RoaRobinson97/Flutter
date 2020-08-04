import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
          _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
        ],
      ),

    );
  }

  Widget _cardTipo1(){

    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0)
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.photo_album, color: Colors.blue,),
            title: Text('Titulo de tarjeta'),
            subtitle: Text('Descripcion de tarjeta'),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: (){},
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: (){},
            ),
          ],)
        ],
      ),
    );


  } 

  Widget _cardTipo2(){
    final card = Container(
      //clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage('https://static.photocdn.pt/images/articles/2017/03/15/iStock-643708226.jpg'),
            placeholder: AssetImage('assets/original.gif'),
            fadeInDuration: Duration(milliseconds: 200),
            height: 300.0,
            fit: BoxFit.cover,
          ),

          /*Image(
            image: NetworkImage('https://static.photocdn.pt/images/articles/2017/03/15/iStock-643708226.jpg'),
          ),*/

          Container(
            padding: EdgeInsets.all(10.0),
            child: Text('Algo'))
        ],
      ),
    );

    return Container(
      child: ClipRRect(
        child: card,
        borderRadius: BorderRadius.circular(30.0),),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0,10.0)
          )
        ],
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,

      ),);

  }
}