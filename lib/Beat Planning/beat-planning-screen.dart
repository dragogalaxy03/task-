import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class BeatPlanningScreen extends StatefulWidget {
  const BeatPlanningScreen({super.key});

  @override
  _BeatPlanningScreenState createState() => _BeatPlanningScreenState();
}

class _BeatPlanningScreenState extends State<BeatPlanningScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Map<String, dynamic>> beats = [
    {"name": "Dwarka Mor, New Delhi, Near Metro Station", "checkedIn": true, "checkinTime": "10:30 AM", "date": "2025-03-01", "tasks": 5, "orders": 10, "pending": 3, "userName": "Arjun"},
    {"name": "Sadar Bazar, Central Delhi, Opposite Market", "checkedIn": false, "checkinTime": null, "date": null, "tasks": null, "orders": null, "pending": null, "userName": ""},
    {"name": "Laxmi Nagar, East Delhi, Close to Red Light", "checkedIn": true, "checkinTime": "11:15 AM", "date": "2025-03-01", "tasks": 8, "orders": 15, "pending": 4, "userName": "Karan"},
    {"name": "Tilak Nagar, West Delhi, Next to Gurudwara", "checkedIn": false, "checkinTime": null, "date": null, "tasks": null, "orders": null, "pending": null, "userName": ""},
    {"name": "Connaught Place, Central Delhi, Near Palika Bazaar", "checkedIn": false, "checkinTime": null, "date": null, "tasks": null, "orders": null, "pending": null, "userName": ""},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Beat Planning"),
      ),
      body: Column(
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.black12, // Soft shadow
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            margin: const EdgeInsets.all(8), // Adds spacing around the container
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8), // More balanced padding
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black54,
              indicatorColor: Colors.blue,
              indicatorWeight: 3, // Thicker indicator for better visibility
              indicatorPadding: EdgeInsets.symmetric(horizontal: 16), // More padding for the indicator
              tabs: [
                Tab(
                  icon: const Icon(Icons.list, size: 24),
                  text: "Total (${beats.length})",
                ),
                Tab(
                  icon: const Icon(Icons.check_circle, size: 24),
                  text: "Visited (${beats.where((beat) => beat["checkedIn"] == true).length})",
                ),
                Tab(
                  icon: const Icon(Icons.pending, size: 24),
                  text: "Remaining (${beats.where((beat) => beat["checkedIn"] == false).length})",
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildBeatList(beats),
                _buildBeatList(beats.where((beat) => beat["checkedIn"] == true).toList()),
                _buildBeatList(beats.where((beat) => beat["checkedIn"] == false).toList()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBeatList(List<Map<String, dynamic>> beatList) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: beatList.length,
        itemBuilder: (context, index) {
          var beat = beatList[index];
          return FadeInUp(
            duration: Duration(milliseconds: 500 + (index * 100)),
            child: Card(
              color: Colors.white,
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoRow(Icons.person, beat["userName"] ?? "-", isBold: true),
                        _infoRow(Icons.calendar_today, beat["date"] ?? "-"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.red),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            beat["name"],
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (beat["checkedIn"]) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.green)),
                        child: Text("Checked in at: ${beat["checkinTime"]}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _infoRow(Icons.description, "${beat["tasks"]} Tasks"),
                            _infoRow(Icons.shopping_cart, "${beat["orders"]} Orders"),
                            _infoRow(Icons.pending_actions, "${beat["pending"]} Pending"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      _animatedButton("Check-out", Colors.red.shade900, Icons.logout),
                    ] else ...[
                      _animatedButton("Check-in", Colors.blue.shade700, Icons.login),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _infoRow(IconData icon, String text, {bool isBold = false}) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.blueGrey),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal, // Bold if true
          ),
        ),
      ],
    );
  }


  Widget _animatedButton(String label, Color color, IconData icon) {
    return SizedBox(
      height: MediaQuery.of(context).size.height/22,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        icon: Icon(icon, color: Colors.white, size: 16,),
        label: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
