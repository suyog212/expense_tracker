import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'models.dart';
import 'package:timeago/timeago.dart' as timeago;

class Analytics extends StatefulWidget {
  const Analytics({Key? key}) : super(key: key);

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text("Transactions",style: TextStyle(
              color: Colors.black
            ),),
            bottom: TabBar(
              labelColor: Colors.white,
              splashBorderRadius: BorderRadius.circular(12.0),
              unselectedLabelColor: Colors.blueGrey.shade700,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.orange.withOpacity(0.8)
              ),
              indicatorColor: Colors.transparent,
              padding:const EdgeInsets.all(20.0),
                dividerColor: Colors.transparent, tabs: const [
              Tab(
                text: "Income",
                // icon: Iconify(GameIcons.receive_money),
              ),
              Tab(
                text: "Expenses",
                // icon: Iconify(GameIcons.pay_money),
              )
            ]),
          ),
          body: const TabBarView(
              children: [
            Income(),
            Expense()
          ])),
    );
  }
}


class Income extends StatefulWidget {
  const Income({Key? key}) : super(key: key);

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  final _income = Hive.box("Income");
  final _data = Hive.box("History");
  List<ExpenseData> list = [];

  void extractData(){
    for (var element in _data.values) {
      if(DateTime.now().year.toString() == DateTime.parse(element['time']).year.toString()){
        list.add(ExpenseData(DateTime.parse(element['time']), element['balance']));
      }
    }
    // list.sort((a, b) => DateTime.parse(a.date).compareTo,);
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      extractData();
      list.sort((a, b) => a.date.compareTo(b.date));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12.0),
      scrollDirection: Axis.vertical,
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.lightBlueAccent
          ),
          child: SfCartesianChart(
            title: ChartTitle(text: "Income"),
            // backgroundColor: Colors.lightBlueAccent.shade100,
            // Initialize category axis
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries<ExpenseData, String>>[
                ColumnSeries<ExpenseData, String>(
                  // Bind data source
                    dataSource: list,
                    xValueMapper: (ExpenseData sales, _) => sales.date.day.toString(),
                    yValueMapper: (ExpenseData sales, _) => sales.amount),
              ]),
        ),
        ListView.builder(
          shrinkWrap: true,
            itemCount: _income.length,
            itemBuilder: (_,int index){
            final current = _income.getAt(index);
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
        })
      ],
    );
  }
}

class Expense extends StatefulWidget {
  const Expense({Key? key}) : super(key: key);

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  final _exp = Hive.box("Expense");
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _exp.length,
      itemBuilder: (_,int index){
        final current = _exp.getAt(index);
        return ListTile(
          title: Text(current["note"]),
          trailing: Text(current["balance"]),
          tileColor: Colors.black,
        );
      },
    );
  }
}
