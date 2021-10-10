import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contato Form',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ContatoModel contato = ContatoModel();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(contato.nome ?? ''),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 20,
              runSpacing: 10,
              children: <Widget>[
                TextFormField(
                  validator: nomeValidator(),
                  onChanged: updateNome,
                  decoration: InputDecoration(labelText: "Nome"),
                  maxLength: 100,
                ),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: updateTefone,
                  decoration: InputDecoration(labelText: "Celular"),
                ),
                TextFormField(
                  validator: emailValidator(),
                  onChanged: updateEmail,
                  decoration: InputDecoration(labelText: "E-mail"),
                ),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
                  onChanged: updateCpf,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "CPF"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      print(contato);
                    }
                  },
                  
                )
              ],
            ),
          ),
        ));
  }
}

class ContatoModel {
  String nome;
  String email;
  String cpf;
  String telefone;
  ContatoType tipo;
}

enum ContatoType { CELULAR, TRABALHO, FAVORITO, CASA }
