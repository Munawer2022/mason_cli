import 'package:fpdart/fpdart.dart';
import '/core/global.dart';
import '/domain/failure/theme/update_theme_failure.dart';
import '/domain/repositories/local/local_storage_base_api_service.dart';
import '/data/datasources/theme/theme_data_source.dart';

class UpdateThemeUseCase {
  final ThemeDataSources _themeStore;
  final LocalStorageRepository _localStorageRepository;

  UpdateThemeUseCase(this._themeStore, this._localStorageRepository);

  Future<Either<UpdateThemeFailure, bool>> execute(bool isDarkTheme) {
    _themeStore.setTheme(isDarkTheme);
    return _localStorageRepository
        .setBool(key: GlobalConstants.themeKey, value: isDarkTheme)
        .then((value) => value.fold(
              (l) => left(UpdateThemeFailure(error: l.error)),
              (r) => right(true),
            ));
  }
}
