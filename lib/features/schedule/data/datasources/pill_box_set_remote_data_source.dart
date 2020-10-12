import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:pusherman/features/schedule/domain/entities/pill_box_set.dart';
import 'package:http/http.dart' as http;

import 'pill_box_set_data_source.dart';

abstract class PillBoxSetRemoteDataSource implements PillBoxSetDataSource {
  Future<PillBoxSetModel> getByDependent(String dependent);
  Future<void> cachePillBoxSet(PillBoxSet pillBoxSet);
}

class PillBoxSetRemoteDataSourceImpl implements PillBoxSetRemoteDataSource {
  final http.Client client;

  PillBoxSetRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<PillBoxSetModel> getByDependent(String dependent) {
    // TODO: implement getByDependent
    throw UnimplementedError();
  }

  @override
  Future<void> cachePillBoxSet(PillBoxSet pillBoxSet) {
    // TODO: implement cachePillBoxSet
    throw UnimplementedError();
  }
}
