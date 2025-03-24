import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'task_list.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              _buildPage(
                image: "assets/images/step_1.png",
                title: "Easy Time Management",
                description: "With management based on priority and daily tasks, it will give you convenience in managing and determining the tasks that must be done first.",
              ),
              _buildPage(
                image: "assets/images/step_2.png",
                title: "Increase Work Effectiveness",
                description: "Time management and the determination of more important tasks will give your job statistics better and always improve",
              ),
              _buildPage(
                image: "assets/images/step_3.png",
                title: "Reminder Notification",
                description: "The advantage of this application is that it also provides reminders for you so you don't forget to keep doing your assignments well and according to the time you have set",
              ),
            ],
          ),
          
          // Dots indicator
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Row (
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Căn giữa khoảng cách
              children: [
                SmoothPageIndicator(
                  controller: _pageController, // Controller của PageView
                  count: 3, // Số trang
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.blue,
                    dotColor: Colors.grey,
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _pageController.jumpToPage(3); 
                  },
                  child: Text("skip", style: TextStyle(fontSize: 14,color: Colors.blue)),
                ),
              ]
            )
          ),
          
          Positioned(
            bottom: 30,
            left: 16,
            child: Container(
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(50),
                color:Colors.blue
              ),
              child: _currentPage > 0
                ? IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                    onPressed: () {
                      _pageController.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },
                  )
                : Container(),
            )
          ),
          
          Positioned(
            bottom: 30,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                if (_currentPage == 2) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => TaskListScreen()),

                  );
                } else {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 300),   //thời gian chuyển trangtrang
                      curve: Curves.ease);                     // hiệu ứng chuyển trang
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Màu nền
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50), // Bo tròn
                ),
                minimumSize: _currentPage == 0 ? Size(MediaQuery.of(context).size.width - 32, 52): Size(200, 52), // Kích thước nút
              ),
              child: Text(
                _currentPage == 2 ? "Get Started" : "Next",
                style: TextStyle(color: Colors.white), // Màu chữ
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPage({required String image, required String title, required String description}) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 250),
          SizedBox(height: 20),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Color(0xBF000000))
          ),
        ],
      ) 
    );
  }
}
