import 'package:flutter/material.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

int exscore = 0;
int oscore = 0;
int check = 0  ;
List<String> displayXO = ['', '', '', '', '', '', '', '', ''];

bool onturn = true; // the firstplayer is x ;

var mystyle = TextStyle(color: Colors.white, fontSize: 25);

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800], //พื้นหลัง สีเทา
      body: Column(
        children: [
          Expanded(
              child: Container(
                color: Colors.black,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'player X ',
                              style: mystyle,
                            ),
                            Text(
                              exscore.toString(),
                              style: mystyle,
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'player O ',
                              style: mystyle,
                            ),
                            Text(
                              oscore.toString(),
                              style: mystyle,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Expanded(
            flex: 1,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                        child: Text(
                          displayXO[index],
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
              child: Container(
                color: Colors.black,
                child: Center(
                  child: Column(
                    children: [
                      Text('TIC TAC TOE', style:TextStyle(color: Colors.white, fontSize: 25),),
                      SizedBox(height: 60,),
                      Text('BY Sanhanut Sakulma !! ',style: TextStyle(color: Colors.white, fontSize: 25))
                    ],
                  ),
                ),
              ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => IntroScreen()),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 40, right: 40, bottom: 60),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(30),
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Back',

                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (onturn && displayXO[index] == '') {
        displayXO[index] = 'X';
        check++;
      } else if (!onturn && displayXO[index] == '') {
        displayXO[index] = 'O';
        check++;
      }
      onturn = !onturn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      _showDialog(displayXO[0]);
    }
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      _showDialog(displayXO[3]);
    }
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      _showDialog(displayXO[6]);
    }
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      _showDialog(displayXO[0]);
    }
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      _showDialog(displayXO[1]);
    }
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      _showDialog(displayXO[2]);
    }
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      _showDialog(displayXO[0]);
    }
    if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != '') {
      _showDialog(displayXO[2]);
    }

    else if (check == 9){
      _showDrawDialog();
    }
  }

  void _showDialog(String TTT) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Winner' + " " + TTT),
            actions: <Widget>[
              TextButton(onPressed: (){_Clear();Navigator.of(context).pop();}, child: Text('Play Again!'))
            ],
          );
        });

    if (TTT == 'X') {
      exscore++;
    } else if (TTT == 'O') {
      oscore++;
    }
  }
  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Draw'),
            actions: <Widget>[
              TextButton(onPressed: (){_Clear();Navigator.of(context).pop();}, child: Text('Play Again!'))
            ],
          );
        });

  }

  void _Clear() {
    setState(() {
      for(int i = 0;i<9;i++){
        displayXO[i] = '' ;
      }
    });
    check = 0 ;
  }
}
