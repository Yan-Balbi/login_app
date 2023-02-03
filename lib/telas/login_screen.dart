import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:obd/telas/create_account.dart';
import 'package:obd/widgets/TextField.dart';//importa o TemplateFormularioLogin()
import 'package:obd/telas/reset_password_screen.dart';


class Titulo extends StatelessWidget{

  final String nome;
  final Color cor;
  final double tamanho;

  Titulo(this.nome, this.cor, this.tamanho);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(0.0),
        child: Text(
          nome,
          style: TextStyle(
            color: cor,
            fontSize: tamanho,
          ),
        )
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controladorEmail = TextEditingController();
  final TextEditingController _controladorSenha = TextEditingController();
  @override
  void dispose(){
    _controladorEmail.dispose();
    _controladorSenha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Titulo('OBD2 APP', Colors.green, 36),
              Titulo('Inmetro', Colors.green, 24),
              SizedBox(height: 16,),
              TemplateFormularioLogin(controlador: _controladorEmail, descricao: 'email de usuario', cor: Colors.blueGrey, estado: false,icone: Icons.email_outlined),
              TemplateFormularioLogin(controlador: _controladorSenha, descricao: 'senha de usuario', cor: Colors.black, estado: true,icone: CupertinoIcons.lock_fill),
              ElevatedButton(
                  onPressed: login,
                  child: Text('Login')
              ),
              GestureDetector(
                child: Text(
                  'Esqueceu a senha?',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                onTap: (){
                  Navigator.push(
                      context,
                    MaterialPageRoute(builder: (context) => ResetPassword()),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Não tem uma conta? Crie uma'),
                  TextButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CreateAccount()));
                    },
                    child: Text('aqui', selectionColor: Colors.blue)),
                ],
              ),
            ],
          )
      ),
    );
  }


  Future login() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _controladorEmail.text.trim(),
          password: _controladorSenha.text.trim()
      );
    }on FirebaseAuthException catch (e){
      print(e);
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content: Text('Senha ou email incorretos. Tente novamente'),
            );
          }
      );
    }
  }
}

