import 'dart:async';
import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget{
  final String name;
  final String email;

  const StopWatch({Key? key, required this.name, required this.email}) : super(key: key);

  @override
  State createState() => StopWatchState();
}

class StopWatchState extends State<StopWatch> {
  bool isTicking = true;
  int seconds = 0;
  late Timer timer;
  int milliseconds = 0;
  final laps = <int>[];
  final itemHeight = 60.0;
  final scrollController = ScrollController();

  void _onTick(Timer time) {
    setState(() {
      milliseconds += 100;
    });
  }

  //String _secondsString() => seconds == 1 ? 'second' : 'seconds';
  String _secondsString(int milliseconds) {
    final seconds = milliseconds / 1000;
    return '$seconds seconds';
  }

  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 100), _onTick);

    setState(() {
      isTicking = true;
      laps.clear();
    });
  }

  void _stopTimer() {
    timer.cancel();

    setState(() {
      isTicking = false;
    });
  }

  void _resetTimer() {
    setState(() {
      milliseconds = 0;
    });
  }

  void _lap() {
    setState(() {
      laps.add(milliseconds);
      _resetTimer();
    });

    scrollController.animateTo(
        itemHeight * laps.length,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn
    );
  }

  Widget build(BuildContext) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(child: buildCounter(context)),
          Expanded(child: _buildLapDisplay())
        ],
      )
    );
  }

  Widget buildCounter(BuildContext context) {
    return Container(
      color: Theme
          .of(context)
          .primaryColor,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                'Lap ${laps.length + 1}',
                style: Theme
                    .of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: Colors.white)
            ),
            Text(
                _secondsString(milliseconds),
                style: Theme
                    .of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white)
            ),
            SizedBox(width: 20),
            buildControls(),
          ]
      ),
    );
  }

  Widget buildControls() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => _startTimer(),
                child: Text('Start'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white),
                ),
              ),
              SizedBox(width: 20),
              TextButton(
                onPressed: () => _stopTimer(),
                child: Text('Stop'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.red),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white),
                ),
              ),
              SizedBox(width: 20),
              TextButton(
                onPressed: isTicking ? _lap : null,
                child: Text('Lap'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.purple),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white),
                ),
              ),
            ],
    );
  }

  Widget _buildLapDisplay() {
    return Scrollbar(
      child: ListView.builder(
        controller: scrollController,
        itemExtent: itemHeight,
        itemCount: laps.length,
        itemBuilder: (context, index) {
          final milliseconds = laps[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 50),
            title: Text ('Lap ${index + 1}'),
            trailing:  Text(_secondsString(milliseconds)),
          );
        },
      ),
    );
  }
}