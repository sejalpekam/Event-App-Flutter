import 'package:event_app_flutter/Modules/Event.dart';
import 'package:flutter/material.dart';

const Color KAppColor = Color(0xFF00AF19);

List<Map> categories = [
  {
    "name": 'music',
    'icon': Icons.music_note,
  },
  {
    "name": 'sport',
    'icon': Icons.sports_basketball,
  },
  {
    "name": 'food',
    'icon': Icons.fastfood,
  },
  {
    "name": 'art',
    'icon': Icons.bubble_chart,
  },
  {
    "name": 'other',
    'icon': Icons.miscellaneous_services,
  },
];

List<Event> profileEvents = [
  Event(
    name: 'Marwan Pablo Live',
    image: 'assets/event8.jpg',
    category: 'music',
    //date: '24 Dec',
    // category: categories[0],
    location: 'Barclays Centre',
    // fromTo: '19PM - 22PM',
    // cost: '60-240\$',
    participants: 1947,
    // duration: 3,
    about:
        'Music festivals have come a long way since the psychedelic wig-outs of the \'60s. These days, there\'s a festival for everyone, even if you\'ve shunned most annual mud-fests in the past because you dance to disco and you don\'t like rock. Beyond the traditional London, UK and European festivals, there are fantastic international events from California\'s very Instagram-friendly Coachella to Japan\'s fabulous Fuji Rock, which prides itself on being the \'cleanest festival in the world\'Here are the 50 best music festivals to try before you die.',
  ),
  Event(
    name: 'Marwan Pablo Live',
    image: 'assets/event7.jpg',
    category: 'music',
    //date: '24 Dec',
    //category: categories[0],
    location: 'Barclays Centre',
    // fromTo: '19PM - 22PM',
    // cost: '60-240\$',
    participants: 1947,
    //duration: 3,
    about:
        'Music festivals have come a long way since the psychedelic wig-outs of the \'60s. These days, there\'s a festival for everyone, even if you\'ve shunned most annual mud-fests in the past because you dance to disco and you don\'t like rock. Beyond the traditional London, UK and European festivals, there are fantastic international events from California\'s very Instagram-friendly Coachella to Japan\'s fabulous Fuji Rock, which prides itself on being the \'cleanest festival in the world\'Here are the 50 best music festivals to try before you die.',
  ),
  Event(
    name: 'Marwan Pablo Live',
    image: 'assets/event0.jpg',
    category: 'music',
    //date: '24 Dec',
    // category: categories[0],
    location: 'Barclays Centre',
    // fromTo: '19PM - 22PM',
    // cost: '60-240\$',
    participants: 1947,
    //duration: 3,
    about:
        'Music festivals have come a long way since the psychedelic wig-outs of the \'60s. These days, there\'s a festival for everyone, even if you\'ve shunned most annual mud-fests in the past because you dance to disco and you don\'t like rock. Beyond the traditional London, UK and European festivals, there are fantastic international events from California\'s very Instagram-friendly Coachella to Japan\'s fabulous Fuji Rock, which prides itself on being the \'cleanest festival in the world\'Here are the 50 best music festivals to try before you die.',
  ),
  Event(
    name: 'Marwan Pablo Live',
    image: 'assets/event6.jpg',
    category: 'music',
    //date: '24 Dec',
    // category: categories[0],
    location: 'Barclays Centre',
    // fromTo: '19PM - 22PM',
    // cost: '60-240\$',
    participants: 1947,
    //duration: 3,
    about:
        'Music festivals have come a long way since the psychedelic wig-outs of the \'60s. These days, there\'s a festival for everyone, even if you\'ve shunned most annual mud-fests in the past because you dance to disco and you don\'t like rock. Beyond the traditional London, UK and European festivals, there are fantastic international events from California\'s very Instagram-friendly Coachella to Japan\'s fabulous Fuji Rock, which prides itself on being the \'cleanest festival in the world\'Here are the 50 best music festivals to try before you die.',
  ),
];
