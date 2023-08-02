import 'package:exp_trck/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

class Add_Expense extends StatefulWidget {
  const Add_Expense({Key? key}) : super(key: key);

  @override
  State<Add_Expense> createState() => _Add_ExpenseState();
}

class _Add_ExpenseState extends State<Add_Expense> {
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _note = TextEditingController();
  final _user_data = Hive.box("UserData");
  final _history = Hive.box("History");
  final _income = Hive.box("Income");
  final _expense = Hive.box("Expense");
  String type = "";
  String category = "";
  String selected_time = "time";
  int amount = 0;

  Widget addType(String categ) {
    if (categ == "Expense") {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
        child: DropdownMenu(
            enableSearch: true,
            inputDecorationTheme:
                const InputDecorationTheme(border: InputBorder.none),
            width: MediaQuery.of(context).size.width * 0.8,
            enabled: true,
            onSelected: (value) {
              setState(() {
                type = value!;
              });
              print(type);
            },
            label: const Text("Type (Ex. Food,Shopping,etc.)"),
            leadingIcon: const Icon(Icons.wallet),
            dropdownMenuEntries: const [
              DropdownMenuEntry(value: "Food", label: "Food"),
              DropdownMenuEntry(value: "Entertainment", label: "Entertainment"),
              DropdownMenuEntry(value: "Travel", label: "Travel"),
              DropdownMenuEntry(value: "Shopping", label: "Shopping"),
            ]),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.none,
      key: const Key(""),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const Home(title: "title")))
                      .then((value) => setState(() {}));
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Home(title: "title")));
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.blueGrey.shade500,
                ))
          ],
        ),
        backgroundColor: Colors.blue.shade50,
        body: SingleChildScrollView(
          child: Container(
            // height: MediaQuery.sizeOf(context).height,
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text(
                      "Add Record",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            prefixText: "₹",
                            prefixStyle: TextStyle(fontSize: 32)
                            // prefix: Icon(CupertinoIcons.money_dollar)
                            ),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 50),
                        // textInputAction: TextInputAction.join,
                        controller: _amount,
                        autofocus: false,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.note_alt_outlined,
                            color: Colors.black,
                          ),
                        ),
                        style: const TextStyle(fontSize: 18),
                        controller: _note,
                        minLines: 1,
                        maxLines: 5,
                        // expands: true,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: DropdownMenu(
                          enableSearch: true,
                          inputDecorationTheme:
                              const InputDecorationTheme(border: InputBorder.none),
                          width: MediaQuery.of(context).size.width * 0.8,
                          enabled: true,
                          onSelected: (value) {
                            setState(() {
                              category = value!;
                            });
                            print(category);
                          },
                          label: const Text("Category(Income or Expense)"),
                          leadingIcon: const Icon(Icons.wallet),
                          dropdownMenuEntries: const [
                            DropdownMenuEntry(value: "Income", label: "Income"),
                            DropdownMenuEntry(value: "Expense", label: "Expense"),
                          ]),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    addType(category),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        DatePicker.showDatePicker(
                          context,
                          dateFormat: 'dd MMMM yyyy HH:mm',
                          initialDateTime: DateTime.now(),
                          minDateTime: DateTime(2000),
                          maxDateTime: DateTime(3000),
                          onMonthChangeStartWithFirstDate: true,
                          onConfirm: (dateTime, List<int> index) {
                            setState(() {
                              DateTime selectdate = dateTime;
                              final selIOS = DateFormat('yyyy-MM-dd HH:mm:ss')
                                  .format(selectdate);
                              selected_time = selIOS;
                            });
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                      ),
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Time", style: TextStyle(color: Colors.black)),
                          Text(selected_time,
                              style: const TextStyle(color: Colors.black))
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          fixedSize:
                              Size(MediaQuery.of(context).size.width * 0.8, 50),
                          alignment: Alignment.centerLeft),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade400,
                            Colors.pink.shade300,
                            Colors.pink.shade300,
                            Colors.orange.shade300
                          ],
                          stops: const [
                            0.32,
                            0.45,
                            0.65,
                            0.85
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          transform: const GradientRotation(70))),
                  child: TextButton(
                      onPressed: () async {
                        setState(() {
                          if(_amount.text != ""){
                            if (category == "Income") {
                              _income.put(DateTime.timestamp().toString(), {
                                "balance": int.parse(_amount.text.trim()),
                                "note": _note.text.trim(),
                                "time": selected_time.toString(),
                                "category": category
                              });
                              _history.put(DateTime.timestamp().toString(), {
                                "balance": int.parse(_amount.text.trim()),
                                "note": _note.text.trim(),
                                "time": selected_time.toString(),
                                "category": category
                              });
                              _user_data.put("income",
                                  _user_data.get("income") + int.parse(_amount.text));
                              _user_data.put("Amount",
                                  _user_data.get("Amount") + int.parse(_amount.text));
                              _amount.clear();
                              _note.clear();
                              selected_time = "time";
                              category = "";
                              // print(_amount.text.trim());
                              // print(_history.values);
                            } else {
                              _expense.put(DateTime.timestamp().toString(), {
                                "balance": int.parse(_amount.text.trim()),
                                "note": _note.text.trim(),
                                "time": selected_time.toString(),
                                "type": type,
                                "category": category
                              });
                              _history.put(DateTime.timestamp().toString(), {
                                "balance": int.parse(_amount.text.trim()),
                                "note": _note.text.trim(),
                                "time": selected_time.toString(),
                                "type": type,
                                "category": category
                              });
                              _user_data.put("expense",
                                  _user_data.get("expense") + int.parse(_amount.text));
                              _user_data.put("Amount",
                                  _user_data.get("Amount") - int.parse(_amount.text));
                              _amount.clear();
                              _note.clear();
                              selected_time = "time";
                              category = "";
                              type = "";
                              // print(_expense.values);
                              // print(_history.values);
                            }
                          }
                        });
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
