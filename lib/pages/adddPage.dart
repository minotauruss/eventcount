import 'package:eventcount/constant/textData.dart';
import 'package:eventcount/constant/textStyle.dart';
import 'package:eventcount/constant/timeFormatNow.dart';
import 'package:eventcount/model/event.dart';
import 'package:eventcount/pages/HomePage.dart';
import 'package:eventcount/servis/eventService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddPage extends StatefulWidget {

  AddPage({ super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
final TimeFormatNow timeFormatNow = TimeFormatNow();
 final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerCategory = TextEditingController();
  final EventServis _eventServis = EventServis();
  final Uuid _uuid= Uuid();


  Widget _textEdit(TextEditingController controller,String title, ){
    return Container(
      padding:const EdgeInsets.all(12.0),
      margin: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(

          fillColor: Colors.white60,
          labelStyle: TextStyleEdit.textStyleBold24(Theme.of(context).primaryColor ,FontWeight.normal, 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          label: Text(title)
        ),
      ),
    );
  }


  
void _handleService(String tableName,String id, Event model){
_eventServis.saveData(tableName, id, model);
}
  void _save(){
  if(_controllerName.text!=""){
      final DateTime dateTime = DateTime.now();
    String id = _uuid.v1();
    String name = _controllerName.text;
    String category = _controllerCategory.text;
    Event model = Event(id,name, category,[dateTime], false, ["0"]);
    _handleService(TextData.eventName, id, model);

    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
    
  }
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
       padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height*0.5,
        width: MediaQuery.of(context).size.width,
        child:  Column(
          children: <Widget>[
            Expanded(
              child: Column(
              children: [
                SizedBox(height: 24,),
                  _textEdit(_controllerName, "Event Name"),
            _textEdit(_controllerCategory,"Category Name"),
              ],
            )),
          
        
          Container(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(onPressed: _save, child: Text("kaydet",style: TextStyle(color: Colors.white),), style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),))
    
          ],
        ),
      ),
    );
  }
}