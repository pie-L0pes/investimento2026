import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  double investimento = 0.0;
  double taxa = 0.0;
  double meses = 0.0;
  double total = 0.0;
  double totaljuros = 0.0;

  String resultado = "Valor total sem juros: R\$ 0.00";
  String resultado2 = "Valor total com juros compostos: R\$ 0.00";

  void valorparcela() {
    double taxareal = taxa / 100;

    total = investimento * meses;

    if (taxareal > 0) {
      totaljuros = investimento *
          ((pow(1 + taxareal, meses) - 1) / taxareal) *
          (1 + taxareal);
    } else {
      totaljuros = total;
    }

    setState(() {
      resultado =
          "Valor total sem juros: R\$ ${total.toStringAsFixed(2)}";

      resultado2 =
          "Valor total com juros compostos: R\$ ${totaljuros.toStringAsFixed(2)}";
    });

    // 🔥 POPUP COM OS DOIS RESULTADOS
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          "Resultado",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          "$resultado\n$resultado2",
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Widget campo(String label, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6EFE6),
      appBar: AppBar(
        title: const Text(
          "Simulador de Investimentos",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 12, 89, 0),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Investimento mensal:",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            campo("Digite o valor", (value) {
              investimento = double.tryParse(value) ?? 0.0;
            }),

            const SizedBox(height: 10),

            const Text(
              "Número de meses:",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            campo("Quantos meses deseja investir", (value) {
              meses = double.tryParse(value) ?? 0.0;
            }),

            const SizedBox(height: 10),

            const Text(
              "Taxa de juros ao mês (%):",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            campo("Digite a taxa de juros", (value) {
              taxa = double.tryParse(value) ?? 0.0;
            }),

            const SizedBox(height: 20),

            SizedBox(
              width: 180,
              height: 45,
              child: ElevatedButton(
                onPressed: valorparcela,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B2E2B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  "Simular",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // RESULTADO FIXO
            Text(
              resultado,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),

            const SizedBox(height: 10),

            Text(
              resultado2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}