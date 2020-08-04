import 'package:flutter/material.dart';
import 'package:qr_barproject/src/models/scan_model.dart';
import 'package:qr_barproject/src/providers/db_provider.dart';
import 'direcciones_page.dart';
import 'mapas_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currenIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('QR Scanner', textAlign: TextAlign.center,),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (){},
          )
        ],
      ),
      body: _callPage(currenIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );

  }

  Widget _crearBottomNavigationBar() {

    return BottomNavigationBar(
      currentIndex: currenIndex,
      onTap: (index){
        setState(() {
          currenIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones')
        )
      ],
    );
  }

  Widget _callPage( int paginaActual) {
    
    switch(paginaActual){
      
      case 0: return MapasPage();

      case 1: return DireccionesPage();

      default: return MapasPage();
      
    }
  }

  _scanQR() async {
    
    //https://www.androidsis.com/como-habilitar-las-opciones-de-desarrollador-en-xiaomi/

     String futureString = 'https://www.androidsis.com/como-habilitar-las-opciones-de-desarrollador-en-xiaomi/';
 
    // try {
    //   futureString = await BarcodeScanner.scan();

    // } catch (e) {
    //   futureString = e.toString();   
    // }
    
    // print('Future string: $futureString');       
    
    if (futureString != null){

      final scan = ScanModel(valor: futureString);
      DBProvider.db.nuevoScan(scan);

    }

  }

}

