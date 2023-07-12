import 'package:bioskop/film.dart';
import 'package:flutter/material.dart';
//import 'package:uts/film.dart';



void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bioskop Ciputra"),
      ),
      body: Column(
        children: [
          const TextField(
            // obscureText: true,
            decoration: InputDecoration(labelText: 'Nama'),
          ),
          const TextField(
            // obscureText: true,
            decoration: InputDecoration(labelText: 'Gender'),
          ),
          const TextField(
            // obscureText: true,
            decoration: InputDecoration(labelText: 'Ruangan'),
          ),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(labelText: 'NIK'),
          ),
          const SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            child: const Text('Next'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Film()),
              );
            },
          ),
        ],
      ),
    );
  }
}
