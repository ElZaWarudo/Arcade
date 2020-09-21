import 'package:arcade/sauce/bloc/verificacion/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Verificacion extends StatefulWidget {
  @override
  _VerificacionState createState() => _VerificacionState();
}

class _VerificacionState extends State<Verificacion> {
  final TextEditingController _codigoController = TextEditingController();

  VeriBloc _veriBloc;

  @override
  void initState() {
    super.initState();
    _veriBloc = BlocProvider.of<VeriBloc>(context);
    _veriBloc.add(Empezar());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VeriBloc, VeriState>(builder: (context, state) {
      if (state is Verificado) {
        return ListTile(
          leading: Icon(FontAwesomeIcons.envelope),
          title: Text("Email confirmado")
        );
      }
      if (state is NoVerificado) {
        return ListTile(
          leading: Icon(FontAwesomeIcons.envelope),
          title: Text("Confirmar email"),
          onTap: () {
            _veriBloc.add(PedirConfirmacion());
          },
        );
      }
      if (state is Esperando) {
        return ListTile(
            leading: Icon(FontAwesomeIcons.envelope),
            title: Text("Email enviado")
        );
      }
      return Container(width:50,height: 50);
    });
  }
}
