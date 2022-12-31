import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Chart_Bars extends StatelessWidget {
  final String label;
  final int amount;
  final double percentoftotal;
  Chart_Bars({this.label,this.amount,this.percentoftotal});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
        return Column(
      children: [
        Container(height:constraints.maxHeight *0.15,child: FittedBox(child: Text('₹${amount}'))),
        SizedBox(
          height: constraints.maxHeight *0.05,
        ),
        Container(
          height: constraints.maxHeight* 0.6,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 1),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(heightFactor:percentoftotal  ,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue
                ),
              ),),
            ],
          ),
        ),
        SizedBox(
          height: constraints.maxHeight *0.05,
        ),
        Container(
          height: constraints.maxHeight *0.15,
          child: FittedBox(child: Text(label)))
      ],
    );  
    },);   
  }
}