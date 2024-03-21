import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // bool isPlay = true;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stop Watch'),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xff0395eb),
                width: 4,
              ),
            ),
            child: const Text(
              '00:00:00:000',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.play_arrow,
                  size: 48,
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.stop,
                    size: 48,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.restart_alt_sharp,
                    size: 48,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
