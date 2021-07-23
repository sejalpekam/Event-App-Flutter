import 'package:event_app_flutter/Modules/Event.dart';
import 'package:event_app_flutter/Screens/EventScreen.dart';
import 'package:flutter/material.dart';

class HomeEventContainer extends StatefulWidget {
  final Event event;
  final String category;

  const HomeEventContainer({this.event, this.category});

  @override
  _HomeEventContainerState createState() => _HomeEventContainerState();
}

class _HomeEventContainerState extends State<HomeEventContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventScreen(
              category: widget.category,
              event: widget.event,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 20),
          Container(
            margin: EdgeInsets.fromLTRB(7, 25, 5, 0),
            child: Stack(
              children: [
                Container(
                  height: 210,
                  width: 320,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: //AssetImage(widget.event.image),
                          NetworkImage(widget.event.image),
                    ),
                  ),
                ),
                // Positioned(
                //     right: 10,
                //     left: 10,
                //     bottom: 10,

                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         // Text(
                //         //   event.cost,
                //         //   style: TextStyle(
                //         //     color: Colors.white,
                //         //     fontSize: 18,
                //         //   ),
                //         // ),
                //         // Icon(
                //         //   event.category['icon'],
                //         //   color: Colors.white,
                //         // ),
                //       ],
                //     ))
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            widget.event.name,
            style: TextStyle(
              fontSize: 23,
              wordSpacing: 1,
            ),
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 15,
              ),
              Text(
                widget.event.location,
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 11,
                ),
              ),
              SizedBox(width: 20),
              Text(
                widget.event.participants.toString() + ' Attendees',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
