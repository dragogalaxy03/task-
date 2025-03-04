// import 'package:flutter/material.dart';
// // import 'package:loqal_timetracker/components/login_custom_button.dart';
// // import 'package:loqal_timetracker/ui/colors/app_color.dart';
// // import 'package:loqal_timetracker/ui/dashboard/autoscroll_activity_screen.dart';
// //
// // import '../../../models/common_activity/common_activity.dart';
//
// class BeatPlanningScreen extends StatefulWidget {
//   const BeatPlanningScreen({super.key});
//
//   @override
//   _BeatPlanningScreenState createState() => _BeatPlanningScreenState();
// }
//
// class _BeatPlanningScreenState extends State<BeatPlanningScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   List<Map<String, dynamic>> beats = [
//     {"name": "Dwarka Mor, New Delhi, Near Metro Station", "checkedIn": true, "checkinTime": "10:30 AM", "date": "2024-02-28", "userImage": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuNhTZJTtkR6b-ADMhmzPvVwaLuLdz273wvQ&s"},
//     {"name": "Sadar Bazar, Central Delhi, Opposite Market", "checkedIn": false, "checkinTime": null, "date": null, "userImage": null},
//     {"name": "Laxmi Nagar, East Delhi, Close to Red Light", "checkedIn": true, "checkinTime": "11:15 AM", "date": "2024-02-28", "userImage": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuNhTZJTtkR6b-ADMhmzPvVwaLuLdz273wvQ&s"},
//     {"name": "Tilak Nagar, West Delhi, Next to Gurudwara", "checkedIn": false, "checkinTime": null, "date": null, "userImage": null},
//     {"name": "Connaught Place, Central Delhi, Near Palika Bazaar", "checkedIn": false, "checkinTime": null, "date": null, "userImage": null},
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   String _getCurrentTime() {
//     return TimeOfDay.now().format(context);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     int totalCount = beats.length;
//     int visitedCount = beats.where((beat) => beat["checkedIn"]).length;
//     int remainingCount = totalCount - visitedCount;
//
//     return Scaffold(
//       backgroundColor: AppColors.greyBackgrond,
//       appBar: AppBar(title: const Text("Beat Planning")),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Card(
//           // color: AppColors.lightgrey,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           child: Column(
//             children: [
//               TabBar(
//                 controller: _tabController,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.black54,
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 indicator:  BoxDecoration(
//                   color: AppColors.mainappColor,
//                   borderRadius: const BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
//                 ),
//                 tabs: [
//                   _buildTab("Total", totalCount),
//                   _buildTab("Visited", visitedCount),
//                   _buildTab("Remaining", remainingCount),
//                 ],
//               ),
//               Expanded(
//                 child: TabBarView(
//                   controller: _tabController,
//                   children: [
//                     _buildBeatList(beats), // Pass the full list
//                     _buildBeatList(beats, filterCheckedIn: true), // Pass full list, filter in the function
//                     _buildBeatList(beats, filterCheckedIn: false),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTab(String title, int count) {
//     return Tab(
//       height: 55,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
//           const SizedBox(height: 2),
//           Text("$count", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }
//   Widget _buildBeatList(List<Map<String, dynamic>> beats, {bool? filterCheckedIn}) {
//     List<Map<String, dynamic>> displayedBeats = beats;
//
//     if (filterCheckedIn != null) {
//       displayedBeats = beats.where((beat) => beat["checkedIn"] == filterCheckedIn).toList();
//     }
//
//     return ListView.builder(
//       padding: const EdgeInsets.all(8),
//       itemCount: displayedBeats.length,
//       itemBuilder: (context, index) {
//         var beat = displayedBeats[index];
//
//         // Find the correct index in the main beats list
//         int mainListIndex = beats.indexOf(beat);
//
//         return Card(
//           color: Colors.white,
//           elevation: 2,
//           margin: const EdgeInsets.symmetric(vertical: 6),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           child: Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     const Icon(Icons.location_on, color: Colors.red),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         beat["name"],
//                         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                         overflow: TextOverflow.visible,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 if (beat["checkedIn"])
//                   Container(
//                     padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
//                     decoration: BoxDecoration(
//                       color: Colors.lightGreen.shade100,
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(color: Colors.green),
//                     ),
//                     child: Text(
//                       "Checked in at: ${beat["checkinTime"]}",
//                       style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
//                     ),
//                   )
//                 else
//                   // _checkInButton(),
//
//                 if (beat["checkedIn"]) ...[
//                   const SizedBox(height: 10),
//                   AutoScrollContainer(
//                     activity: Activity(date: "2025-03-01", todo: "5", order: "10", stock: "3"),
//                     usermodel: null,
//                   ),
//                   const SizedBox(height: 10),
//
//                   if (beat.containsKey("checkoutTime"))
//                     Container(
//                       padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
//                       decoration: BoxDecoration(
//                         color: Colors.red.shade100,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(color: Colors.red),
//                       ),
//                       child: Text(
//                         "Checked out at: ${beat["checkoutTime"]}",
//                         style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
//                       ),
//                     )
//                   else
//                     _checkOutButton(mainListIndex), // Pass the correct index
//                 ],
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//
//
//   Widget _checkOutButton(int index) {
//     return CustomButton(
//       title: "Check-out",
//       onTap: () {
//         setState(() {
//           beats[index]["checkoutTime"] = _getCurrentTime();
//         });
//       },
//       borderRadius: 8,
//       textColor: Colors.red,
//       color: Colors.red.shade600,
//       isOutlined: true,
//       height: 38,
//       suffixIcon: const Icon(Icons.logout, color: Colors.red, size: 18),
//     );
//   }
//
//   Widget _checkInButton() {
//     return CustomButton(
//       title: "Check-in",
//       onTap: (){},
//       borderRadius: 8,
//       color: Colors.green.shade600,
//       height: 38,
//       suffixIcon: const Icon(Icons.login,color: Colors.white,size: 18,),
//     );
//   }
//
// }