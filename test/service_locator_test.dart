import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:pusherman/core/network/network_info.dart';
import 'package:pusherman/core/presentation/converter/input_converter.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_local_data_source.dart';
import 'package:pusherman/features/schedule/data/datasources/pill_box_set_remote_data_source.dart';
import 'package:pusherman/features/schedule/domain/repositories/pill_box_set_repository.dart';
import 'package:pusherman/features/schedule/domain/usecases/get_pill_box_set.dart';
import 'package:pusherman/features/schedule/presentation/blocs/pillboxset/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:pusherman/service_locator.dart' as di;

void main() async {
  await di.init();

  group('is registered', () {
    test('DataConnectionChecker', () async {
      expect(di.sl.isRegistered<DataConnectionChecker>(), isTrue);
    });
    test('http.Client', () {
      expect(di.sl.isRegistered<http.Client>(), isTrue);
    });
    test('SharedPreferences', () {
      expect(di.sl.isRegistered<SharedPreferences>(), isTrue);
    });
    test('InputConverter', () {
      expect(di.sl.isRegistered<InputConverter>(), isTrue);
    });
    test('NetworkInfo', () async {
      expect(di.sl.isRegistered<NetworkInfo>(), isTrue);
    });
    test('PillBoxSetLocalDataSource', () {
      expect(di.sl.isRegistered<PillBoxSetLocalDataSource>(), isTrue);
    });
    test('PillBoxSetRemoteDataSource', () {
      expect(di.sl.isRegistered<PillBoxSetRemoteDataSource>(), isTrue);
    });
    test('PillBoxSetRepository', () {
      expect(di.sl.isRegistered<PillBoxSetRepository>(), isTrue);
    });
    test('GetPillBoxSet', () {
      expect(di.sl.isRegistered<GetPillBoxSet>(), isTrue);
    });
    test('PillBoxSetBloc', () {
      expect(di.sl.isRegistered<PillBoxSetBloc>(), isTrue);
    });
  });

  group('gets instance', () {
    test('DataConnectionChecker', () async {
      final instance = di.sl.get<DataConnectionChecker>();
      expect(instance, isNot(null));
      expect(instance, isA<DataConnectionChecker>());
      var result = await instance.hasConnection;
      expect(result, isTrue);
    });
    test('InputConverter', () {
      final instance = di.sl.get<InputConverter>();
      expect(instance, isNot(null));
      expect(instance, isA<InputConverter>());
    });
    test('NetworkInfo', () async {
      final instance = di.sl.get<NetworkInfo>();
      expect(instance, isNot(null));
      expect(instance, isA<NetworkInfo>());
      var connected = await instance.isConnected;
      expect(connected, isTrue);
    });
    test('PillBoxSetLocalDataSource', () async {
      final instance = di.sl.get<PillBoxSetLocalDataSource>();
      expect(instance, isNot(null));
      expect(instance, isA<PillBoxSetLocalDataSource>());
      // TODO throws expected CacheException - catch it
      // PillBoxSetModel model = await instance.getByDependent('dependent');
    });
  });

}