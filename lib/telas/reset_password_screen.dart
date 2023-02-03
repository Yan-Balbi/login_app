import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';


class ResetPassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ResetPasswordState();
  }
}

class ResetPasswordState extends State<ResetPassword> {
  final TextEditingController controladorResetEmail = TextEditingController();

  @override
  void dispose(){
    controladorResetEmail.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resetar a senha'),
      ),
      body: Column(
        children: [
          Text('Insira seu email para resetar a senha'),
          TextFormField(
            controller: controladorResetEmail,
            decoration: InputDecoration(labelText: 'Email'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (controladorResetEmail) => controladorResetEmail != null && !EmailValidator.validate(controladorResetEmail)
                  ? 'Enter a valid email'
                  :null,
          ),
          ElevatedButton(
            onPressed: (){
              passwordReset();
            },
            child: Text('Resetar Senha'),
          ),
        ],
      ),
    );
  }

  Future passwordReset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: controladorResetEmail.text.trim());
    } on FirebaseAuthException catch (e){
      print(e);
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content: Text('Email inválido'),
            );
          }
      );

    }
    print(controladorResetEmail);
  }
}


