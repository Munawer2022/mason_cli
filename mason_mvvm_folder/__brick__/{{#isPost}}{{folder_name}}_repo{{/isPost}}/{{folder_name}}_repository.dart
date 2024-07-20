import '/repository/{{folder_name}}/{{folder_name}}_base_api_service.dart';
import '/data/network/network_base_api_services.dart';
import '/model/{{folder_name}}/{{folder_name}}_model.dart';
import '/utils/typedef_models.dart';
import '/resource/app_url.dart';

class {{class_name}}Repository implements {{class_name}}BaseApiServices {
  final NetworkBaseApiServices _baseApiServices;
  {{class_name}}Repository(this._baseApiServices);

  
@override
  Future<Typedef{{class_name}}> {{folder_name}}({required Map<String, dynamic> body}) async => await _baseApiServices
      .getApi<Map<String, dynamic>>(url: AppUrl.{{folder_name}}, body: body)
      .then((response) => {{class_name}}Model.fromJson(response));
}