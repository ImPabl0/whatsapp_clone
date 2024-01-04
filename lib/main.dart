// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import 'package:whatsapp_clone/style/colors.dart';

void main() {
  runApp(const ZapZap());
}

Color _mainColor = const Color.fromARGB(255, 38, 53, 63);

class ZapZap extends StatelessWidget {
  const ZapZap({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZapZap',
      color: _mainColor,
      home: const ZapHome(),
    );
  }
}

class ZapHome extends StatefulWidget {
  const ZapHome({super.key});

  @override
  State<ZapHome> createState() => _ZapHomeState();
}

class _ZapHomeState extends State<ZapHome> {
  double _sliderSize = 100;
  final GlobalKey _communityKey = GlobalKey();
  final GlobalKey _chatKey = GlobalKey();
  final GlobalKey _statusKey = GlobalKey();
  final GlobalKey _callKey = GlobalKey();
  final GlobalKey _sliderBoxKey = GlobalKey();

  int _selectedIndex = 1;

  double _distanceFromLeft = 0;

  void calculateDistanceFromLeft() {
    double result = 0;
    if (_selectedIndex == 0) {
      _distanceFromLeft = result;
      return;
    }
    for (var i = 0; i < _selectedIndex; i++) {
      result += orderedKeys[i].currentContext!.size!.width;
    }
    _distanceFromLeft = result;
  }

  void _changeIndex(int index) {
    setState(() {
      _sliderSize = orderedKeys[index].currentContext!.size!.width;
      _selectedIndex = index;
      calculateDistanceFromLeft();
    });
  }

  final int _animationDuration = 200;

  List<GlobalKey> get orderedKeys =>
      [_communityKey, _chatKey, _statusKey, _callKey];
  final PageController _pageController = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _mainColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: _mainColor),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Row(
                children: [
                  const Expanded(
                      child: SizedBox(
                    height: 27,
                    child: Text(
                      "WhatsApp",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )),
                  SizedBox(
                    width: 110,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 27,
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 27,
                        ),
                        Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 27,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              width: double.infinity,
              color: _mainColor,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      key: _communityKey,
                      child: CardTop(
                        notificationAmount: 0,
                        onTap: () => _changeIndex(0),
                        title: "",
                        icon: Icons.group,
                        isSelected: _selectedIndex == 0,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Container(
                      key: _chatKey,
                      child: CardTop(
                        notificationAmount: 29,
                        onTap: () => _changeIndex(1),
                        title: "Chats",
                        isSelected: _selectedIndex == 1,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Container(
                      key: _statusKey,
                      child: CardTop(
                          onTap: () => _changeIndex(2),
                          notificationAmount: 0,
                          isSelected: _selectedIndex == 2,
                          title: "Updates"),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Container(
                      key: _callKey,
                      child: CardTop(
                          onTap: () => _changeIndex(3),
                          notificationAmount: 0,
                          isSelected: _selectedIndex == 3,
                          title: "Calls"),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              key: _sliderBoxKey,
              width: double.infinity,
              height: 5,
              color: _mainColor,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: _animationDuration),
                    left: _distanceFromLeft,
                    curve: Curves.decelerate,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: _animationDuration),
                      curve: Curves.decelerate,
                      width: _sliderSize,
                      height: 3,
                      color: selectedColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              decoration: const BoxDecoration(color: Color(0xFF121b22)),
              child: PageView(
                onPageChanged: (index) => _changeIndex(index),
                controller: _pageController,
                children: const [
                  Center(
                    child: Text("Community"),
                  ),
                  Center(
                    child: Text("Chat"),
                  ),
                  Center(
                    child: Text("Status"),
                  ),
                  Center(
                    child: Text("Call"),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class CardTop extends StatelessWidget {
  String title;
  int notificationAmount;
  bool isSelected;
  IconData? icon;
  void Function() onTap;
  CardTop({
    Key? key,
    required this.title,
    required this.notificationAmount,
    this.isSelected = false,
    this.icon,
    required this.onTap,
  }) : super(key: key);

  bool get showText => !(icon != null && title.isEmpty);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null
                ? Icon(
                    icon,
                    color: isSelected ? selectedColor : unselectedColor,
                  )
                : Container(),
            showText
                ? Text(
                    title,
                    style: TextStyle(
                        color: isSelected ? selectedColor : unselectedColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  )
                : Container(),
            Visibility(
              visible: notificationAmount != 0,
              child: Container(
                margin: const EdgeInsets.only(left: 5),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? selectedColor : unselectedColor),
                child: Text(
                  notificationAmount.toString(),
                  style: TextStyle(
                      color: _mainColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
