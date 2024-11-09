import 'package:get_it/get_it.dart';
import 'package:get_secure_storage/get_secure_storage.dart';
import 'package:tezda_app/services/api_service.dart';
import 'package:tezda_app/utils/dialog_handler.dart';

import 'navigation_handler.dart';

final locator = GetIt.I;
final dh = locator<DialogHandler>();
final nav = locator<NavigationHandler>();
final api = locator<ApiService>();

Future<void> setupLocator() async {
  await GetSecureStorage.init(password: 'tezda-secure', container: 'tezda-box');
  locator.registerLazySingleton<GetSecureStorage>(
    () => GetSecureStorage(password: 'tezda-secure', container: 'tezda-box'),
  );

  locator.registerLazySingleton<NavigationHandler>(
    () => NavigationHandlerImpl(),
  );

  locator.registerLazySingleton<DialogHandler>(
    () => DialogHandlerImpl(),
  );
  locator.registerLazySingleton<ApiService>(
    () => ApiService(),
  );
}
