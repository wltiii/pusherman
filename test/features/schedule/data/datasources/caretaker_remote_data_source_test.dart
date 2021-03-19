import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pusherman/core/error/exception.dart';
import 'package:pusherman/features/schedule/data/datasources/caretaker_data_source.dart';
import 'package:pusherman/features/schedule/data/datasources/caretaker_remote_data_source.dart';
import 'package:pusherman/features/schedule/data/models/caretaker_model.dart';
import 'package:test/test.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'caretaker_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])

void main() {
  group('CaretakerRemoteDataSource', () {
    var mockHttpClient = MockClient();
    CaretakerDataSource dataSource = CaretakerRemoteDataSourceImpl(
        client: mockHttpClient
    );

    void mockHttpGetWithStatus(status) {
      final body = status == 200
          ? fixtureAsString('caretaker.json')
          : 'Boom!';

      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(body, status),
      );
    }

    group('GET', () {
      test('gets a CaretakerModel with correct URI and headers', () async {
        // given
        mockHttpGetWithStatus(200);
        final name = 'Coda';
        final expectedCaretaker =
            CaretakerModel.fromJson(fixtureAsMap('caretaker.json'));
        var expectedUrl = Uri.http(
            'localhost:8000',
            '/caretaker/Coda'
        );
        var expectedHeaders = {
          'Content-Type' : 'application/json',
        };

        // when
        final result = await dataSource.get(name);

        // then
        expect(result, equals(expectedCaretaker));
        verify(mockHttpClient.get(
          expectedUrl,
          headers: expectedHeaders,
        ));
      });

      test('throws a ServerException when the response code is other than 200',
          () async {
        // given
        mockHttpGetWithStatus(404);
        final aDependent = 'Coda';

        // when
        final call = dataSource.get;

        // then
        expect(() => call(aDependent), throwsA(TypeMatcher<ServerException>()));
      });
    });

    group('PUT', () {
      test('creates a CaretakerModel with correct URI and headers', () async {
        // given
        var expectedUrl = Uri.http(
            'localhost:8000',
            '/caretaker/Bill'
        );
        var expectedHeaders = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        };
        final givenCaretaker = CaretakerModel
            .fromJson(fixtureAsMap('caretaker.json'));
        final expectedJsonString = json.encode(givenCaretaker);
        when(mockHttpClient.put(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
          encoding: anyNamed('encoding'),
        )).thenAnswer(
          (_) async => http.Response(expectedJsonString, 201),
        );

        // when
        await dataSource.put(givenCaretaker);

        // then
        verify(mockHttpClient.put(
          expectedUrl,
          headers: expectedHeaders,
          body: expectedJsonString,
          encoding: null,
        ));
      });

      // TODO why are the following tests commented out?
      // test('updates a CaretakerModel', () async {
      //   // given
      //   final givenCaretaker = CaretakerModel.fromJson(fixtureAsMap('caretaker.json'));
      //   final expectedJsonString = json.encode(givenCaretaker);
      //
      //   // when
      //   await dataSource.put(givenCaretaker);
      //
      //   // then
      //   verify(mockSharedPreferences.setString(
      //     CACHED_PILL_BOX_SET + givenCaretaker.name,
      //     expectedJsonString,
      //   ));
      // });

      // test('fails to create/update', () async {
      //   // given
      //   final givenCaretaker = CaretakerModel.fromJson(fixtureAsMap('caretaker.json'));
      //   final expectedJsonString = json.encode(givenCaretaker);
      //
      //   // when
      //   await dataSource.put(givenCaretaker);
      //
      //   // then
      //   verify(mockSharedPreferences.setString(
      //     CACHED_PILL_BOX_SET + givenCaretaker.name,
      //     expectedJsonString,
      //   ));
      // });
    });
  });
}