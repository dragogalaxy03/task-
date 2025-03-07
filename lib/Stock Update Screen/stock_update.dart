import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:taskcard/Stock%20Update%20Screen/stock_update_card.dart';

class StockUpdateScreen extends StatelessWidget {
  final List<StockUpdate> stockUpdates = [
    StockUpdate("John Doe", "MacBook Pro 16-inch", "10 Mar 2025", -15, 50, 35),
    StockUpdate("Emily Smith", "Samsung Galaxy S23", "12 Mar 2025", 20, 40, 60),
    StockUpdate("Michael Johnson", "Sony WH-1000XM5 Headphones", "15 Mar 2025", 10, 25, 35),
    StockUpdate("Sarah Lee", "Dell XPS 13 Laptop", "18 Mar 2025", -5, 20, 15),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stock Update")),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: stockUpdates.length,
        itemBuilder: (context, index) {
          return StockUpdateCard(stockUpdates[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
      ),
    );
  }
}

class StockUpdate {
  final String name;
  final String product;
  final String date;
  final int updated;
  final int previous;
  final int total;

  StockUpdate(this.name, this.product, this.date, this.updated, this.previous, this.total);
}
