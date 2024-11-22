import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItems = [
      const CartItem(
        productName: "Pain Killer",
        productImage: "assets/images/pain_reliever.jpg",
        productPrice: 10.99,
      ),
      const CartItem(
        productName: "Piodine",
        productImage: "assets/images/piodine.jpg",
        productPrice: 59.99,
      ),
    ];

    double subtotal = cartItems.fold(
      0,
      (total, item) => total + item.productPrice,
    );
    double tax = subtotal * 0.08;
    double total = subtotal + tax;

    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ...cartItems,
                  const SizedBox(height: 20),
                ],
              ),
            ),
            // Cart Summary Section
            const Divider(thickness: 1.5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SummaryRow(label: "Subtotal", amount: subtotal),
                  SummaryRow(label: "Tax (8%)", amount: tax),
                  const Divider(thickness: 1),
                  SummaryRow(label: "Total", amount: total, isBold: true),
                  const SizedBox(height: 20),

                  // Payment Method Dropdown
                  const Text(
                    "Select Payment Method",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: "Credit Card", child: Text("Credit Card")),
                      DropdownMenuItem(value: "Debit Card", child: Text("Debit Card")),
                      DropdownMenuItem(value: "Cash on Delivery", child: Text("Cash on Delivery")),
                    ],
                    onChanged: (value) {
                      // Handle payment method change
                    },
                    hint: const Text("Choose a payment method"),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to checkout
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
              child: const Text("Proceed to Checkout"),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem extends StatefulWidget {
  final String productName;
  final String productImage;
  final double productPrice;

  const CartItem({
    super.key,
    required this.productName,
    required this.productImage,
    required this.productPrice,
  });

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 1;

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(widget.productImage, width: 50, height: 50),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.productName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: _decrementQuantity,
                      ),
                      Text("Qty: $quantity"),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _incrementQuantity,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text("\$${(widget.productPrice * quantity).toStringAsFixed(2)}"),
          ],
        ),
      ),
    );
  }
}

class SummaryRow extends StatelessWidget {
  final String label;
  final double amount;
  final bool isBold;

  const SummaryRow({
    super.key,
    required this.label,
    required this.amount,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
