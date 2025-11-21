import 'package:flutter/material.dart';

class IntroSlide extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isLastPage;
  final VoidCallback onGetStarted;
  final VoidCallback onNext;
  final int currentPage;
  final int totalPages;

  const IntroSlide({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.isLastPage,
    required this.onGetStarted,
    required this.onNext,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.event,
                    size: 80,
                    color: Colors.grey[600],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 40),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),

          // Next Button for first two slides, Get Started for last slide
          if (!isLastPage)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Empty container to balance the row
                Container(),

                // Next Button
                ElevatedButton(
                  onPressed: onNext,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Next'),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 16),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),

          // Get Started Button for last slide
          if (isLastPage)
            Column(
              children: [
                ElevatedButton(
                  onPressed: onGetStarted,
                  child: Text('Get Started'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Slide ${currentPage + 1} of $totalPages',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}