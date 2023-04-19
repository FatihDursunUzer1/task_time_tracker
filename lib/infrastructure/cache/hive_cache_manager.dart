import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_time_tracker/core/application/constants/app_constants.dart';

class HiveCacheManager {
  HiveCacheManager._();
  static HiveCacheManager? _instance;
  static HiveCacheManager get instance {
    _instance ??= HiveCacheManager._();
    return _instance!;
  }

  Box? _hive;

  Box? get hive => _hive;

  set hive(Box? value) {
    _hive = value;
  }

  Future<void> init() async {
    final appDocumentDirectory =
        kIsWeb ? null : await getApplicationDocumentsDirectory();
    if (appDocumentDirectory != null) {
      Hive.init(appDocumentDirectory.path);
    } else {
      Hive.initFlutter();
    }
    if (!Hive.isBoxOpen(AppConstants.hiveBoxName)) {
      _hive = await Hive.openBox(AppConstants.hiveBoxName);
    }
  }
}
