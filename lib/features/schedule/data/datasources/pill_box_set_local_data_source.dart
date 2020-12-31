import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exception.dart';
import '../models/pill_box_set_model.dart';
import 'pill_box_set_data_source.dart';

const CACHED_PILL_BOX_SET = 'CACHED_PILL_BOX_SET_';

//TODO make sure there are tests that verify the impl is a PillBoxSetLocalDataSource
abstract class PillBoxSetLocalDataSource extends PillBoxSetDataSource {
}

class PillBoxSetLocalDataSourceImpl implements PillBoxSetLocalDataSource {
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
  Future<void> put(PillBoxSetModel model) {
    final key = CACHED_PILL_BOX_SET + model.dependent;
    final modelAsString = json.encode(model.toJson());
    return sharedPreferences.setString(key, modelAsString);
  }
}
