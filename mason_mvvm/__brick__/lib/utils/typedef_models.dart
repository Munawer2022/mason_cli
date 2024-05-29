{{#auth}}
/*
************************ Auth ************************
*/
import '/model/local/local_user_info_store_model.dart';
{{/auth}}
{{#isGet}}
/*
************************ Test ************************
*/
import '/model/{{folder_name}}/{{folder_name}}_model.dart';
{{/isGet}}
{{#isPost}}
/*
************************ Test ************************
*/
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
************************ Test ************************
*/
typedef Typedef{{class_name}} = {{class_name}}Model;
{{/isGet}}
{{#isPost}}
/*
************************ Test ************************
*/
typedef Typedef{{class_name}} = {{class_name}}Model;
{{/isPost}}
