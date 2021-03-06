import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pusherman/core/error/exception.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:http/http.dart' as http;

import 'pill_box_set_data_source.dart';

// TODO: SEE: https://stackoverflow.com/questions/47372568/how-to-point-to-localhost8000-with-the-dart-http-package-in-flutter
const BASE_HOST_URI = 'localhost:8000';
const DEPENDENT_PATH = 'dependent';

class PillBoxSetRemoteDataSourceImpl implements PillBoxSetDataSource {
  final http.Client client;

  PillBoxSetRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<PillBoxSetModel> getByDependent(String dependent) async {
    final uri = new Uri.http(BASE_HOST_URI, '/$DEPENDENT_PATH/$dependent');
    final headers = {'Content-Type': 'application/json'};
    final response = await client.get(
      uri.toString(),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return PillBoxSetModel.fromJson(json.decode(response.body));
    }

    throw ServerException();
  }

  @override
  Future<void> put(PillBoxSetModel pillBoxSet) async {
    final uri = new Uri.http(BASE_HOST_URI, '/$DEPENDENT_PATH/${pillBoxSet.dependent}');
    final headers = {'Content-Type': 'application/json', 'Accept': 'application/json'};
    final body = json.encode(pillBoxSet.toJson());
    print('url=${uri.toString()}');
    print('body=$body');
    print('headers=$headers');

    var response = await client.put(
      uri.toString(),
      body: body,
      headers: headers,
    );

    return response;
  }
}
