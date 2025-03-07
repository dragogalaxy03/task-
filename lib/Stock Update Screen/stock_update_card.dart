import 'package:flutter/material.dart';
import 'package:taskcard/Stock%20Update%20Screen/stock_update.dart';
class StockUpdateCard extends StatelessWidget {
  final StockUpdate stockUpdate;
  const StockUpdateCard(this.stockUpdate, {super.key});

  @override
  Widget build(BuildContext context) {
    bool isNegative = stockUpdate.updated < 0;
    return Card(
      color: isNegative ? Colors.red.shade50 : Colors.green.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person, size: 18, color: Colors.black54),
                    const SizedBox(width: 5),
                    Text(stockUpdate.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 18, color: Colors.black54),
                    const SizedBox(width: 5),
                    Text(stockUpdate.date, style: const TextStyle(color: Colors.black54)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 5),
            Text(
              stockUpdate.product,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Divider(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Previous\n${stockUpdate.previous} Units", textAlign: TextAlign.center),
                Text(
                  "Updated\n${stockUpdate.updated > 0 ? '+' : ''}${stockUpdate.updated} Units",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isNegative ? Colors.red : Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text("Total Stock\n${stockUpdate.total} Units", textAlign: TextAlign.center),
              ],
            ),
          ],
        ),
      ),
    );
  }
}