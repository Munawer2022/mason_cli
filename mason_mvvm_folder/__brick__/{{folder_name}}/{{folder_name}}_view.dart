import 'package:flutter/material.dart';
{{#isGet}}
import 'package:provider/provider.dart';
import '/utils/typedef_models.dart';
import '/view_model/{{folder_name}}/{{folder_name}}_view_model.dart';
import '/resource/status_switcher.dart';
{{/isGet}}

class {{class_name}}View extends StatelessWidget {
  const {{class_name}}View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      {{#isGet}}
      Consumer<{{class_name}}ViewModel>(
        builder: (context, value, child) {
          return StatusSwitcher<Typedef{{class_name}}>(
              response: value.response,
              onLoading: (context) =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              onError: (context, message) => Center(
                  child: Text(message,
                      style: Theme.of(context).textTheme.titleMedium)),
              onCompleted: (context, data) => SizedBox());
        },
      ),
      {{/isGet}}
      {{#isPost}}
      SizedBox()
      {{/isPost}}
    );
  }
}
