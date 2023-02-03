import 'package:flutter/material.dart';

class TemplateFormularioLogin extends StatelessWidget{

  final TextEditingController controlador;
  final bool estado;
  final String descricao;
  final Color cor;
  final IconData? icone;

  TemplateFormularioLogin({required this.controlador ,required this.descricao,required this.cor, required this.estado, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        cursorColor: cor,
        controller: controlador,
        obscureText: estado,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: descricao,
          icon: Icon(
            icone,
            color: cor,
          ),
        ),
        textInputAction: TextInputAction.next,
      ),
    );
  }
}