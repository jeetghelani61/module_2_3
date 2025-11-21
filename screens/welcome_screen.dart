import 'dart:async';

import 'package:flutter/material.dart';
import 'auth_screen.dart';
import '../widgets/intro_slide.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToIntro();
  }

  void _navigateToIntro() async {
    // 5 second splash screen
    await Future.delayed(Duration(seconds: 5));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => IntroSlider()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event,
              size: 80,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              'EventBuzz',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Loading...',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IntroSlider extends StatefulWidget {
  @override
  _IntroSliderState createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  Timer? _autoNavigateTimer;

  final List<Map<String, String>> introData = [
    {
      'title': 'Discover Amazing Events',
      'description': 'Find and join events that match your interests',
      'image': 'assets/welcome1.png',
    },
    {
      'title': 'Easy Registration',
      'description': 'Register for events with just a few taps',
      'image': 'assets/welcome2.png',
    },
    {
      'title': 'Manage Your Events',
      'description': 'Keep track of all your registered events',
      'image': 'assets/welcome3.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Start auto-navigation check
    _startAutoNavigationCheck();
  }

  void _startAutoNavigationCheck() {
    _autoNavigateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_currentPage == introData.length - 1) {
        // If on last slide, navigate after 1 second
        timer.cancel();
        _navigateToAuth();
      }
    });
  }

  void _navigateToAuth() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthScreen()),
      );
    }
  }

  void _manualGetStarted() {
    _autoNavigateTimer?.cancel();
    _navigateToAuth();
  }

  void _nextSlide() {
    if (_currentPage < introData.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _autoNavigateTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: introData.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });

              // Reset timer when page changes
              _autoNavigateTimer?.cancel();
              if (page == introData.length - 1) {
                // If landed on last page, start 1-second timer
                Future.delayed(Duration(seconds: 1), () {
                  if (mounted && _currentPage == introData.length - 1) {
                    _navigateToAuth();
                  }
                });
              }
            },
            itemBuilder: (context, index) {
              return IntroSlide(
                title: introData[index]['title']!,
                description: introData[index]['description']!,
                imagePath: introData[index]['image']!,
                isLastPage: index == introData.length - 1,
                onGetStarted: _manualGetStarted,
                onNext: _nextSlide,
                currentPage: index,
                totalPages: introData.length,
              );
            },
          ),

          // Page Indicator
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                introData.length,
                    (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ),

          // Auto-navigation indicator on last page
          if (_currentPage == introData.length - 1)
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Text(
                    'Auto redirecting in 1 second...',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: 100,
                    height: 3,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Skip button (shown on all pages except last)
          if (_currentPage < introData.length - 1)
            Positioned(
              top: 50,
              right: 20,
              child: TextButton(
                onPressed: _manualGetStarted,
                child: Text(
                  'SKIP',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}