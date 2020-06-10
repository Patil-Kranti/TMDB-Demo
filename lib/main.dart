import 'package:flutter/material.dart';
import 'package:movie_review/views/MoiveView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MovieView(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.width * 0.75;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Center(child: Text("TMDB Demo")),
        ),
        body: Container(
          width: screenWidth,
          height: screenWidth,
          child: Card(
            elevation: 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Parasite",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                Image.asset(
                  "assets/images/logo.png",
                  width: screenWidth,
                  height: screenHeight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
