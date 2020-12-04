

import 'local_data_store.dart';


var codePreferences = _CdPreferences();

class _CdPreferences {
  var localDataStore = LocalDataStore();
  static const _prefix = "iscanew";
  _CdPreferences();

  Future<void> clear() async {
    return localDataStore.deleteAll();
  }

  set({String key, dynamic value}) async {
    localDataStore.setData(key:  _prefix + key, value: value);
  }

  Future<dynamic> getString({String key, dynamic ifNotExists}) async {
    String value = ifNotExists;

    value = await localDataStore.getData(key: _prefix + key);
    return value ?? ifNotExists;
  }

  Future<bool> getBoolean({String key, bool ifNotExists}) async {
    bool value = ifNotExists;
    value = await localDataStore.getData(key: _prefix + key);
    return value ?? ifNotExists;
  }

  String getValue({String key}) {
    return localDataStore.getValue(key: _prefix + key);
  }
}
