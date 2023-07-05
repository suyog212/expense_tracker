import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../home.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _changeName = TextEditingController();

  final _userData = Hive.box("UserData");
  List setName() {
    final name = _userData.keys.map((key) {
      final item = _userData.get(key);
      return {"Name": item};
    }).toList();
    return name;
  }

  double margin = 7.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50,
        backgroundColor: Colors.transparent,
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.blueGrey.shade700),
        ),
        leading: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
          alignment: Alignment.center,
          child: IconButton(
              onPressed: () {
                setState(() {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const Home(title: "title")));
                });
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        leadingWidth: 60,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        children: [
          Container(
            margin: EdgeInsets.all(margin),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
            child: ListTile(
              hoverColor: Colors.transparent,
              title: const Text("Update your balance"),
              subtitle: Text("Current : ${_userData.get("Amount") ?? ""}"),
              onTap: () {
                showModalBottomSheet(
                    useSafeArea: true,
                    enableDrag: true,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    constraints:
                        const BoxConstraints.tightForFinite(height: 500),
                    context: context,
                    builder: (_) => Container(
                          padding: const EdgeInsets.all(12.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                TextField(
                                  controller: _amount,
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(),
                                      border: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(),
                                      hintText: "Amount",
                                      label: ButtonBar(
                                        alignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.attach_money),
                                          Text("Amount")
                                        ],
                                      )),
                                  autofocus: true,
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _userData.put(
                                            "Amount", _amount.text.trim());
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    child: const Text("Update"))
                              ],
                            ),
                          ),
                        ));
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(margin),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
            child: ListTile(
              hoverColor: Colors.transparent,
              title: const Text("Toggle Dark Mode"),
              onTap: () {},
              subtitle: const Text("Default will be system theme"),
              trailing: Switch(
                  value: true,
                  onChanged: (value) {
                    setState(() {
                      if (value) {
                        value = false;
                      } else {
                        value = true;
                      }
                    });
                  }),
            ),
          ),
          Container(
            margin: EdgeInsets.all(margin),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
            child: ListTile(
              hoverColor: Colors.transparent,
              title: const Text("Edit name"),
              subtitle: Text("Name : ${_userData.get("Name") ?? ""}"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Inputs_page(
                              controller: _changeName,
                              title: "Edit Name",
                              hint: "Ex. Peter Parker",
                              label: "Name",
                              param: 'Name',
                            )));
                // showModalBottomSheet(
                //     context: context,
                //     builder: (_) {
                //       return Container(
                //         padding: const EdgeInsets.all(15.0),
                //         height: 210,
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.end,
                //           children: [
                //             const Row(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               children: [Text("Update Name")],
                //             ),
                //             const SizedBox(
                //               height: 15.0,
                //             ),
                //             TextField(
                //               controller: _changeName,
                //               decoration: const InputDecoration(
                //                   border: OutlineInputBorder(),
                //                   enabledBorder: OutlineInputBorder(),
                //                   focusedBorder: OutlineInputBorder(),
                //                   label: Text("Name"),
                //                   hintText: "Ex. Peter Parker"),
                //               autofocus: true,
                //             ),
                //             const SizedBox(
                //               height: 15,
                //             ),
                //             ElevatedButton(
                //                 onPressed: () {
                //                   setState(() {
                //                     _userData.put(
                //                         "Name", _changeName.text.trim());
                //                     Navigator.of(context).pop();
                //                   });
                //                 },
                //                 child: const Text("Update"))
                //           ],
                //         ),
                //       );
                //     });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(margin),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
            child: ListTile(
              title: const Text("About us"),
              onTap: () {},
              hoverColor: Colors.transparent,
            ),
          )
        ],
      ),
    );
  }
}

class Inputs_page extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String hint;
  final String label;
  final String param;
  const Inputs_page(
      {Key? key,
      required this.controller,
      required this.title,
      required this.hint,
      required this.label,
      required this.param})
      : super(key: key);

  @override
  State<Inputs_page> createState() => _Inputs_pageState();
}

class _Inputs_pageState extends State<Inputs_page> {
  final _userData = Hive.box("UserData");
  // final _data = Hive.openBox("${widget.dbName}");
  // TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: const Key("value"),
        child: Scaffold(
          backgroundColor: Colors.blue.shade50,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ))
            ],
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(fontSize: 45),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: widget.controller,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(),
                        focusedBorder: const OutlineInputBorder(),
                        label: Text(widget.label),
                        hintText: widget.hint),
                    autofocus: true,
                  ),
                  const SizedBox(height: 15,),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _userData.put(widget.param.toString(),
                              widget.controller.text.trim());
                          Navigator.pop(context);
                        });
                      },
                      child: const Text("Update"))
                ],
              ),
            ),
          ),
        ));
  }
}
