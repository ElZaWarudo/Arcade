import 'package:arcade/sauce/bloc/name/bloc.dart';
import 'package:arcade/sauce/models/name.dart';
import 'package:arcade/sauce/vistas/Home/UsuarioAlerta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextoNombre extends StatefulWidget {
  @override
  _TextoNombreState createState() => _TextoNombreState();
}

class _TextoNombreState extends State<TextoNombre> {
  List<Name> NameList = [];

  _TextoNombreState();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NameBloc, NameState>(builder: (context, state) {
      if (state is SinUsername) {
        return CircularProgressIndicator();
      }
      if (state is Fallo) {
        return Text('Algo salió mal...');
      }
      if (state is Obtenido) {
        NameList = state.name;
        return Container(
          child: NameList.length == 0
              ? Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UsuarioAlerta()))
              : Text(NameList[0].usuario),
        );
      }
      return Container();
    });
  }
}
