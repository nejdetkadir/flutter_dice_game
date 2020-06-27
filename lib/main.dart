import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentRoundScore = 0;
  int currentPlayer = 0;
  List<int> scores = [0,0];
  int dice = 1;

  void rollDice() {
    dice = (new Random()).nextInt(6)+1;
    if (dice != 1) {
      setState(() {
        currentRoundScore += dice;
      });
    } else {
      setState(() {
        currentRoundScore = 0;
        changePlayer();
      });
    }
  }

  void changePlayer() {
    currentPlayer == 0 ? currentPlayer = 1 : currentPlayer = 0;
    currentRoundScore=0;
  }

  @override
  Widget build(BuildContext context) {
    var shownWidget = <Widget>[
      Container(
        margin: EdgeInsets.only(bottom: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
                Icons.arrow_forward
            ),
            Text(
                "Player ${currentPlayer+1}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40
                ),
            ),
            Icon(
              Icons.arrow_back
            )
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "CURRENT : ${currentRoundScore}"
            )
          ],
        ),
      ),
      Image.asset(
        "images/dice-${dice}.png",
        width: 120,
        height: 120,),
      Container(
        margin: EdgeInsets.only(top: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              color: Colors.white,
              onPressed: () {
                setState(() {
                  rollDice();
                });
              },
              child: Text(
                  "ROLL DICE"
              ),
            ),
            MaterialButton(
              color: Colors.white,
              onPressed: () {
                setState(() {
                  scores[currentPlayer] += currentRoundScore;
                  setState(() {
                    if (scores[currentPlayer] >= 100) {
                      Fluttertoast.showToast(
                          msg: "PLAYER ${currentPlayer+1} WINNER AND THE GAME WAS RESTARTED",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 15.0
                      );
                      currentPlayer = 1;
                      currentRoundScore = 0;
                      scores = [0,0];
                    }
                  });
                  changePlayer();
                });
              },
              child: Text(
                  "HOLD"
              ),
            )
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 80),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "PLAYER 1"
            ),
            Text(
              "PLAYER 2"
            )
          ],
        ),
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "${scores[0]}",
              style: TextStyle(
                fontSize: 20
              ),
            ),
            Text(
              "${scores[1]}",
              style: TextStyle(
                fontSize: 20
              ),
            )
          ],
        ),
      )
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 38,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.circular(80.0)),
                    color: Colors.orange,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: shownWidget,
                  )
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          )
        ],
    ));
  }
}
