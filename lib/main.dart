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
  Random random = Random();
  late int numberToBeGuessed = random.nextInt(100) + 1;
  int? choice;
  bool guessed = false;
  String? error;
  String buttonText = 'Ghiceste!';
  String helpingText = '';
  TextEditingController controller = TextEditingController();

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
                if (!guessed)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      helpingText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20, color: Colors.blueGrey),
                    ),
                  ),
                TextField(
                  controller: controller,
                  enabled: !guessed,
                  keyboardType: TextInputType.number,
                  onChanged: (String value) {
                    setState(() {
                      if (int.tryParse(value) != null) {
                        error = null;
                        choice = int.parse(value);
                      } else {
                        error = 'Number introduced is not valid';
                        choice = null;
                      }
                    });
                  },
                  decoration: InputDecoration(hintText: 'Introduce your number here!', errorText: error),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (choice != null && guessed == false) {
                          if (choice == numberToBeGuessed) {
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
                            controller.clear();
                            guessed = true;
                            buttonText = 'Try again!';
                          } else if (choice! < numberToBeGuessed) {
                            helpingText = 'You Tried $choice. Try higher!';
                          } else {
                            helpingText = 'You Tried $choice. Try lower!';
                          }
                        } else if (guessed == true) {
                          guessed = false;
                          numberToBeGuessed = random.nextInt(100) + 1;
                          buttonText = 'Guess!';
                          helpingText = '';
                        }
                      });
                    },
                    child: Text(buttonText)),
              ],
            ),
          ),
        ));
  }
}
