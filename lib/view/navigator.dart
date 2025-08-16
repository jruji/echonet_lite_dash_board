import '../colorVar.dart';
import '../view/views.dart';
import 'package:flutter/material.dart';

class GetNavigator extends StatefulWidget {
  const GetNavigator({Key? key}) : super(key: key);

  @override
  State<GetNavigator> createState() => _GetNavigatorState();
}

class _GetNavigatorState extends State<GetNavigator> {
  final List<Widget> _contents = [
    GetDeviceList(),
    GetProfilesView(),
    // Content for Feed tab

    GetErrorDeviceListView(),
    GetFloorMap()
    /*Container(
      color: Colors.red.shade100,
      alignment: Alignment.center,
      child: const Text(
        'Floor Map To Be Implemented',
        style: TextStyle(fontSize: 40),
      ),
    ),*/
    // Content for Favorites tab
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Show the bottom tab bar if screen width < 640
        bottomNavigationBar: MediaQuery.of(context).size.width < 640
            ? BottomNavigationBar(
                currentIndex: _selectedIndex,
                unselectedItemColor: Colors.grey,
                selectedItemColor: colorVar().DevNameC,
                // called when one tab is selected
                onTap: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                // bottom tab items
                items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.format_list_bulleted),
                        label: 'All Devices'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.grid_view), label: 'Grouped'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.warning), label: 'Error Devices'),
                     BottomNavigationBarItem(
                         icon: Icon(Icons.zoom_in_map), label: 'Floor Map')
                  ])
            : null,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Show the navigaiton rail if screen width >= 640
            if (MediaQuery.of(context).size.width >= 640)
              NavigationRail(
                indicatorColor: Color.fromARGB(126, 169, 209, 255),
                minWidth: 55.0,
                selectedIndex: _selectedIndex,
                // Called when one tab is selected
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                labelType: NavigationRailLabelType.all,
                selectedLabelTextStyle: const TextStyle(
                  color: Color.fromARGB(255, 7, 38, 66),
                ),
                leading: Column(
                  children: const [
                    SizedBox(
                      height: 8,
                    ),
                    CircleAvatar(
                      radius: 20,
                      child: Icon(Icons.house),
                      backgroundColor: Color.fromARGB(255, 76, 91, 105),
                      foregroundColor: Color.fromARGB(255, 213, 230, 246),
                    ),
                  ],
                ),
                unselectedLabelTextStyle: const TextStyle(),
                // navigation rail items
                destinations: const [
                  NavigationRailDestination(
                      icon: Icon(Icons.format_list_bulleted),
                      label: Text('All Devices')),
                  NavigationRailDestination(
                      icon: Icon(Icons.grid_view), label: Text('Grouped')),
                  NavigationRailDestination(
                      icon: Icon(Icons.warning), label: Text('Error Devices')),
                  NavigationRailDestination(
                      icon: Icon(Icons.zoom_in_map), label: Text('Floor Map')),
                ],
              ),

            // Main content
            // This part is always shown
            // You will see it on both small and wide screen
            Expanded(child: _contents[_selectedIndex]),
          ],
        ));
  }
}
