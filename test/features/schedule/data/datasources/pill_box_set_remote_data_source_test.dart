import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pusherman/core/error/exception.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_data_source.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_remote_data_source.dart';
import 'package:pusherman/features/schedule/data/models/pill_box_set_model.dart';
import 'package:test/test.dart';

import '../../../../fixtures/fixture_reader.dart';

import 'pill_box_set_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])

void main() {
  group('PillBoxSetRemoteDataSource', () {
    var mockHttpClient = MockClient();
    PillBoxSetDataSource dataSource = PillBoxSetRemoteDataSourceImpl(client: mockHttpClient);

    void mockHttpGetWithStatus(status) {
      final body =
          status == 200 ? fixtureAsString('coda_pill_box_set.json') : 'Boom!';

      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(body, status),
      );
    }

    group('getByDependent', () {
      test('calls with correct URI and headers', () async {
        // given
        mockHttpGetWithStatus(200);
        final aDependent = 'Coda';

        // when
        await dataSource.getByDependent(aDependent);

        // then
        verify(mockHttpClient.get(
          Uri(path: 'http://localhost:8000/dependent/Coda'),
          headers: {'Content-Type': 'application/json'},
        ));
      });

      test('returns a PillBoxSetModel', () async {
        // given
        mockHttpGetWithStatus(200);
        final aDependent = 'Coda';
        final expectedPillBoxSet =
            PillBoxSetModel.fromJson(fixtureAsMap('coda_pill_box_set.json'));

        // when
        final result = await dataSource.getByDependent(aDependent);

        // then
        expect(result, equals(expectedPillBoxSet));
      });

      test('throws a ServerException when the response code is other than 200',
          () async {
        // given
        mockHttpGetWithStatus(404);
        final aDependent = 'Coda';

        // when
        final call = dataSource.getByDependent;

        // then
        expect(() => call(aDependent), throwsA(TypeMatcher<ServerException>()));
      });
    });

    group('PUT', () {
      test('puts with correct URI and headers', () async {
        // given
        var expectedUrl = Uri.http(
            'localhost:8000',
            '/dependent/Coda'
        );
        var expectedHeaders = <String,String>{
          'Content-Type' : 'application/json',
          'Accept': 'application/json',
        };
        final givenPillBoxSet = PillBoxSetModel.fromJson(fixtureAsMap('coda_pill_box_set.json'));
        final expectedJsonString = json.encode(givenPillBoxSet);
        when(mockHttpClient.put(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
          encoding: anyNamed('encoding'),
        )).thenAnswer(
          (_) async => http.Response(expectedJsonString, 201),
        );

        // when
        await dataSource.put(givenPillBoxSet);

        // then
        verify(mockHttpClient.put(
          expectedUrl,
          headers: expectedHeaders,
          body: expectedJsonString,
          encoding: null,
        ));
      });

      test('creates a PillBoxSetModel', () async {
        // given
        var expectedUrl = Uri(path: 'http://localhost:8000/dependent/Coda');
        var expectedHeaders = {
          'Content-Type' : 'application/json',
          'Accept': 'application/json',
        };
        final givenPillBoxSet = PillBoxSetModel.fromJson(fixtureAsMap('coda_pill_box_set.json'));
        final expectedJsonString = json.encode(givenPillBoxSet);
        when(mockHttpClient.put(any, headers: anyNamed('headers'))).thenAnswer(
              (_) async => http.Response(expectedJsonString, 201),
        );

        // when
        await dataSource.put(givenPillBoxSet);

        // then
        verify(mockHttpClient.put(
          expectedUrl,
          body: expectedJsonString,
          headers: expectedHeaders,
          encoding: null
        ));
      });

      // test('updates a PillBoxSetModel', () async {
      //   // given
      //   final givenPillBoxSet = PillBoxSetModel.fromJson(fixtureAsMap('coda_pill_box_set.json'));
      //   final expectedJsonString = json.encode(givenPillBoxSet);
      //
      //   // when
      //   await dataSource.put(givenPillBoxSet);
      //
      //   // then
      //   verify(mockSharedPreferences.setString(
      //     CACHED_PILL_BOX_SET + givenPillBoxSet.dependent,
      //     expectedJsonString,
      //   ));
      // });

      // test('fails to create/update', () async {
      //   // given
      //   final givenPillBoxSet = PillBoxSetModel.fromJson(fixtureAsMap('coda_pill_box_set.json'));
      //   final expectedJsonString = json.encode(givenPillBoxSet);
      //
      //   // when
      //   await dataSource.put(givenPillBoxSet);
      //
      //   // then
      //   verify(mockSharedPreferences.setString(
      //     CACHED_PILL_BOX_SET + givenPillBoxSet.dependent,
      //     expectedJsonString,
      //   ));
      // });

    });
  });
}