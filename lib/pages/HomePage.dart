import 'dart:async';


import 'package:eventcount/constant/textData.dart';
import 'package:eventcount/constant/textStyle.dart';
import 'package:eventcount/constant/timeFormatNow.dart';
import 'package:eventcount/model/event.dart';
import 'package:eventcount/pages/adddPage.dart';
import 'package:eventcount/pages/detailPage.dart';
import 'package:eventcount/servis/eventService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EventServis _eventServis = EventServis();
  final TimeFormatNow timeFormatNow = TimeFormatNow();
  double sayacSaniye = 0;
  double sayacdakika = 0;
  double sayacSaat = 0;
  bool isLoading = false;
  List<String> timeList = [];
  List<DateTime> dateList=[];


  List eventList=[];
  Widget _title() {
    return Text(TextData.appBarTitle);
  }

  void getSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return AddPage();
        });
  }



  void releasedEvent() {
    eventList = [];
    List event = _eventServis.getDataAll(TextData.eventName);
    setState(() {
      eventList = event;
   
    });

    for(var item in eventList){
      print(item.id);
    }
  }

  Widget _eventContainer(
      Color color, String name, FontWeight fontWeight, double size) {
    return Container(
      child: Text(
        name,
        style: TextStyleEdit.textStyleBold24(color, fontWeight, size),
      ),
    );
  }





  Object getEventOne(String id) {
    var box = _eventServis.getData(TextData.eventName, id);
    return box;
  }

  void getTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (isLoading == false) {
        // Future.delayed(Duration(seconds: 1));
        timer.cancel();
      } else {
        setState(() {
          sayacSaniye++;
        });

        if (sayacSaniye == 60) {
          setState(() {
            sayacdakika++;
            sayacSaniye = 0;
          });
        }
        if (sayacdakika == 60) {
          setState(() {
            sayacSaat++;
            sayacSaniye = 0;
            sayacdakika = 0;
          });
        }
      }
    });
  }

  

  void _toatsMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _timerCalculateAndAdd(List<String> timeDataList, List<DateTime> dateListNew ) {
    final DateTime now = DateTime.now();
   setState(() {
      timeList = timeDataList;
    dateList=dateListNew;
   });
    String totaldk = (sayacdakika + (sayacSaat * 60)).toString();
    if (double.parse(totaldk) > 0.0) {
      timeList.add(totaldk.toString());
      dateList.add(now);
      
    }
  }

  String timerTotalResult(List<String> timeDataList){
    double toplam=0.0;
    for (String time in timeDataList ){

      toplam = toplam + double.parse(time);
    
    }
    return toplam.toInt().toString();
  }

  @override
  void initState() {
    super.initState();
    releasedEvent();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: getSheet,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: _title(),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(sayacSaat.toInt()<10? "0":"",style: TextStyle(color: Colors.black,fontSize: 48, fontWeight: FontWeight.bold)),
                            Container(
                              
                              child: Text(sayacSaat.toInt().toString(),style: TextStyle(color: Colors.black,fontSize: 48, fontWeight: FontWeight.bold),),
                            ),
                          
                            Text(":"),
                            Text(sayacdakika.toInt()<10? "0":"",style: TextStyle(color: Colors.black,fontSize: 48, fontWeight: FontWeight.bold)),
                            Container(
                              child: Text(sayacdakika.toInt().toString(),style: TextStyle(color: Colors.black,fontSize: 48, fontWeight: FontWeight.bold)),
                            ),
                            Text(":"),
                            Text(sayacSaniye.toInt()<10? "0":"",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 64, fontWeight: FontWeight.bold)),
                            Container(
                              child: Text(sayacSaniye.toInt().toString(),style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 64, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        Container(
                          
                          child:
                              Text(timeFormatNow.dateFormatGAY(DateTime.now())),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                flex: 8,
                child: ListView.builder(
                    itemCount: eventList.length,
                    itemBuilder: (context, index) {
                      var data = eventList[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(event: data))),
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            height: 128,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _eventContainer(
                                          Colors.black54,
                                          timeFormatNow
                                              .dateFormatGAY(data.date[0]),
                                          FontWeight.normal,
                                          12),
                                      Text("${timeFormatNow.EventTime(data.date[0])}"+"${TextData.etkin}")
                                    ],
                                  ),
                                  _eventContainer(Colors.black, data.name,
                                      FontWeight.bold, 32),
                              
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          _eventContainer(Colors.black54, data.category,
                                              FontWeight.normal, 18),
                      
                                              const SizedBox(width: 24,),
                                             Container(child: Row(children: [  _eventContainer(Theme.of(context).primaryColor, timerTotalResult(data.time), FontWeight.bold, 16),
                                               Text(" Dk Etkin"),],),),
                      
                                               Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                   
                                      Container(
                                        height: 48,
                                        width: 48,
                                        child: IconButton(
                                            isSelected: !isLoading,
                                            onPressed: isLoading == true
                                                ? () {
                                                    _toatsMessage(
                                                      TextData.runnig  );
                                                  }
                                                : () {
                                                    List<String> timeList = [];
                                                    setState(() {
                                                      isLoading = true;
                                                    });
                      
                                                    getTimer();
                                                    _eventServis.saveData(
                                                        TextData.eventName,
                                                        data.id,
                                                        Event(
                                                            data.id,
                                                            data.name,
                                                            data.category,
                                                            data.date,
                                                            isLoading,
                                                            data.time));
                                                  },
                                            icon: Icon(
                                              Icons.play_circle,
                                              size: 48,
                                            )),
                                      ),
                                      Container(
                                        height: 48,
                                        width: 48,
                                        child: IconButton(
                                            isSelected: isLoading,
                                            onPressed: () {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              _timerCalculateAndAdd(data.time,data.date);
                                              getTimer();
                      
                                              setState(() {
                                                sayacSaat = 0;
                                                sayacdakika = 0;
                                                sayacSaniye = 0;
                                              });
                      
                                              _eventServis.saveData(
                                                  TextData.eventName,
                                                  data.id,
                                                  Event(
                                                      data.id,
                                                      data.name,
                                                      data.category,
                                                      data.date,
                                                      isLoading,
                                                      timeList));
                      
                                
                                            },
                                            icon: Icon(
                                              Icons.pause_circle,
                                              size: 48,
                                            )),
                                      )
                                    ],
                                  )
                                        ],
                                      ),
                                        
                                    
                      
                                    
                                  
                                   
                                  
                                ]),
                          ),
                        )),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
