import 'package:flutter/material.dart';

class BasicoPage extends StatelessWidget {

  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubTitulo = TextStyle(fontSize: 18.0, color: Colors.grey);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget> [
          _crearImagen(),
          _crearTitulo(),
          _crearAcciones(),
          _crearTexto(),
          _crearTexto(),
          _crearTexto(),
          _crearTexto(),
          _crearTexto(),
        ],), 
      )
    );
  }

  Widget _crearImagen(){
    
  return Container(
    width: double.infinity,
    child: Image(
            fit: BoxFit.cover,
            image: NetworkImage('https://www.tom-archer.com/wp-content/uploads/2017/03/landscape-photography-tom-archer-6-400x267.jpg'),
          ),
  );


  }

  Widget _crearTitulo() {

    return SafeArea(
      child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical:20.0),
              child: Row(children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children:  <Widget> [
                    Text('Lago con un puente',style: estiloTitulo),
                    SizedBox(height: 7.0,),
                    Text('Un agua por ahi', style: estiloSubTitulo,)
                    ],
                  ),
                ),
              Icon(Icons.star, color: Colors.red, size: 30.0,),
              Text('41', style: (estiloTitulo),)
              ],
              ),
            ),
    );

  }

  Widget _crearAcciones() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _accion(Icons.call, 'Call'),
        _accion(Icons.near_me, 'ROUTER'),
        _accion(Icons.share, 'Share'),
      ],
    );

  }

  Widget _accion( IconData icon, String texto ){

    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 40.0,),
        SizedBox(height: 5.0,),
        Text(texto, style: TextStyle(fontSize: 20.0, color: Colors.blue),)
      ],
    );

  }

  Widget _crearTexto() {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      child: Text('Lorem ipsum dolor sit amet,s erat.\nPhasellus sit amet nunc cursus, placerat quam ut, accumsan turpis. Quisque tempus pharetra augue, eu congue nunc placerat et. Donec mattis felis a nunc tempor bibendum non et nulla. Maecenas fermentum tortor at rutrum elementum. Nulla tincidunt accumsan nunc, ut dictum erat aliquam ac. Maecenas maximus nisi rutrum sem ultrices dapibus.',
      textAlign: TextAlign.justify,));
  }

} 