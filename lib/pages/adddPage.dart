import 'package:eventcount/constant/textData.dart';
import 'package:eventcount/constant/timeFormatNow.dart';
import 'package:eventcount/model/event.dart';
import 'package:eventcount/servis/eventService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

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
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(title)
      ),
    );
  }


  
void _handleService(String tableName,String id, Event model){
_eventServis.saveData(tableName, id, model);
}
  void _save(){
    final DateTime dateTime = DateTime.now();
    String id = _uuid.v1();
    String name = _controllerName.text;
    String category = _controllerCategory.text;
    Event model = Event(id,name, category,[dateTime], false, ["0"]);
    _handleService(TextData.eventName, id, model);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height*0.5,
        width: MediaQuery.of(context).size.width,
        child:  Column(
          children: <Widget>[
            _textEdit(_controllerName, "Event Name"),
            _textEdit(_controllerCategory,"Category Name"),
           ElevatedButton(onPressed: _save, child: const Text("Kaydet"))
    
          ],
        ),
      ),
    );
  }
}