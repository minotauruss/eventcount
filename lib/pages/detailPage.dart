import 'package:eventcount/constant/textStyle.dart';
import 'package:eventcount/constant/timeFormatNow.dart';
import 'package:eventcount/model/event.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  Event event;
  DetailPage({ required this.event,super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TimeFormatNow _timeFormatNow = TimeFormatNow();


    Widget _eventContainer(
      Color color, String name, FontWeight fontWeight, double size) {
    return Container(
      child: Text(
        name,
        style: TextStyleEdit.textStyleBold24(color, fontWeight, size),
      ),
    );
  }

  String totalyTime(){
    double toplam=0;
    for (String item in widget.event.time){
      toplam=toplam+double.parse(item);

    }
    return "${toplam.toInt().toString()} Dk etkinlekte gecen sure";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _eventContainer(Colors.black,widget.event.category,FontWeight.normal,32),),

      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
         
              Container(
                padding: EdgeInsets.all(16),
                child: Expanded(
                  
                  flex: 2,
                  child: Column(
                    
                   
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(child:  _eventContainer(Colors.black,"${(widget.event.date.length-1).toString()} Kez Etkinlige katildiniz",FontWeight.normal,14),),
                      Container(child:  _eventContainer(Colors.black,widget.event.name,FontWeight.bold,38),),
                       Container(child:  _eventContainer(Colors.black,"${_timeFormatNow.EventTime(widget.event.date[0])} Gundur Aftif",FontWeight.bold,20),),
                       Container(child:  _eventContainer(Colors.black,totalyTime(),FontWeight.normal,16),),
                    ],
                  )),
              ),
            
            Expanded(
              flex: 6,
              child: Container(child: ListView.builder(
              itemCount: widget.event.date.length,
              itemBuilder: (context,index){
                var data = widget.event.date[index];
              return Card(
                child: ListTile(
                  title: Text(_timeFormatNow.dateFormatGAY(data)),
                  trailing: widget.event.time[index]=="0"? Text("Baslangic tarihi") : Text("${double.parse(widget.event.time[index]).toInt().toString()} Dk"),
                ),
              );
            }),))
          ],
        ),
      ),
    );
  }
}