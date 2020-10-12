import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pusherman/core/error/exception.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_data_source.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_PILL_BOX_SET = 'CACHED_PILL_BOX_SET_';

class PillBoxSetLocalDataSourceImpl implements PillBoxSetDataSource {
  final SharedPreferences sharedPreferences;

  PillBoxSetLocalDataSourceImpl({
    @required this.sharedPreferences,
  });

  @override
  Future<PillBoxSetModel> getByDependent(String dependent) {
    final cachedPillBoxSet = sharedPreferences.getString(CACHED_PILL_BOX_SET + dependent);
    if (cachedPillBoxSet != null) {
      return Future.value(PillBoxSetModel.fromJson(json.decode(cachedPillBoxSet)));
    }

    throw CacheException();
  }

  @override
  Future<void> cachePillBoxSet(PillBoxSetModel model) {
    final key = CACHED_PILL_BOX_SET + model.dependent;
    final modelAsString = json.encode(model.toJson());
    return sharedPreferences.setString(key, modelAsString);
  }
}
