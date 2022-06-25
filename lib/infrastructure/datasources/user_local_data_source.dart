import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pusherman/core/error/exception.dart';
import 'package:pusherman/features/schedule/data/datasources/user_data_source.dart';
import 'package:pusherman/features/schedule/data/models/caretaker_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_CARETAKER = 'CACHED_CARETAKER_';

class CaregiverLocalDataSourceImpl implements CaregiverDataSource {
  final SharedPreferences sharedPreferences;

  CaregiverLocalDataSourceImpl({
    @required this.sharedPreferences,
  });

  @override
  Future<CaregiverModel> get(String name) {
    final cachedCaregiver = sharedPreferences.getString(CACHED_CARETAKER + name);
    if (cachedCaregiver != null) {
      return Future.value(CaregiverModel.fromJson(json.decode(cachedCaregiver)));
    }

    throw CacheException();
  }

  @override
  Future<void> put(CaregiverModel model) {
    final key = CACHED_CARETAKER + model.name;
    final modelAsString = json.encode(model.toJson());
    return sharedPreferences.setString(key, modelAsString);
  }
}