import 'package:exp_trck/analytics.dart';
import 'package:exp_trck/main_window.dart';
import 'package:exp_trck/screens/add_expense.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'models.dart';

class Home extends StatefulWidget {
  final String title;
  const Home({Key? key, required this.title}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void onItemTap(int index) {
    setState(() {
      _index = index;
    });
  }

  final _userData = Hive.box("UserData");
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.blue.shade50,
      body: wnd(_index),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange.shade400,
                Colors.pink.shade300,
                Colors.blue.shade300,
                Colors.blue.shade300
              ],
              stops: const [0.1, 0.3, 0.7, 1],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  offset: const Offset(0, 3),
                  blurRadius: 5)
            ],
            shape: BoxShape.circle),
        child: FloatingActionButton(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          elevation: 0,
          backgroundColor: Colors.transparent,
          onPressed: () {
            // print(_userData.get("Name"));
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const Add_Expense()));
          },
          child: const Icon(Icons.add),
        ),
      ),
      bottomNavigationBar: Container(
        // height: 90,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5)
            ],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0))),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _index,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          onTap: onItemTap,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_rounded),
                label: "Menu",
                tooltip: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.auto_graph_rounded),
                label: "Statistics",
                tooltip: "Stats"),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: true,
    );
  }

  Widget wnd(int index) {
    switch (index) {
      case 0:
        {
          return const Main_Window();
        }
      case 1:
        {
          return const Analytics();
        }
      default:
        {
          return const Error_wnd();
        }
    }
  }
}

class Error_wnd extends StatefulWidget {
  const Error_wnd({Key? key}) : super(key: key);

  @override
  State<Error_wnd> createState() => _Error_wndState();
}

class _Error_wndState extends State<Error_wnd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
      body: const Center(
        child: Text("Something went wrong"),
      ),
    );
  }
}