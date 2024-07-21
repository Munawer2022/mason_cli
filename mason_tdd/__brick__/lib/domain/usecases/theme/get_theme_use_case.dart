import 'package:fpdart/fpdart.dart';
import '/core/global.dart';
import '/domain/failures/theme/get_theme_failure.dart';
import '/domain/repositories/local/local_storage_base_api_service.dart';
import '/data/datasources/theme/theme_data_source.dart';

class GetThemeUseCase {
  final LocalStorageRepository _localStorageRepository;
  final ThemeDataSources _themeStore;

  GetThemeUseCase(this._localStorageRepository, this._themeStore);

  Future<Either<GetThemeFailure, Unit>> execute() => _localStorageRepository
      .getBool(key: GlobalConstants.themeKey)
      .then((value) => value.fold((l) => left(GetThemeFailure(error: l.error)),
              (isDarkTheme) {
            _themeStore.setTheme(isDarkTheme);
            return right(unit);
          }));
}
