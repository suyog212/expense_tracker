// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
//
// class Test extends StatefulWidget {
//   const Test({Key? key}) : super(key: key);
//
//   @override
//   State<Test> createState() => _TestState();
// }
//
// class _TestState extends State<Test> {
//
//   //Created a empty list to retrive data
//   List<Map<String, dynamic>> _items = [];
//
//   //Initialise the database
//   final _Log = Hive.box("Log");
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _refreshItems();
//   }
//   void _refreshItems(){
//     final data = _Log.keys.map((key) {
//       final item = _Log.get(key);
//       return {"key" : key, "Name" : item['Name'],"Price":item['Price']};
//     }).toList();
//     setState(() {
//       _items = data.reversed.toList();
//     });
//   }
//   //Map to add items to the Database
//   Future<void> _createItem(Map<String, dynamic> newitem) async {
//     await _Log.add(newitem);
//     _refreshItems();
//   }
//   //Text Editing contorllers
//   TextEditingController cntr1 = TextEditingController();
//   TextEditingController cntr2 = TextEditingController();
//
//   //function to display a dialog at the bottom of page
//   void _showForm(BuildContext context){
//     showModalBottomSheet(context: context, builder: (_) => Container(
//       padding: const EdgeInsets.all(20.0),
//       decoration: const BoxDecoration(
//           color: Colors.white
//       ),
//       height: 210,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           TextField(
//             controller: cntr1,
//             decoration: const InputDecoration(hintText: "Name"),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           TextField(
//             controller: cntr2,
//             decoration: const InputDecoration(hintText: "Price"),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           ElevatedButton(
//             child: const Text("Create"),
//             onPressed: (){
//               _createItem({
//                 "Name" : cntr1.text.trim(),
//                 "Prce" : cntr2.text.trim()
//               });
//               cntr1.clear();
//               cntr2.clear();
//               Hive.box("Log").add("Hello");
//               Navigator.pop(context);
//             },
//           )
//         ],
//       ),
//     ),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("DB operations"),
//       ),
//       body: ListView.builder(
//         itemCount: _items.length,
//           itemBuilder: (_,index){
//           final current = _items[index];
//         return Card(
//           color: Colors.orangeAccent.shade100,
//           margin: const EdgeInsets.all(10.0),
//           elevation: 3,
//           child: ListTile(
//             title: current['Name'],
//             subtitle: current['Price'],
//             trailing: ButtonBar(
//               children: [
//                 IconButton(onPressed: (){}, icon: const Icon(Icons.edit)),
//                 IconButton(onPressed: (){}, icon: const Icon(Icons.delete))
//               ],
//             ),
//           ),
//         );
//       }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showForm(context),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
