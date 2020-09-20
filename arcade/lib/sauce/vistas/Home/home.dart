import 'package:arcade/sauce/bloc/autenticacion/aut_event.dart';
import 'package:arcade/sauce/bloc/autenticacion/bloc.dart';
import 'package:arcade/sauce/bloc/juegos/jue_bloc.dart';
import 'package:arcade/sauce/bloc/name/bloc.dart';
import 'package:arcade/sauce/models/name.dart';
import 'package:arcade/sauce/repository/Juego_repo.dart';
import 'package:arcade/sauce/repository/Name_repo.dart';
import 'package:arcade/sauce/vistas/Home/Tarjetas.dart';
import 'package:arcade/sauce/vistas/Home/TextoNombre.dart';
import 'package:arcade/sauce/vistas/Home/UserImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  final String name;
  final JueRepo _jueRepo = JueRepo();
  NameRepo nameRepo;
  Home({Key key, @required this.name,}) : nameRepo=NameRepo(name), super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<JueBloc>(
      create: (context) => JueBloc(jueRepo: _jueRepo)..add(LoadJue()),
      child: BlocProvider<NameBloc>(
        create: (context) => NameBloc(nameRepo: nameRepo)..add(BuscarName()),
          child:Scaffold(
            appBar: AppBar(
              title: Text('¡VArcade!',
              style: TextStyle(fontFamily: 'Archery'),
              ),
              backgroundColor: Colors.deepPurple,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white,),
                  onPressed: () {},
                ),
              ],
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: TextoNombre(),
                    accountEmail: Text(name),
                    decoration: BoxDecoration(color: Colors.deepPurple),
                    currentAccountPicture: UserImage()
                  ),
                  ListTile(
                    title: Text('Records'),
                  ),
                  ListTile(
                    title: Text('Cuenta'),
                  ),
                  ListTile(
                      title: Text('Cerrar sesion'),
                      onTap: (){
                        BlocProvider.of<AutBloc>(context).add(LoggedOut());
                      }
                  ),
                ],
              ),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Tarjetas(name),
            ),
          ),
      ),
    );
  }
}

