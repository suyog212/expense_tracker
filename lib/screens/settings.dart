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
                // Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateInfo()));
                showModalBottomSheet(
                    useSafeArea: true,
                    enableDrag: true,
                    isScrollControlled: true,
                    // showDragHandle: true,
                    isDismissible: true,
                    backgroundColor: Colors.white,
                    constraints:
                        const BoxConstraints.tightForFinite(height: 370),
                    context: context,
                    builder: (_) => Container(
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
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
                                            "Amount", int.parse(_amount.text));
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
                showModalBottomSheet(
                    useSafeArea: true,
                    enableDrag: true,
                    isScrollControlled: true,
                    // showDragHandle: true,
                    isDismissible: true,
                    backgroundColor: Colors.white,
                    constraints:
                    const BoxConstraints.tightForFinite(height: 410),
                    context: context,
                    builder: (_) => Container(
                      decoration: BoxDecoration(
                          color: Colors.white
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 20),
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
                              controller: _changeName,
                              decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(),
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(),
                                  hintText: "Name",
                                  label: ButtonBar(
                                    alignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.abc_outlined),
                                      Text("Name")
                                    ],
                                  )),
                              autofocus: true,
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _userData.put(
                                        "Name", _changeName.text.trim().toString());
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
              title: const Text("About us"),
              onTap: () {},
              hoverColor: Colors.transparent,
            ),
          ),
          Container(
            margin: EdgeInsets.all(margin),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
            child: ListTile(
              title: const Text("Clear Transactions"),
              onTap: () {
                Hive.box("Income").deleteAll(Hive.box("Income").keys);
                Hive.box("Expense").deleteAll(Hive.box("Expense").keys);
                Hive.box("History").deleteAll(Hive.box("History").keys);
                _userData.put("income", 0);
                _userData.put("expense", 0);
                showDialog(context: context, builder: (_){
                  return Center(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                      height: 150,
                      width: MediaQuery.sizeOf(context).width*0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("All transactions are cleared.",style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            // textBaseline: TextBaseline.alphabetic,
                            decorationColor: Colors.transparent,
                          ),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: Text("Ok"))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
                print("Flushed");
              },
              hoverColor: Colors.transparent,
            ),
          ),
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
                      child: const Text("Update")),
                ],
              ),
            ),
          ),
        ));
  }
}


class UpdateInfo extends StatefulWidget {
  const UpdateInfo({super.key});

  @override
  State<UpdateInfo> createState() => _UpdateInfoState();
}

class _UpdateInfoState extends State<UpdateInfo> {
  final _userData = Hive.box("UserData");
  TextEditingController _amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: SizedBox.expand(
        child: DraggableScrollableSheet(
          controller: DraggableScrollableController(),
          initialChildSize: 0.25,
          maxChildSize: 0.4,
          minChildSize: 0.2,
          snap: true,
          builder: (BuildContext context, ScrollController scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Container(
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
                                "Amount", int.parse(_amount.text));
                            Navigator.of(context).pop();
                          });
                        },
                        child: const Text("Update"))
                  ],
                ),
              ),
            ),
          );
        },),
      ),
    );
  }
}
