import 'package:flutter/material.dart';
import 'package:uber_clone/telas/Cadastro.dart';
import 'package:uber_clone/telas/Home.dart';

class Rotas{

  static Route<dynamic> gerarRotas(RouteSettings settings){
    switch(settings.name){
      case "/":
        return MaterialPageRoute(
            builder: (_) => Home()
        );

      case "cadastro":
        return MaterialPageRoute(
            builder: (_) => Cadastro()
        );
      default:
        _erroRota();
    }
  }

  static Route<dynamic> _erroRota(){
    return MaterialPageRoute(
      builder: (_){
        return Scaffold(
          appBar: AppBar(
            title: Text("Tela nao encontrada!"),
          ),
          body: Center(
            child: Text("Tela nao encontrada"),
          ),
        );
      }
    );
  }
}