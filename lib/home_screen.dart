import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch/about.dart';
import 'package:stopwatch/stopwatch.dart';
import 'package:stopwatch/timer.dart';

class HomeScreen extends StatefulWidget {

  final String name;
  final String email;

  const HomeScreen({super.key, required this.name, required this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late PageController _pageController;


  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello ${widget.name}'),
        ),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              StopWatch(name: widget.name, email: widget.email),
              CountdownTimer(),
              About(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
            selectedIndex: _currentIndex,
            onItemSelected: (index) {
              _pageController.jumpToPage(index);
            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(icon: Icon(Icons.timelapse), title: Text('Stopwatch')),
              BottomNavyBarItem(icon: Icon(Icons.timer), title: Text('Timer')),
              BottomNavyBarItem(icon: Icon(Icons.info), title: Text('About')),
            ]
        ),
      ),
    );
  }
}