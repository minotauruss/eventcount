import 'package:eventcount/constant/textData.dart';
import 'package:eventcount/constant/textStyle.dart';
import 'package:eventcount/constant/timeFormatNow.dart';
import 'package:eventcount/model/event.dart';
import 'package:eventcount/pages/HomePage.dart';
import 'package:eventcount/servis/eventService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  Event event;
  DetailPage({required this.event, super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TimeFormatNow _timeFormatNow = TimeFormatNow();
  EventServis _eventServis=EventServis();

  Widget _eventContainer(
      Color color, String name, FontWeight fontWeight, double size) {
    return Container(
      child: Text(
        name,
        style: TextStyleEdit.textStyleBold24(color, fontWeight, size),
      ),
    );
  }

  String totalyTime() {
    double toplam = 0;
    int saat = 0;
    int dakika = 0;
    for (String item in widget.event.time) {
      toplam = toplam + double.parse(item);
    }

    if (toplam > 60.0) {
      saat = (toplam.toInt() / 60) as int;
      dakika = (toplam % 60) as int;
      return "${saat.toString()} saat ${dakika.toString()} dakika ${TextData.gecen_sure} ";
    } else {
      return "${toplam.toInt().toString()} ${TextData.gecen_sure} ";
    }
  }

  String avarageTime() {
    double avarage = 0;
    for (String item in widget.event.time) {
      avarage = avarage + double.parse(item);
    }
    avarage = avarage / (widget.event.time.length - 1);
    String sonuc = avarage.toStringAsFixed(2);
    return sonuc;
  }

  Widget _explainWidget(
      Color color, String name, FontWeight fontWeight, double size) {
    return Container(
        child: _eventContainer(
      color,
      name,
      fontWeight,
      size,
    ));
  }

  deleted(String id) {
    
    _eventServis.deleteData(TextData.eventName, id);
    
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
   

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
             IconButton(onPressed: (){
                                  deleted(widget.event.id);
                                 }, icon: const Icon(Icons.delete_forever_outlined))
        ],
    
    
        title: _eventContainer(
            Colors.black, widget.event.category, FontWeight.normal, 32),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _explainWidget(
                            Colors.black,
                            "${(widget.event.date.length - 1).toString()} ${TextData.katilmak} ",
                            FontWeight.normal,
                            14),
                        _explainWidget(
                            Colors.black,
                            "${avarageTime()} ${TextData.avarage} ",
                            FontWeight.bold,
                            12),
                 
                            _explainWidget(Theme.of(context).primaryColor,
                                widget.event.name, FontWeight.bold, 38),

                              
                          
                        
                        _explainWidget(
                            Colors.black,
                            "${_timeFormatNow.EventTime(widget.event.date[0])} ${TextData.aktif}",
                            FontWeight.bold,
                            20),
                        _explainWidget(
                            Colors.black, totalyTime(), FontWeight.normal, 16)
                      ],
                    ),
                  ),
                )),
            Expanded(
                flex: 7,
                child: Container(
                  child: ListView.builder(
                      itemCount: widget.event.date.length,
                      itemBuilder: (context, index) {
                        var data = widget.event.date[index];
                        return Card(
                          color: Colors.blue,
                          child: ListTile(
                            title: _eventContainer(
                                Colors.white,
                                _timeFormatNow.dateFormatGAY(data),
                                FontWeight.bold,
                                12),
                            trailing: widget.event.time[index] == "0"
                                ? _eventContainer(Colors.white,
                                    TextData.baslangic, FontWeight.bold, 10)
                                : _eventContainer(
                                    Colors.white,
                                    "${double.parse(widget.event.time[index]).toInt().toString()} Dk",
                                    FontWeight.bold,
                                    10),
                          ),
                        );
                      }),
                ))
          ],
        ),
      ),
    );
  }
}
