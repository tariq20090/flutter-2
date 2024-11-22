import 'package:flutter/material.dart';

class FullScreenSplash extends StatefulWidget {
  const FullScreenSplash({super.key});

  @override
  _FullScreenSplashState createState() => _FullScreenSplashState();
}

class _FullScreenSplashState extends State<FullScreenSplash> {
  @override
  void initState() {
    super.initState();
    _navigateToSplashScreen();
  }

  void _navigateToSplashScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SplashScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (_currentPage < 2) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          }
        },
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  const SplashContent(
                    title: "Welcome to MedStore",
                    description: "Find all your medicines in one place.",
                    image: "assets/images/splash1.jpg",
                  ),
                  const SplashContent(
                    title: "Fast Delivery",
                    description: "Get quick delivery at your doorstep.",
                    image: "assets/images/splash2.jpg",
                  ),
                  SplashContent(
                    title: "Reliable Support",
                    description: "24/7 customer support.",
                    image: "assets/images/splash3.jpg",
                    isLastPage: true,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) => buildDot(index: index)),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot({required int index}) {
    return Container(
      height: 10,
      width: 10,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  final String title, description, image;
  final bool isLastPage;
  final VoidCallback? onPressed;

  const SplashContent({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    this.isLastPage = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 300),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(description, textAlign: TextAlign.center),
          if (isLastPage)
            const SizedBox(height: 20),
          if (isLastPage)
            ElevatedButton(
              onPressed: onPressed,
              child: const Text("Get Started"),
            ),
        ],
      ),
    );
  }
}
