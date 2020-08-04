import 'package:aplicacion_peliculas/src/models/actores_model.dart';
import 'package:aplicacion_peliculas/src/models/pelicula_model.dart';
import 'package:aplicacion_peliculas/src/providers/peliculas_provider.dart';
import 'package:flutter/material.dart';

class PeliculaDetalle extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    
  final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget> [
          _crearAppbar( pelicula  ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0,),
                _posterTitulo(context, pelicula),
                _descripcion( pelicula),
                _crearCasting(  pelicula ),
              ]
            ),
            ),
        ],
      )
    );
  }

Widget _crearAppbar(Pelicula pelicula) {

  return SliverAppBar(
    elevation: 2.0,
    backgroundColor: Colors.indigoAccent,
    expandedHeight: 200.0,
    floating: false,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle:  true,
      title: Text(pelicula.title, style:  TextStyle(color: Colors.white, fontSize: 16.0)),
      background: FadeInImage(
        image: NetworkImage(pelicula.getBackgroundImg()),
        placeholder: AssetImage('assets/loading.gif'),
        fadeInDuration: Duration(milliseconds: 150),
        fit: BoxFit.cover,
        ),
      
    ),
  );
}

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueid,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 10.0,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(pelicula.title, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis,),
                Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis),
                Row(children: <Widget>[
                  Icon(Icons.star),
                  Text(pelicula.voteAverage.toString(),style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis)
                ],)
                ],
            )
          )
        ],
      ),
    );

  }

  Widget _descripcion(Pelicula pelicula) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal:10.0, vertical: 10.0),
      child: Text(
        pelicula.overview, 
        textAlign: TextAlign.justify,),
    );
  }

  Widget _crearCasting(Pelicula pelicula) {

    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        
        if (snapshot.hasData){
          return _crearActoresPageView(snapshot.data);
        } else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );

  }

  Widget _crearActoresPageView(List<Actor> actores) {

    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        itemCount: actores.length,
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemBuilder: (context, i) => _tarjetaActor(actores[i])
      ),
    );
  }

  Widget _tarjetaActor(Actor actor){

    return Container(
      child: Column(  
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FadeInImage(
              image: NetworkImage(actor.getPhoto()),
              placeholder: AssetImage('assets/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(actor.name, overflow: TextOverflow.ellipsis,)
        ],
      )
    );
  }

}