import 'dart:async';
import 'package:flutter/material.dart';
import 'productdetailPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> productNames = [
    "Pain Reliever",
    "Vitamin C",
    "Antibiotic",
    "Allergy Medicine",
    "Heart Medicine",
  ];

  final List<String> productImages = [
    "assets/images/pain_reliever.jpg",
    "assets/images/vitamin_c.jpg",
    "assets/images/antibiotic.jpg",
    "assets/images/allergy_medicine.jpg",
    "assets/images/heart_medicine.jpg",
  ];

  final List<String> adImages = [
    "assets/images/ad1.jpg",
    "assets/images/ad2.jpg",
    "assets/images/ad3.jpg",
  ];

  late PageController _pageController;
  int _currentPage = 0;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);


    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < adImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.pushNamed(context, '/cart');
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MedStore"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductSearchDelegate(productNames),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Mubashir"),
              accountEmail: Text("mubashir@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/user.jpg"),
              ),
            ),
            ListTile(
              title: const Text("Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
            ),
            ListTile(
              title: const Text("Orders"),
              onTap: () {},
            ),
            ListTile(
              title: const Text("Log Out"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("assets/images/user.jpg"),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                "Welcome to Mubashir Medical Store",
                style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.local_hospital, color: Colors.blue, size: 30),
                Icon(Icons.healing, color: Colors.green, size: 30),
                Icon(Icons.vaccines, color: Colors.red, size: 30),
                Icon(Icons.masks, color: Colors.orange, size: 30),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 150.0,
              child: PageView.builder(
                controller: _pageController,
                itemCount: adImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.asset(adImages[index], fit: BoxFit.cover),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true, // To fit within SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemCount: productNames.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                            productName: productNames[index],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                productImages[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  productNames[index],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Text("\$10.99", style: TextStyle(color: Colors.green)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ProductSearchDelegate extends SearchDelegate {
  final List<String> productNames;

  ProductSearchDelegate(this.productNames);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = productNames.where((product) => product.toLowerCase().contains(query.toLowerCase()));
    return ListView(
      children: results.map((result) => ListTile(title: Text(result))).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = productNames.where((product) => product.toLowerCase().startsWith(query.toLowerCase()));
    return ListView(
      children: suggestions.map((suggestion) => ListTile(title: Text(suggestion))).toList(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.account_circle,
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            const Text(
              'User Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Name: Mubashir'),
            const Text('Email: Mubashir@example.com'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged Out')),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
