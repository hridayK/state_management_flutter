import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => Display(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FruitScreen(),
    );
  }
}

class FruitScreen extends StatefulWidget {
  FruitScreen({Key? key}) : super(key: key);

  @override
  State<FruitScreen> createState() => _FruitScreenState();
}

class _FruitScreenState extends State<FruitScreen> {
  var fruitMap = <String, String>{
    "none": "❌",
    "Apple": "🍎",
    "Banana": "🍌",
    "Orange": "🍊"
  };

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("State Management Example"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const FruitButton(fruit: "Apple"),
            const FruitButton(fruit: "Banana"),
            const FruitButton(fruit: "Orange"),
            SizedBox(
              height: deviceHeight * 0.2,
            ),
            Center(
              child: Text(
                fruitMap[Provider.of<Display>(context).fruit]!,
                style: const TextStyle(fontSize: 50),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FruitButton extends StatelessWidget {
  const FruitButton({super.key, required this.fruit});

  final String fruit;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Provider.of<Display>(context, listen: false).changeFruit(fruit);
      },
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.blueAccent),
          foregroundColor: MaterialStatePropertyAll(Colors.white)),
      child: Text(fruit),
    );
  }
}

class Display extends ChangeNotifier {
  String fruit = "none";

  void changeFruit(String newFruit) {
    fruit = newFruit;
    notifyListeners();
  }
}
