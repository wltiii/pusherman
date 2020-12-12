import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:pusherman/core/network/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/presentation/converter/input_converter.dart';
import 'features/schedule/data/repositories/pill_box_set_repository_impl.dart';
import 'features/schedule/data/datasources/pill_box_set_data_source.dart';
import 'features/schedule/data/datasources/pill_box_set_local_data_source.dart';
import 'features/schedule/data/datasources/pill_box_set_remote_data_source.dart';
import 'features/schedule/domain/repositories/pill_box_set_repository.dart';
import 'features/schedule/domain/usecases/get_pill_box_set.dart';
import 'features/schedule/presentation/bloc/pill_box_set_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! Features - Schedule
  // Bloc
  serviceLocator.registerFactory(() =>
      PillBoxSetBloc(
          pillBoxSetGetter: serviceLocator(),
          inputConverter: serviceLocator()
      )
  );

  // Use cases
  serviceLocator.registerLazySingleton(() => GetPillBoxSet(serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<PillBoxSetRepository>(() =>
      PillBoxSetRepositoryImpl(
          networkInfo: serviceLocator(),
          localDataSource: serviceLocator(),
          remoteDataSource: serviceLocator()
      )
  );

  // Data sources
  serviceLocator.registerLazySingleton<PillBoxSetDataSource>(
      () =>  PillBoxSetLocalDataSourceImpl(sharedPreferences: serviceLocator())
  );
  serviceLocator.registerLazySingleton<PillBoxSetDataSource>(
      () => PillBoxSetRemoteDataSourceImpl(client: serviceLocator())
  );

  // Core
  serviceLocator.registerLazySingleton(() => InputConverter());
  serviceLocator.registerLazySingleton<NetworkInfo>(() =>
      NetworkInfoImpl(serviceLocator())
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerLazySingleton(() => DataConnectionChecker());
}