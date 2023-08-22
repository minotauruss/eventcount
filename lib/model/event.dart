import 'package:hive_flutter/hive_flutter.dart';
/* flutter pub run build_runner build --delete-conflicting-outputs */
part 'event.g.dart';

@HiveType(typeId: 0)
class Event extends HiveObject {
  @HiveField(0)
  String _name;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  @HiveField(1)
  String _category;

  String get category => _category;

  set category(String value) {
    _category = value;
  }

  @HiveField(2)
  List<DateTime> _date;

  List<DateTime> get date => _date;

  set date(List<DateTime> value) {
    _date = value;
  }

  @HiveField(3)
  List<String> _time;

  List<String> get time => _time;

  set time(List<String> value) {
    _time = value;
  }

  @HiveField(4)
  bool _finished;

  bool get finished => _finished;

  set finished(bool value) {
    _finished = value;
  }

  @HiveField(5)
  String _id;
  String get id => _id;

  set id(String value) {
    _id = value;
  }

  Event(this._id, this._name, this._category, this._date, this._finished,
      this._time);
}
