import 'package:aplicacion_peliculas/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      
      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent -200){

        siguientePagina();

      }

    });

    return Container(
      height: _screenSize.height*0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        //children: _tajetas(context),
        itemCount: peliculas.length,
        itemBuilder: (  context, i  ){
          return _tarjeta(context, peliculas[i]);
        },
      ),
    );
  }


  Widget _tarjeta(BuildContext context, Pelicula pelicula){

 pelicula.uniqueid = '${pelicula.id}-poster';

    final tarjeta = Container(

        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
          Hero(
            tag: pelicula.uniqueid,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/no-image.jpg'),
                fit: BoxFit.cover,
                height: 140.0,
                ),
            ),
          ),
          Container(
            child: Text(pelicula.title, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.caption ,),
            
            )
          ],
        ),
      );

      return GestureDetector(
        child: tarjeta  ,
        onTap: (){
          
          Navigator.pushNamed(context, 'detalle', arguments: pelicula);
        },
      );
  }

  List<Widget> _tajetas(BuildContext context) {

    return peliculas.map((pelicula) {

      return Container(

        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(pelicula.getPosterImg()),
              placeholder: AssetImage('assets/no-image.jpg'),
              fit: BoxFit.cover,
              height: 140.0,
              ),
          ),
          Container(
            child: Text(pelicula.title, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.caption ,),
            
            )
          ],
        ),
      );

    }).toList();

  }

}