import 'package:flutter/material.dart';
import 'package:uber_clone/model/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();

  String _mensagemErro = "";


  _validarCampos(){

    //Recuperar dados dos campos

    String email =_controllerEmail.text;
    String senha =_controllerSenha.text;

    //validar campos
      if(email.isNotEmpty && email.contains("@")){

        if(senha.isNotEmpty && senha.length > 6){


          Usuario usuario = Usuario();


          usuario.email = email;
          usuario.senha = senha;


          _logarUsuario(usuario);


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

    }

  }


  _logarUsuario(Usuario usuario){

     FirebaseAuth auth = FirebaseAuth.instance;

     auth.signInWithEmailAndPassword(
         email: usuario.email,
         password: usuario.senha
     ).then((firebaseUser){

       Navigator.pushReplacementNamed(
           context,
           "/painel-passageiro"
       );

     }).catchError((error){
       _mensagemErro = "Erro ao autenticar usuario, verifique e-mail e senha";
     });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("imagens/fundo.png"),
            fit: BoxFit.cover
          )
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                      "imagens/logo.png",
                    width: 200,
                    height: 150,
                  ),
                ),
                TextField(
                   controller: _controllerEmail,
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "E-mail",
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
                      hintText: "Senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)
                      )
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 10),
                    child: RaisedButton(
                      child: Text(
                          "Entrar",
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
                Center(
                  child: GestureDetector(
                    child: Text("Nao tem conta? cadastre-se",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: (){
                        Navigator.pushNamed(
                            context, "/cadastro"
                        );
                    },
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
