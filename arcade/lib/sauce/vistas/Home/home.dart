import 'package:arcade/sauce/bloc/exist/bloc.dart';
import 'package:arcade/sauce/bloc/juegos/jue_bloc.dart';
import 'package:arcade/sauce/bloc/cuenta/bloc.dart';
import 'package:arcade/sauce/models/cuenta.dart';
import 'package:arcade/sauce/repository/Exist_Repo.dart';
import 'package:arcade/sauce/repository/Juego_repo.dart';
import 'package:arcade/sauce/repository/Cue_repo.dart';
import 'package:arcade/sauce/vistas/Config/configuracion.dart';
import 'package:arcade/sauce/vistas/Partes/Tarjetas.dart';
import 'package:arcade/sauce/vistas/Partes/Alerta.dart';
import 'package:arcade/sauce/vistas/Partes/TextoNombre.dart';
import 'package:arcade/sauce/vistas/Partes/UserImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  final String name;
  String id;
  final JueRepo _jueRepo = JueRepo();
  CueRepo cueRepo;

  Home({
    Key key,
    @required this.name,
  })  : cueRepo = CueRepo(name),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<cuenta> NameList = [];
    return MultiBlocProvider(
      providers: [
        BlocProvider<JueBloc>(
          create: (context) => JueBloc(jueRepo: _jueRepo)..add(LoadJue()),
        ),
        BlocProvider<CueBloc>(
          create: (context) => CueBloc(cueRepo: cueRepo)..add(BuscarName()),
        ),
        BlocProvider<ExBloc>(
          create: (context) => ExBloc(exRepo: ExRepo()),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '¡VArcade!',
            style: TextStyle(fontFamily: 'Audiowide'),
          ),
          backgroundColor: Colors.deepPurple,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
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
                  currentAccountPicture: UserImage()),
              ListTile(
                title: Text('Records'),
                /*onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TablaScreen()));
                    }*/
              ),
              ListTile(
                  title: Text('Cuenta'),
                  onTap: () {
                    BlocProvider.of<CueBloc>(context).add(BuscarName());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Configuracion(id,name)));
                  }),
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BlocBuilder<CueBloc, CueState>(
            builder: (context, state) {
              if (state is Obtenido) {
                NameList = state.name;
                return Container(
                  child: NameList.length == 0
                      ? Alerta(name)
                      : Aceptado(NameList[0].id,NameList[0].usuario),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
  Widget Aceptado(String Id, String usuario){
    id=Id;
    return Tarjetas(usuario);
  }
}
