import 'package:eventcount/abstract/repoAbstract.dart';
import 'package:eventcount/repository/evetRepository.dart';

class EventServis extends RepoAbstract {
  final EventRepository _eventRepository = EventRepository();

  @override
  String deleteData(String tableName, String id) {
    String data = _eventRepository.deleteData(tableName, id);
    return data;
  }

  @override
  Object getData(String tableName, String id) {
    Object data = _eventRepository.getData(tableName, id);
    return data;
  }

  @override
  List getDataAll(String tableName) {
    List data = _eventRepository.getDataAll(tableName);
    return data;
  }

  @override
  void saveData(String tableName, String id, model) {
    _eventRepository.saveData(tableName, id, model);
  }

  @override
  void updateData(String tableName, String id, model) {
    _eventRepository.updateData(tableName, id, model);
  }
}
