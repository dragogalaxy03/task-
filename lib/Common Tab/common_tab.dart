import 'package:flutter/material.dart';
// import 'package:loqal_timetracker/models/activities_icon_list.dart';
// import 'package:loqal_timetracker/ui/colors/app_color.dart';
// import 'package:loqal_timetracker/ui/dashboard/my_components/common_listview.dart';
// import 'package:loqal_timetracker/ui/dashboard/my_components/common_tab_view.dart';
// import 'package:loqal_timetracker/ui/dashboard/my_components/custom_tab/custom_tab_screen.dart';
// import 'package:loqal_timetracker/ui/dashboard/my_components/location_card_screen_useable.dart';
// import 'package:loqal_timetracker/ui/dashboard/my_components/payment/payment_method_screen.dart';
// import 'package:loqal_timetracker/ui/screens/media/media_screen.dart';
// import 'package:loqal_timetracker/ui/screens/offer_screen.dart';
// import 'package:loqal_timetracker/ui/screens/order/orders_screen.dart';
// import 'package:loqal_timetracker/ui/screens/payment_screen.dart';
// import 'package:loqal_timetracker/ui/screens/stock_screen.dart';
// import 'package:loqal_timetracker/ui/screens/todos/task_screen.dart';


class ActivitiesScreen extends StatefulWidget {
  // final List<TabItem> items;
  final int initialIndex;
  final String selectedLocation;

  const ActivitiesScreen({
    Key? key,
    // required this.items,
    required this.initialIndex,
    required this.selectedLocation,
  }) : super(key: key);

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  bool isGridView = false;
  bool isScrollingUp = false;
  late int selectedCustomTab;

  double _lastOffset = 0.0;

  @override
  void initState() {
    super.initState();
    selectedCustomTab = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.greyBackgrond,
      appBar: AppBar(
        title: const Text("User Activities", style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
        // backgroundColor: AppColors.mainappColor,
        actions: [
          // IconButton(
          //   icon: Icon(isGridView ? Icons.list : Icons.grid_view, color: Colors.white),
          //   onPressed: () {
          //     setState(() {
          //       isGridView = !isGridView;
          //     });
          //   },
          // ),
        ],
      ),
      body: Column(
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            // height: isScrollingUp ? 0 : null,
            opacity: isScrollingUp ? 0.0 : 1.0,
            child: SizedBox(
              height:  isScrollingUp ? 0 : null,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    // child: UsableLocationCard(
                    //   locationName: widget.selectedLocation,
                    // ),
                  ),
                  const SizedBox(height: 8),

                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isScrollingUp ? 0.0 : 1.0,
                    // child: CustomTabBar(
                    //   items: widget.items,
                    //   selectedIndex: selectedCustomTab,
                    //   onTabSelected: (index) {
                    //     setState(() {
                    //       selectedCustomTab = index;
                    //     });
                    //   },
                    // ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),

          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification) {
                  _handleScroll(scrollNotification.metrics.pixels);
                }
                return false;
              },
              child: Text("hello"),
              // child: _getSelectedTabWidget(selectedCustomTab),
            ),
          ),
        ],
      ),
    );
  }

  void _handleScroll(double offset) {
    if (offset > _lastOffset && offset - _lastOffset > 5) {
      // Scrolling down
      if (!isScrollingUp) {
        setState(() {
          isScrollingUp = true;
        });
      }
    } else if (offset < _lastOffset && _lastOffset - offset > 5) {
      // Scrolling up
      if (isScrollingUp) {
        setState(() {
          isScrollingUp = false;
        });
      }
    }
    _lastOffset = offset;
  }
  // Widget _getSelectedTabWidget(int index) {
  //   switch (index) {
  //     case 0:
  //       return CommonTabView(
  //         title: "Order Details",
  //         contentBuilder: (isGrid, filterText, selectedTab) {
  //           return  TaskScreen(selectedLocation:' viewModel.dashDataContr',profilePhoto:' viewModel.profilePhoto',selectedLocationId: 'viewModel.dashDataController["checkinLocationId"]',);
  //
  //         },
  //       );
  //     case 1:
  //       return CommonTabView(
  //         title: "Media",
  //         contentBuilder: (isGrid, filterText, selectedTab) {
  //           return MyMediaScreen(
  //             // locationId: viewModel.dashDataController['checkinLocationId'],
  //             locationId: 'viewModel.dashDataController',
  //             // selectedLocation: viewModel.dashDataController['checkinLocation'],
  //             // profilePhoto: viewModel.profilePhoto,
  //           ); },
  //
  //       );
  //     case 2:
  //       return CommonTabView(
  //         title: "Order Details",
  //         contentBuilder: (isGrid, filterText, selectedTab) {
  //           return OrderScreen(selectedLocation: 'viewModel.dashDataController',profilePhoto: 'viewModel.profilePhoto',selectedLocationId : 'viewModel.dashDataController');
  //
  //         },
  //       );
  //     case 3:
  //       return CommonTabView(
  //         title: "Payments",
  //         contentBuilder: (isGrid, filterText, selectedTab) {
  //           // return PaymentScreen(selectedLocation:' viewModel.dashDataController[]',profilePhoto: 'viewModel.profilePhoto,');
  //           return PaymentMethodScreen();
  //         },
  //
  //       );
  //     case 4:
  //       return CommonTabView(
  //         title: "Stocks",
  //         contentBuilder: (isGrid, filterText, selectedTab) {
  //           return const Center(child: Text("Unknown Tab"));
  //           // return StockScreen(selectedLocation: 'viewModel.dashDataController['']',profilePhoto: 'viewModel.profilePhoto',);
  //               ;
  //         },
  //
  //       );
  //     case 5:
  //       return CommonTabView(
  //         title: "Offers",
  //         contentBuilder: (isGrid, filterText, selectedTab) {
  //           return OfferScreen();
  //         },
  //
  //       );
  //     default:
  //       return const Center(child: Text("Unknown Tab"));
  //   }
  // }

  Widget _buildContent(String title, bool isGrid) {
    return isGrid ? _buildGridView(title) : _buildListView(title);
  }

  Widget _buildListView(String title) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('$title Item ${index + 1}'),
          subtitle: Text('$title description goes here'),
        );
      },
    );
  }

  Widget _buildGridView(String title) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
          child: Center(
            child: Text('$title Item ${index + 1}'),
          ),
        );
      },
    );
  }
}