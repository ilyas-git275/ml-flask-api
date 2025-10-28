import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DiabetesPredictionPage extends StatefulWidget {
  const DiabetesPredictionPage({Key? key}) : super(key: key);

  @override
  State<DiabetesPredictionPage> createState() => _DiabetesPredictionPageState();
}

class _DiabetesPredictionPageState extends State<DiabetesPredictionPage> {
  double? prediction;
  bool isLoading = false;

  Future<void> predict() async {
    setState(() => isLoading = true);

    final url = Uri.parse(
      'http://10.47.218.198:5000/predict',
    ); // or your ngrok URL
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'features': [
          0.038075906,
          0.05068012,
          0.061696206,
          0.021872355,
          0.044451213,
          0.17055523,
          0.04695544,
          0.105,
          0.097,
          0.016,
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        prediction = data['prediction'][0];
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
      throw Exception('Failed to get prediction');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Diabetes Predictor')),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: predict,
                    child: const Text('Get Prediction'),
                  ),
                  if (prediction != null)
                    Text(
                      'Prediction: ${prediction!.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18),
                    ),
                ],
              ),
      ),
    );
  }
}
