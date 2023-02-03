import 'package:flutter/material.dart';
import 'package:obd/telas/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:obd/telas/barra_de_navegacao/home.dart';
import 'package:obd/telas/barra_de_navegacao/corrida.dart';
import 'package:obd/telas/barra_de_navegacao/historico.dart';


class PagInicial extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PagInicialState();
  }
}


class PagInicialState extends State<PagInicial>{
  int _indice = 0;
  final List<Widget> _telas = [
    PageScreen("Home"),
    PageScreen("Corrida"),
    PageScreen("Histórioco"),
    PageScreen("Pesquisa"),
  ];
  final _screens = [
    HomePage(),
    BluetoothPairingScreen(),
    HistoricoPage(),
    //PesquisaPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green, Colors.lightGreenAccent],
                ),
              ),
              child: Container(
                child: Column(
                  children: [
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(25),),
                      child: Image.asset('images/icone.png',width: 80,height: 80,),
                    ),
                    //Text(usuario.email!),
                  ],
                ),
              ),

            ),
            ListTile(
              onTap: (){},
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
            ),
            ListTile(
              onTap: (){},
              leading: Icon(Icons.person),
              title: Text('Perfil'),
            ),

            ElevatedButton(onPressed: (){
              FirebaseAuth.instance.signOut();
            },
                child: Text('sair'))
          ],
        ),
      ),
      //========================================================================
      appBar: AppBar(
        title: Text('OBD App'),//Vou tirar isso depois
      ),
      body: _screens[_indice],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indice,
        onTap: onTabTapped,
        type: BottomNavigationBarType.shifting, // Shifting
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:  Icon(Icons.home),
            label: 'Home',

          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.flag),
            label: 'Corrida',

          ),
          BottomNavigationBarItem(
              icon:  Icon(Icons.history),
              label: 'Histórico'

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Pesquisa'
          ),
        ],
      ),
    );
  }
  void onTabTapped(int index){
    setState((){
      _indice = index;
    });
  }
}

class PageScreen extends StatelessWidget{
  late final String texto;
  PageScreen(this.texto);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(texto),
      ),
    );
  }
}

