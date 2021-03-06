import 'package:event_app_flutter/Modules/Data.dart';
import 'package:event_app_flutter/Modules/Event.dart';
import 'package:event_app_flutter/Screens/AddEvent.dart';
import 'package:event_app_flutter/Screens/ExploreScreen.dart';
import 'package:event_app_flutter/Screens/ProfileScreen.dart';
import 'package:event_app_flutter/Widgets/HomeEventContainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.uid}) : super(key: key);
  final String uid;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;
  String str = 'music';

  List<Widget> buildCategoriesWidgets() {
    List<Widget> categoriesWidgets = [];
    for (Map category in categories) {
      categoriesWidgets.add(GestureDetector(
        child: Container(
          color: _selectedCategory == categories.indexOf(category)
              ? KAppColor
              : Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              Icon(category['icon'], color: Colors.white),
              SizedBox(width: 6),
              Text("${category['name']}".toUpperCase(),
                  style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        onTap: () {
          setState(() {
            _selectedCategory = categories.indexOf(category);
            str = category['name'];
          });
        },
      ));
    }
    return categoriesWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddEvent()));
          },
          child: const Icon(Icons.add),
          backgroundColor: KAppColor,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Container(
              height: 200,
              padding: EdgeInsets.all(20),
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'WELCOME',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 0.5),
                      ),
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      suffixIcon: Icon(Icons.filter_list, color: Colors.white),
                    ),
                    onChanged: (val) {},
                  ),
                  Container(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: buildCategoriesWidgets(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(
                          'All',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  // Container(
                  //   height: 290,
                  //   child: ListView.builder(
                  //     itemCount: weekendEvents.length,
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) {
                  //       Event event = weekendEvents[index];
                  //       return HomeEventContainer(
                  //         event: event,
                  //       );
                  //     },
                  //   ),
                  // ),
                  Container(
                    height: 530,
                    child: ExploreTab(
                      category: str,
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Upcoming Events',
                  //       style: TextStyle(
                  //         color: Colors.grey,
                  //         fontSize: 15,
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(right: 20),
                  //       child: Text(
                  //         'All',
                  //         style: TextStyle(
                  //           color: Colors.grey,
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // SizedBox(height: 10),
                  // Container(
                  //   height: 300,
                  //   child: ListView.builder(
                  //     itemCount: upcomingHomeEvents.length,
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) {
                  //       Event event = upcomingHomeEvents[index];
                  //       return HomeEventContainer(
                  //         event: event,
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
//   Widget buildCategoriesWidgets() {
//     return Expanded(
//         child: DefaultTabController(
//       length: 5,
//       initialIndex: 0,
//       child: Column(
//         children: [
//           TabBar(
//             isScrollable: true,
//             indicatorColor: Colors.green,
//             tabs: [
//               Tab(
//                 child: Row(
//                   children: [
//                     Icon(Icons.music_note, color: Colors.white),
//                     SizedBox(width: 6),
//                     Text('MUSIC', style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//               ),
//               Tab(
//                 child: Row(
//                   children: [
//                     Icon(Icons.sports_basketball, color: Colors.white),
//                     SizedBox(width: 6),
//                     Text('SPORT', style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//               ),
//               Tab(
//                 child: Row(
//                   children: [
//                     Icon(Icons.fastfood, color: Colors.white),
//                     SizedBox(width: 6),
//                     Text('FOOD', style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//               ),
//               Tab(
//                 child: Row(
//                   children: [
//                     Icon(Icons.bubble_chart, color: Colors.white),
//                     SizedBox(width: 6),
//                     Text('ART', style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//               ),
//               Tab(
//                 child: Row(
//                   children: [
//                     Icon(Icons.circle, color: Colors.white),
//                     SizedBox(width: 6),
//                     Text('OTHER', style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//               )
//             ],
//             unselectedLabelColor: Colors.transparent,
//           ),
//           Expanded(
//             child: TabBarView(
//               children: [
//                 ExploreTab(category: 'music'),
//                 ExploreTab(category: 'sport'),
//                 ExploreTab(category: 'food'),
//                 ExploreTab(category: 'art'),
//                 ExploreTab(category: 'other'),
//               ],
//             ),
//           )
//         ],
//       ),
//     ));
//   }
// }

