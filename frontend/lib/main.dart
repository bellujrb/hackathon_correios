import 'package:flutter/material.dart';
import 'dart:async'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assistente dos Correios',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  String _response = '';
  bool _isLoading = false; 

  void _checkInput() {
    setState(() {
      _isLoading = true; 
    });

    Timer(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false; 

        if (_controller.text.trim().toLowerCase() == 'embalagem irregular para envio internacional') {
          _response = '''Embale o item de acordo com as normas de exportação. Aqui estão os códigos de produtos mais comuns para este tipo de envio internacional:

SEDEX Mundi: Código 04141 - Serviço expresso para envios internacionais.
EMS (Express Mail Service): Código 05150 - Serviço prioritário para envios urgentes.
PAC Internacional: Código 05665 - Serviço econômico para envios internacionais não urgentes.
Documentos via Carta Registrada Internacional: Código 06050 - Para o envio de documentos com registro e aviso de recebimento.
Mercadoria via Importa Fácil: Código 05500 - Para facilitar a importação de mercadorias no Brasil.
Exporta Fácil: Código 05310 - Para micro e pequenas empresas exportarem seus produtos.''';
        } else {
          _response = 'Exemplo: "embalagem irregular para envio internacional" para ver as informações.';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assistente de Envio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Oi! Sou a Cora, sua copilota!',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Se precisar de ajuda, é só me chamar no chat ao lado que eu estou aqui para te ajudar!',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Digite sua dúvida abaixo:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Digite "embalagem irregular para envio internacional"',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _checkInput,
              child: const Text('Enviar'),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            const SizedBox(height: 20),
            Text(
              _response,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
