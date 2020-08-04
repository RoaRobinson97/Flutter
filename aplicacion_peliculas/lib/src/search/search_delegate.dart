import 'package:aplicacion_peliculas/src/models/pelicula_model.dart';
import 'package:aplicacion_peliculas/src/providers/peliculas_provider.dart';
import 'package:flutter/material.dart';

class DataSearch  extends SearchDelegate {

  final peliculas = ['Spiderman','Batman','Aquaman','Shazam','Ironman','Capitan America'];

  final peliculasRecientes = ['Spiderman','Capitan America'];

  String seleccion ='';

  final peliculasProvider = new PeliculasProvider();


  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de nuestro Appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },  
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a ala izquierda del Appbar
    return IconButton(
      icon: AnimatedIcon(
        progress: transitionAnimation,
        icon: AnimatedIcons.menu_arrow,),
      onPressed: (){
        close(context, null);
      } ,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea resultados a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(seleccion),

      ),);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen cuadno la persona escribe

  if(query.isEmpty){
    return Container();
  }

  return FutureBuilder(
    future: peliculasProvider.buscarPelicula(query),
    builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {

      if(snapshot.hasData){

        final peliculas = snapshot.data;

          return ListView(
            children: peliculas.map( (pelicula){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalLanguage),
                onTap: (){
                  close(context, null);
                  pelicula.uniqueid = '';
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList()
          );
      }else{
        return Center(child: CircularProgressIndicator(),);
      }
    },
  );
  
  }
}

// @override
//   Widget buildSuggestions(BuildContext context) {
//     // Sugerencias que aparecen cuadno la persona escribe

//     final listaSugerida = (query.isEmpty) 
//                         ? peliculasRecientes 
//                         : peliculas.where(
//                           (p) => p.toLowerCase().startsWith(query.toLowerCase())
//                         ).toList();
                        
//     return ListView.builder(
//       itemCount: listaSugerida.length,
//       itemBuilder: (context,i){
//         return  ListTile(
//           leading: Icon(Icons.movie),
//           title: Text(listaSugerida[i]),
//           onTap: (){},
//         );
//       },

//     );
//   }