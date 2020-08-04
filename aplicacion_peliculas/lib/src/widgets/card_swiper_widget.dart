import 'package:aplicacion_peliculas/src/models/pelicula_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiper({ @required this.peliculas });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;


    return Container(
      
      padding: EdgeInsets.only(top: 20.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width*0.7,
        itemHeight: _screenSize.height*0.5,
          itemBuilder: (BuildContext context, int index){

            peliculas[index].uniqueid = '${peliculas[index].id}-tarjeta';
            
            return Hero(
              tag: peliculas[index].id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]),
                  child: FadeInImage(
                    image: NetworkImage(peliculas[index].getPosterImg()),
                    placeholder: AssetImage('assets/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                )
                //child: Text(peliculas[index].toString()),
              ),
            );
          },
          itemCount: peliculas.length,
          //pagination: new SwiperPagination(),
          //control: new SwiperControl(),
        ),
    );
      
  }
}