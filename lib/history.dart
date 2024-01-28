import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHistory extends StatefulWidget {
  const MyHistory({Key? key}) : super(key: key);

  @override
  _MyHistoryState createState() => _MyHistoryState();
}

class _MyHistoryState extends State<MyHistory> {
  List<String> searchHistory = [];
  List<String> filteredHistory = [];

  void filterHistory(String query) {
    setState(() {
      filteredHistory = searchHistory
          .where(
              (history) => history.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(36, 80, 59, 1),
        title: Text(
          'Historical',
          style: GoogleFonts.lexend(
              color: Color.fromRGBO(176, 225, 101, 1), fontSize: 32),
        ),
      ),
      backgroundColor: Color.fromRGBO(36, 80, 59, 1),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: filterHistory,
              decoration: InputDecoration(
                hintText: 'Search History',
                suffixIcon: const Icon(Icons.search, color: Color.fromRGBO(176, 225, 101, 1)),
                labelStyle: TextStyle(color: Color.fromRGBO(176, 225, 101, 1), fontSize: 18),
                hintStyle: TextStyle(color: Color.fromRGBO(176, 225, 101, 1), fontSize: 18),
              ),
              style: GoogleFonts.lexend(
              color: Color.fromRGBO(176, 225, 101, 1), fontSize: 18),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredHistory[index]),
                  onTap: () {
                    print('Selected search : ${filteredHistory[index]}');
                  },
                );
              },
            ),
          ),
          
        ],
      ),
    );
  }
}


// class MyHistory extends StatefulWidget {
//   @override
//   _MyHistoryState createState() => _MyHistoryState();
// }

// class _MyHistoryState extends State<MyHistory> {
//   List<String> searchHistory = ["Recherche 1", "Recherche 2", "Recherche 3"];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Text('Search History',
//               style: GoogleFonts.lexend(
//                 fontSize: 20,
//               ))),
//       body: Column(
//         children: [
//           GestureDetector(
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => MyHomePage()));
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: TextField(
//                 onSubmitted: (value) {
//                   setState(() {
//                     searchHistory.add(value);
//                   });
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Enter a search',
//                   hintStyle: GoogleFonts.lexend(fontStyle: FontStyle.italic),
//                   suffixIcon: Icon(Icons.search),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: searchHistory.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(
//                     searchHistory[index],
//                   ),
//                   onTap: () {
//                     print('Selected search : ${searchHistory[index]}');
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
