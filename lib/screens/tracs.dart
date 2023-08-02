import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:grouped_list/grouped_list.dart';
import 'package:hive/hive.dart';

class tracs_List extends StatefulWidget {
  const tracs_List({Key? key}) : super(key: key);

  @override
  State<tracs_List> createState() => _tracs_ListState();
}

class _tracs_ListState extends State<tracs_List> {
  final _hist = Hive.box("History");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: Icon(Icons.close,color: Colors.black,))
        ],
        title: const Text("Transaction History",style: TextStyle(
          color: Colors.black,
        ),),
      ),
      body: GroupedListView(
        padding: EdgeInsets.all(12.0),
          elements: _hist.values.toList(),
          groupBy: (element) => element['category'],
        groupSeparatorBuilder: (String groupByValue) => Text(groupByValue),
        itemBuilder: (_,dynamic element){
            return Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                // tileColor: Colors.white,
                title: Text("${element['category']}"),
                subtitle: Text("${element['note']}"),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("₹${element['balance']}"),
                    Text(timeago.format(DateTime.parse(element['time'])))
                  ],
                ),
                leading: Icon(element['category'] == "Income" ? Icons.arrow_downward : Icons.arrow_upward),
              ),
            );
        },
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
