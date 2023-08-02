import 'package:exp_trck/screens/settings.dart';
import 'package:exp_trck/screens/tracs.dart';
import 'package:exp_trck/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:random_avatar/random_avatar.dart';

class Main_Window extends StatefulWidget {
  const Main_Window({Key? key}) : super(key: key);

  @override
  State<Main_Window> createState() => _Main_WindowState();
}

class _Main_WindowState extends State<Main_Window> {
  final _userData = Hive.box("UserData");
  final _expense = Hive.box("History");

  String name = " ";
  // @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      name = _userData.get("Name");
    });
  }
  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   didUpdateWidget(Main_Window());
  // }


  @override
  Widget build(BuildContext context) {
    return ListView(
      // physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        ListTile(
          leading: RandomAvatar(_userData.get("Name") ?? " ", width: 50),
          tileColor: Colors.transparent,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome!",
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
              Text(
                name,
                // _userData.get("Name") ?? "",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: Colors.blueGrey.shade700),
              )
            ],
          ),
          trailing: btn(Colors.white, () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const Settings()));
          }, 35, 35, const Icon(Icons.settings)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          height: 200,
          decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    blurStyle: BlurStyle.outer,
                    offset: Offset(0, 0),
                    blurRadius: 10)
              ],
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade400,
                  Colors.pink.shade300,
                  Colors.pink.shade300,
                  Colors.orange.shade300
                ],
                stops: const [0.2, 0.5, 0.8, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Total Balance",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "₹ ${_userData.get("Amount") ?? 0}",
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){},
                    child: ButtonBar(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              shape: BoxShape.circle),
                          padding: const EdgeInsets.all(5),
                          child:
                              const Icon(Icons.arrow_upward, color: Colors.green),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Income",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "₹ ${_userData.get("income") ?? 0}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  ButtonBar(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            shape: BoxShape.circle),
                        padding: const EdgeInsets.all(5),
                        child:
                            const Icon(Icons.arrow_downward, color: Colors.red),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Expense",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "₹ ${_userData.get("expense") ?? 0}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Transactions",
              style: TextStyle(
                  color: Colors.blueGrey.shade700,
                  fontWeight: FontWeight.w800,
                  fontSize: 20),
            ),
            TextButton(
              onPressed: () {
                print(_expense.values);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const tracs_List()));
              },
              style: TextButton.styleFrom(
                elevation: 0,
                surfaceTintColor: Colors.transparent,
              ),
              child: const Text("View All"),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          reverse: true,
          itemCount: _expense.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, int index) {
            final current = _expense.getAt(index);
            return Transaction(
              time: DateTime.parse(current['time']),
              amount: current['balance'],
              type: current['type'] ?? "Received",
              category: current['category'],
            );
          },
        ),
      ],
    );
  }
}
