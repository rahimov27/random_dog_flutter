import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:random_image/dogs_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

String? image;

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void getImage() async {
    final Dio dio = Dio();
    final response = await dio.get('https://dog.ceo/api/breeds/image/random');
    final result = DogModel.fromJson(response.data);
    image = result.message;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              image ??
                  "https://images.dog.ceo/breeds/terrier-border/n02093754_6437.jpg",
              height: 300,
              width: 300,
              fit: BoxFit.fill,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
