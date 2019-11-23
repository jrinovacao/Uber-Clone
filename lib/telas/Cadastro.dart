import 'package:flutter/material.dart';
import 'package:uber_clone/model/Usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  bool _tipoUsuario = false;
  String _mensagemErro = "";

  _validarCampos(){

    //Recuperar dados dos campos
    String nome =_controllerNome.text;
    String email =_controllerEmail.text;
    String senha =_controllerSenha.text;

    //validar campos
    if(nome.isNotEmpty){
      
      if(email.isNotEmpty && email.contains("@")){

        if(senha.isNotEmpty && senha.length > 6){


          Usuario usuario = new Usuario();

          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;
          usuario.tipoUsuario = usuario.verificaTipoUsuario(_tipoUsuario);

          _cadastrarUsuario(usuario);


        }else{
          setState(() {
            _mensagemErro = "Preencha o senha! digite mais de 6 caracteres...!";
          });
        }

      }else{
        setState(() {
          _mensagemErro = "Preencha um email valido!";
        });
      }

    }else{
      setState(() {
        _mensagemErro = "Preencha o nome do usuario...!";
      });
    }

  }


  _cadastrarUsuario(Usuario usuario){

    FirebaseAuth auth = FirebaseAuth.instance;
    Firestore db = Firestore.instance;

    auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){

      db.collection("usuario")
          .document(firebaseUser.user.uid)
          .setData(usuario.toMap());

      //redireciona para o painel de acordo com o tipo de usuario
        switch(usuario.tipoUsuario){
          case "motorista" : Navigator.pushAndRemoveUntil(
              context,
              "/painel-motorista",
              (_) => false
          );
          break;

          case "passageiro" : Navigator.pushAndRemoveUntil(
              context,
              "/painel-passageiro",
                  (_) => false
          );
          break;
        }

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
      ),

      body: Container(

        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                TextField(
                  controller: _controllerNome,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Nome Completo",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      )
                  ),
                ),



                TextField(
                  controller: _controllerEmail,
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "email",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      )
                  ),
                ),

                TextField(
                  controller: _controllerSenha,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      )
                  ),
                ),

                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Text("Passageiro"),
                        Switch(
                            value: _tipoUsuario,
                            onChanged: (bool valor){
                                _tipoUsuario = valor;
                            }
                        ),
                        Text("Motorista"),
                      ],
                    ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        ),
                      ),
                      color: Color(0xff1ebbd8),
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      onPressed: (){
                          _validarCampos();
                      }
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      _mensagemErro,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
