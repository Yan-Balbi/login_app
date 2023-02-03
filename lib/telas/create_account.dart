import 'package:flutter/material.dart';
import 'package:obd/telas/login_screen.dart';
import 'package:obd/widgets/TextField.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAccount extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CreateAccountState();
  }
}

class CreateAccountState extends State<CreateAccount>{
  final TextEditingController _controladorCriarEmail = TextEditingController();
  final TextEditingController _controladorCriarSenha = TextEditingController();
  //final TextEditingController _controladorCriarUser = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*TemplateFormularioLogin(
            controlador: _controladorCriarUser,
            descricao: "insira o nome de usuário",
            cor: Colors.black, estado: false,
            icone: Icons.person,
          ),*/
          TemplateFormularioLogin(
            controlador: _controladorCriarEmail,
            descricao: "insira um email",
            cor: Colors.black,
            estado: false,
            icone: Icons.email,
          ),
          TemplateFormularioLogin(
            controlador: _controladorCriarSenha,
            descricao: "insira uma senha",
            cor: Colors.black, estado: false,
            icone: Icons.lock,
          ),
          ElevatedButton(
              onPressed: (){
                CriarConta();
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text('Criar conta'),

          ),

        ],
      ),
    );
  }
  Future CriarConta() async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _controladorCriarEmail.text.trim(),
          password: _controladorCriarSenha.text.trim(),
      );
    } on FirebaseAuthException catch(e){
      print(e);
    }
  }
}

