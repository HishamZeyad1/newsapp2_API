import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import '../PageModel.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

import 'home_screen.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late List<PageModel> pages;
  ValueNotifier<int> _pageViewNotifier = ValueNotifier(0);

  void _addPages() {
    pages = <PageModel>[];
    pages.add(PageModel('Welcome',
        '1- Making friends is easy as waving your hand back and forth in easy step',
        Icons.ac_unit, 'assets/images/bg.png'));
    pages.add(PageModel('Alarm',
        '2- Making friends is easy as waving your hand back and forth in easy step',
        Icons.access_alarms, 'assets/images/bg3.png'));
    pages.add(PageModel('Print',
        '3- Making friends is easy as waving your hand back and forth in easy step',
        Icons.map, 'assets/images/bg.png'));
    pages.add(PageModel('Map',
        '4- Making friends is easy as waving your hand back and forth in easy step',
        Icons.ac_unit, 'assets/images/bg4.png'));
  }

  @override
  Widget build(BuildContext context) {
    _addPages();
    return Stack(
      children: <Widget>[
        Scaffold(
          body: PageView.builder(
            // ignore: missing_return
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage(pages[ index ].image),
                          fit: BoxFit.cover,
                        )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.translate(
                        child: Icon(
                          pages[ index ].icon,
                          size: 100,
                          color: Colors.white,
                        ),
                        offset: Offset(0, -50),
                      ),
                      Text(
                        pages[index].title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,

                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 48, right: 48, top: 18),
                        child: Text(
                          pages[ index ].description,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
            itemCount: pages.length,
            onPageChanged: (index) {
              _pageViewNotifier.value = index;
            },

          ),
        ),
        Transform.translate(
          offset: Offset(0, 175),
          child: Align(
            alignment: Alignment.center,
           child: _displayPageIndicators(pages.length),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                color: Colors.red.shade900,
                child: Text(
                  'GET STARTED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 1,
                  ),
                ),
                onPressed: () {
                  // _updateSeen();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomeScreen();
                      },
                    ),
                  );

                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _displayPageIndicators(int length) {
    return PageViewIndicator(
      pageIndexNotifier: _pageViewNotifier,
      length: length,
      normalBuilder: (animationController, index) =>
          Circle(
            size: 8.0,
            color: Colors.grey,
          ),
      highlightedBuilder: (animationController, index) =>
          ScaleTransition(
            scale: CurvedAnimation(
              parent: animationController,
              curve: Curves.ease,
            ),
            child: Circle(
              size: 12.0,
              color: Colors.red,
            ),
          ),
    );
  }

  // void _updateSeen() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool( 'seen' , true);
  // }
}



