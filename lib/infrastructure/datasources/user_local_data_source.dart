import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pusherman/core/error/exception.dart';
import 'package:pusherman/features/schedule/data/datasources/user_data_source.dart';
import 'package:pusherman/features/schedule/data/models/caretaker_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_CARETAKER = 'CACHED_CARETAKER_';

class CaretakerLocalDataSourceImpl implements CaretakerDataSource {
  final SharedPreferences sharedPreferences;

  CaretakerLocalDataSourceImpl({
    @required this.sharedPreferences,
  });

  @override
  Future<CaretakerModel> get(String name) {
    final cachedCaretaker = sharedPreferences.getString(CACHED_CARETAKER + name);
    if (cachedCaretaker != null) {
      return Future.value(CaretakerModel.fromJson(json.decode(cachedCaretaker)));
    }

    throw CacheException();
  }

  @override
  Future<void> put(CaretakerModel model) {
    final key = CACHED_CARETAKER + model.name;
    final modelAsString = json.encode(model.toJson());
    return sharedPreferences.setString(key, modelAsString);
  }
}
