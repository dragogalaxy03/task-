import 'package:flutter/material.dart';

class Order {
  final String orderId;
  final DateTime date;
  final String address;
  final double totalPayment;

  Order({
    required this.orderId,
    required this.date,
    required this.address,
    required this.totalPayment,
  });
}

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order> orders = [
    Order(
      orderId: "#121211231231",
      date: DateTime(2025, 2, 25, 22, 0),
      address: "User 2nd Floor, WZC 21-22, Dwarka Mor, New Delhi - 110075",
      totalPayment: 15000.0,
    ),
    Order(
      orderId: "#121211231232",
      date: DateTime(2025, 3, 1, 14, 30),
      address: "B-45, Connaught Place, New Delhi - 110001",
      totalPayment: 18000.0,
    ),
    Order(
      orderId: "#121211231233",
      date: DateTime(2025, 3, 5, 16, 15),
      address: "Sector 22, Noida, Uttar Pradesh - 201301",
      totalPayment: 12000.0,
    ),
    Order(
      orderId: "#121211231234",
      date: DateTime(2025, 3, 10, 11, 0),
      address: "MG Road, Gurugram, Haryana - 122002",
      totalPayment: 20000.0,
    ),
    Order(
      orderId: "#121211231235",
      date: DateTime(2025, 3, 15, 9, 45),
      address: "Indiranagar, Bengaluru, Karnataka - 560038",
      totalPayment: 22000.0,
    ),
  ];

  List<Order> selectedOrders = [];

  void showOrderBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.grey.shade50,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.8,
                maxChildSize: 0.9,
                minChildSize: 0.5,
                builder: (context, scrollController) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "All Orders",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "-- Search Order --",
                            hintStyle: TextStyle(
                              color: Colors.grey, // Light grey text
                              fontStyle: FontStyle.italic, // Optional for style
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8), // Rounded corners
                              borderSide: BorderSide(color: Colors.grey.shade300), // Light grey border
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.blue), // Highlight color when focused
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Padding inside box
                          ),
                        ),
                        const SizedBox(height: 10,),

                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: orders.length,
                            itemBuilder: (context, index) {
                              final order = orders[index];
                              bool isSelected =
                              selectedOrders.contains(order);

                              return GestureDetector(
                                onTap: () {
                                  setModalState(() {
                                    if (isSelected) {
                                      selectedOrders.remove(order);
                                    } else {
                                      selectedOrders.add(order);
                                    }
                                  });
                                },
                                child:  Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 3,
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  color: isSelected
                                      ? Color(0xFFE4F3E7) // Light green when selected
                                      : Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Order ID: ${order.orderId}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            if (isSelected)
                                              Icon(Icons.check_circle,
                                                  color: Colors.green, size: 24),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_today, size: 14),
                                            SizedBox(width: 5),
                                            Text(
                                              "${order.date.day} ${_getMonth(order.date.month)} ${order.date.year}",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(width: 10),
                                            Icon(Icons.access_time, size: 14),
                                            SizedBox(width: 5),
                                            Text(
                                              "${order.date.hour}:${order.date.minute.toString().padLeft(2, '0')} PM",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start, // Align icon with text
                                          children: [
                                            Icon(Icons.location_on_outlined, size: 16, ), // Increased size slightly for visibility
                                            SizedBox(width: 4), // Add spacing between icon and text
                                            Expanded( // Ensures text wraps within available space
                                              child: Text(
                                                order.address,
                                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                softWrap: true, // Enables text wrapping
                                                overflow: TextOverflow.visible, // Ensures full text is shown
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Total Payment",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                "View Order Details",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            // Payment Container
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Adjusted padding
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFF3D99B), // Background color from your sample
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                alignment: Alignment.center, // Align text centrally
                                                child: Text(
                                                  "₹${order.totalPayment}/-",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.black, // Better contrast
                                                  ),
                                                ),
                                              ),
                                            ),

                                            SizedBox(width: 10), // Space between widgets

                                            // Select Order Button
                                            Expanded(
                                              child: ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.amber.shade700, // Button color
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  padding: EdgeInsets.symmetric(vertical: 12), // Adjust padding
                                                ),
                                                onPressed: () {
                                                  setModalState(() {
                                                    if (isSelected) {
                                                      selectedOrders.remove(order);
                                                    } else {
                                                      selectedOrders.add(order);
                                                    }
                                                  });
                                                },
                                                icon: Icon(Icons.check_circle_outline_outlined, color: Colors.white, size: 20),
                                                label: Text(
                                                  "Select Order",
                                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),


                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  void showSelectedOrders(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Selected Orders"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: selectedOrders
                .map((order) => ListTile(
              title: Text(order.orderId),
              subtitle: Text("₹${order.totalPayment}/-"),
            ))
                .toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  String _getMonth(int month) {
    const months = [
      "", "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Payment")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () => showOrderBottomSheet(context), // Pass context here
                child: Text("Show Orders"),
              ),
            ),
            const SizedBox(height: 20,),
            //---Cards---//
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8), // Padding inside the circle
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 2), // Circular outline
                      ),
                      child: Icon(Icons.filter_alt_outlined, size: 20, color: Colors.black),
                    ),
                    const SizedBox(width: 10,),

                    Container(
                      padding: EdgeInsets.all(8), // Padding inside the circle
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 2), // Circular outline
                      ),
                      child: Icon(Icons.search, size: 20, color: Colors.black),
                    )

                  ],
                )
              ],
            ),
            const SizedBox(height: 10,),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2, // 2 columns
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.7, // Controls the card size
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildCard("14", "Orders", Colors.orange.shade100, Colors.orange),
                _buildCard("10", "Payments", Colors.green.shade100, Colors.green),
                _buildCard("05", "Request", Colors.red.shade100, Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Build cards//
  Widget _buildCard(String count, String title, Color bgColor, Color iconColor) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(2, 4),
          )
        ],
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(  // Prevents overflow by letting it adapt inside the Row
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,  // Prevents taking unnecessary space
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 18,
                  child: Icon(Icons.insert_drive_file_outlined, color: iconColor, size: 16),
                ),
                SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "$count ",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: iconColor,
                        ),
                      ),
                      TextSpan(
                        text: title,
                        style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
           Icon(Icons.arrow_circle_right_outlined, color: iconColor, size: 25,),
        ],
      ),
    );

  }
}