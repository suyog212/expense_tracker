import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget btn(Color color,onTap,double height,double width,Icon icn){
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height,
      alignment: Alignment.center,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: icn,
    ),
  );
}

class Transaction extends StatefulWidget {
  final int amount;
  final DateTime time;
  final String type;
  const Transaction({Key? key,required this.time,required this.amount,required this.type}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  // String sign = "-"
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.only(right: 18,left: 10),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ButtonBar(
            children: [
              _bgicon(setIcon(widget.type), setColor(widget.type),10),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.35,
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  child: Text(" ${widget.type}",style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("-₹ ${widget.amount}",style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey,
                  fontSize: 16
              ),),
              Text(timeago.format(widget.time),style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                fontSize: 12
              ),),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _bgicon(Icon icon,Color bgcolor,double padding){
  return Container(
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
      color: bgcolor,
      shape: BoxShape.circle,
    ),
    child: icon,
  );
}

Icon setIcon(String label){
  switch(label){
    case "Food" : {
      return const Icon(Icons.emoji_food_beverage_outlined);
    }
    case "Shopping":{
      return const Icon(Icons.shopping_basket);
    }
    case "Entertainment":{
      return const Icon(Icons.tv);
    }
    case "Travel":{
      return const Icon(Icons.directions_bus);
    }
    default:{
      return const Icon(Icons.money);
    }
  }
}


Color setColor(String label){
  switch(label){
    case "Food" : {
      return Colors.orangeAccent;
    }
    case "Shopping":{
      return Colors.purpleAccent;
    }
    case "Entertainment":{
      return Colors.redAccent;
    }
    case "Travel":{
      return Colors.green;
    }
    default:{
      return Colors.black;
    }
  }
}