import 'package:arcade/sauce/bloc/cuenta/bloc.dart';
import 'package:arcade/sauce/models/cuenta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextoNombre extends StatefulWidget {
  @override
  _TextoNombreState createState() => _TextoNombreState();
}

class _TextoNombreState extends State<TextoNombre> {
  List<cuenta> NameList = [];

  _TextoNombreState();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CueBloc, CueState>(builder: (context, state) {
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
              ? Container()
              : Text(NameList[0].usuario),
        );
      }
      return Container();
    });
  }
}
