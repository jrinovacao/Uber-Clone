import 'package:flutter/material.dart';
import 'package:uber_clone/Rotas.dart';
import 'package:uber_clone/telas/Home.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xff37474f),
  accentColor: Color(0xff546e7a),
);

void main() => runApp(MaterialApp(
  title: "Uber Clone",
  home: Home(),
  theme: temaPadrao,
  initialRoute: "/",
  onGenerateRoute: Rotas.gerarRotas,
  debugShowCheckedModeBanner: false,
));

