class _transaction{
  final int amount;
  final DateTime time;

  _transaction(this.amount, this.time);
}

class _type{
  final _transaction transaction;
  final String type;
  _type(this.transaction, this.type);
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class ExpenseData{
  final DateTime date;
  final int amount;

  ExpenseData(this.date, this.amount);
}


class data{
  List<_type> tracs = [
    _type(_transaction(1460, DateTime.now()), "Food"),
    _type(_transaction(1543, DateTime.now()), "Travel"),
    _type(_transaction(520, DateTime.now()), "Entertainment"),
    _type(_transaction(4550, DateTime.now()), "Shopping"),
     _type(_transaction(4550, DateTime.now()), "Travel"),
     _type(_transaction(4550, DateTime.now()), "Entertainment"),
     _type(_transaction(4550, DateTime.now()), "Food"),
     _type(_transaction(4550, DateTime.now()), "Food"),
  ];
}