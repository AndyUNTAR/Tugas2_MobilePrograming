import 'package:flutter/material.dart';
import 'dart:async';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});


  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  final _timeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int seconds = 0;
  late Timer timer;
  bool isTicking = true;

  void _onTick(Timer time) {
    if (seconds != 0){
      setState(() {
        seconds--;
      });
    }
    else {
      timer.cancel();
      setState(() {
        isTicking = false;
      });
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
              contentPadding: const EdgeInsets.all(20.0),
              content: const Text('Your time\'s up!'),
            ),
      );
    }
    return;
  }

  void _startTimer() {
    if (seconds == 0)
      seconds = (int.tryParse(_timeController.text) ?? 0);
    if (seconds != 0){
      timer = Timer.periodic(Duration(seconds: 1), _onTick);
      setState(() {
      isTicking = true;
      });
    }
  }

  void _stopTimer() {
    timer.cancel();

    setState(() {
      isTicking = false;
    });
  }

  void _resetTimer() {
    setState(() {
      seconds = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            _input(context),
            _timerDisplay(context),
          ],
        )
    );
  }

  Widget _input(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _timeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter a number'),
              validator: (text) {
                if (text!.isEmpty){
                  return 'Enter a number in seconds!';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){
                    _startTimer();
                  },
                  child: Text('Start'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.green),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: (){
                    _stopTimer();
                  },
                  child: Text('Stop'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.red),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: (){
                    _resetTimer();
                  },
                  child: Text('Reset'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.purple),
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _timerDisplay(BuildContext context){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$seconds',
            style: TextStyle(fontSize: 150),
          )
        ],
      ),
    );
  }

}