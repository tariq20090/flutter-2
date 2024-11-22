import 'package:flutter/material.dart';
class ProductDetailsPage extends StatelessWidget {
  final String productName;

  const ProductDetailsPage({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            productName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "\$10.99",
            style: TextStyle(fontSize: 20, color: Colors.green),
          ),
          const SizedBox(height: 20),
          const Text(
            "Product Reviews",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Assuming 5 reviews
              itemBuilder: (context, index) {
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      "assets/images/review${index + 1}.jpg", // Example images for reviews
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text("Review ${index + 1}"),
                  subtitle: const Text("Excellent product, really helped me!"),
                  trailing: const Icon(Icons.star, color: Colors.amber),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
