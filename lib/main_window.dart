import 'package:exp_trck/screens/settings.dart';
import 'package:exp_trck/screens/tracs.dart';
import 'package:exp_trck/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:timeago/timeago.dart' as timeago;

class Main_Window extends StatefulWidget {
  const Main_Window({Key? key}) : super(key: key);

  @override
  State<Main_Window> createState() => _Main_WindowState();
}

class _Main_WindowState extends State<Main_Window> {
  final _userData = Hive.box("UserData");
  final _expense = Hive.box("Expense");

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
                _userData.get("Name") ?? "",
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
                  ButtonBar(
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
                            "₹ ${_userData.get("Income") ?? 0}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )
                    ],
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
                            "₹ ${_userData.get("Expense") ?? 0}",
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
          itemCount: _expense.length,
          itemBuilder: (_, int index) {
            final current = _expense.getAt(index);
            return ListTile(
              title: Text(current['time']),
              subtitle: Text(current['note']),
              trailing: Column(
                children: [
                  Text("${current['balance']}"),
                  Text(timeago.format(DateTime.parse(current['time'])))
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
