{{#auth}}
import '/model/local/local_user_info_store_model.dart';
{{/auth}}
{{#isGet}}
import '/model/{{folder_name}}/{{folder_name}}_model.dart';
{{/isGet}}
{{#isPost}}
import '/model/{{folder_name}}/{{folder_name}}_model.dart';
{{/isPost}}

{{#auth}}
/*
************************ Auth ************************
*/
typedef TypedefLogin = LocalUserInfoStoreModel;
typedef TypedefSignUp = LocalUserInfoStoreModel;
typedef TypedefForgotPassword = LocalUserInfoStoreModel;
{{/auth}}
{{#isGet}}
/*
************************ {{class_name}} ************************
*/
typedef Typedef{{class_name}} = {{class_name}}Model;
{{/isGet}}
{{#isPost}}
/*
************************ {{class_name}} ************************
*/
typedef Typedef{{class_name}} = {{class_name}}Model;
{{/isPost}}
