import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final _userData = Hive.box("UserData");

  List setName(){
    final name = _userData.keys.map((key) {
        final item = _userData.get(key);
    return {"Name" : item,"Amount" : item};
  }).toList();
    return name;
  }
  Future<void> _createItem(Map<String, dynamic> newitem) async {
    await _userData.add(newitem);
  }

  final TextEditingController _name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // physics: NeverScrollableScrollPhysics(),
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  RichText(
                      text: const TextSpan(
                          text: "Welcome",
                          style: TextStyle(
                            color: Colors.black,
                              fontSize: 20, fontWeight: FontWeight.w600),
                          children: [
                        TextSpan(
                            text:
                                "\nLets start your journey by \nsetting up a few things",
                            style: TextStyle(
                              color: Colors.black,
                                fontWeight: FontWeight.w500, fontSize: 16))
                      ]))
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(color: Colors.orangeAccent.shade100),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _name,
                decoration: const InputDecoration(
                    hintText: "Ex. Peter Parker",
                    label: Text("Name"),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    _createItem({
                      "Name" : _name.text.trim(),
                      "Amount" : _name.text.trim()
                    });
                    print(setName()[0]);
                  },
                  child: const Text("Next")),
              ElevatedButton(
                  onPressed: () {
                    // _userData.delete(_userData.length);
                    _userData.put(1, {"Amount" :_name.text});
                    print(_userData.keys);
                  },
                  child: const Text("check"))
            ],
          ),
        ),
      ),
    );
  }
}
