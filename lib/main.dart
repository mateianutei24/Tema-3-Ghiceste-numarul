import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Random _random = Random();
  late int _numberToBeGuessed = _random.nextInt(100) + 1;
  int? _choice;
  bool _guessed = false;
  String? _error;
  String _buttonText = 'Ghiceste!';
  String _helpingText = '';
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text('Guess my number')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Im thinking of a number between 1 and 100',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 45,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Its your turn to guess my number!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                if (!_guessed)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _helpingText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20, color: Colors.blueGrey),
                    ),
                  ),
                TextField(
                  controller: _controller,
                  enabled: !_guessed,
                  keyboardType: TextInputType.number,
                  onChanged: (String value) {
                    setState(() {
                      if (int.tryParse(value) != null) {
                        _error = null;
                        _choice = int.parse(value);
                      } else {
                        _error = 'Number introduced is not valid';
                        _choice = null;
                      }
                    });
                  },
                  decoration: InputDecoration(hintText: 'Introduce your number here!', errorText: _error),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_choice != null && _guessed == false) {
                          if (_choice == _numberToBeGuessed) {
                            showDialog(
                              context: context,
                              builder: (BuildContext ctx) => AlertDialog(
                                title: const Text('You won!'),
                                content: const Text(
                                  'You guessed the number correctly! Well done!',
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Container(
                                      color: Colors.blue,
                                      padding: const EdgeInsets.all(14),
                                      child: const Text(
                                        'okay',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                            _controller.clear();
                            _guessed = true;
                            _buttonText = 'Try again!';
                          } else if (_choice! < _numberToBeGuessed) {
                            _helpingText = 'You Tried $_choice. Try higher!';
                          } else {
                            _helpingText = 'You Tried $_choice. Try lower!';
                          }
                        } else if (_guessed == true) {
                          _guessed = false;
                          _numberToBeGuessed = _random.nextInt(100) + 1;
                          _buttonText = 'Guess!';
                          _helpingText = '';
                        }
                      });
                    },
                    child: Text(_buttonText)),
              ],
            ),
          ),
        ));
  }
}
