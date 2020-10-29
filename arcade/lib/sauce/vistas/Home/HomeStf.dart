import 'package:arcade/sauce/bloc/cuenta/bloc.dart';
import 'package:arcade/sauce/models/cuenta.dart';
import 'package:arcade/sauce/repository/Cue_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home.dart';

class HomeStf extends StatefulWidget {

  final String name;


  HomeStf(this.name);

  @override
  _HomeStfState createState() => _HomeStfState(name);
}

class _HomeStfState extends State<HomeStf> {


  CueRepo cueRepo;
  final String name;
  List<cuenta> NameList = [];
  _HomeStfState(this.name);

  @override
  void initState() {
    cueRepo=CueRepo(name);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CueBloc>(
        create: (context) => CueBloc(cueRepo: cueRepo)..add(BuscarName()),
      child: Home(name),
    );
  }


}
