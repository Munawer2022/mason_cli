{{#isProvider}}
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
          return
          RefreshIndicator.adaptive(
        onRefresh: value.refresh,
        child: ListView(
          children: [
           StatusSwitcher<Typedef{{class_name}}>(
              response: value.response,
              onLoading: (context) =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              onError: (context, message) => Center(
                  child: Text(message,
                      style: Theme.of(context).textTheme.titleMedium)),
              onCompleted: (context, data) => const SizedBox())
       ],
        ),
      );
        },
      ),
      {{/isGet}}
      {{#isPost}}
      SizedBox()
      {{/isPost}}
      {{#isNoThing}}
      SizedBox()
      {{/isNoThing}}
    );
  }
}
{{/isProvider}}


{{#isFlutterBloc}}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/view_model/{{folder_name}}/{{folder_name}}_view_model.dart';

{{#isGet}}
import '/utils/typedef_models.dart';
import '/resource/status_switcher.dart';
import '/view_model/{{folder_name}}/{{folder_name}}_state.dart';

{{/isGet}}

class {{class_name}}View extends StatelessWidget {
  final {{class_name}}ViewModel cubit;
  const {{class_name}}View({super.key,required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      {{#isGet}}
      RefreshIndicator.adaptive(
        onRefresh: cubit.refresh,
        child: ListView(
          children: [
            BlocBuilder(
              bloc: cubit,
              builder: (context, state) {
                state as {{class_name}}State;
                return StatusSwitcher<Typedef{{class_name}}>(
                    response: state.response,
                    onLoading: (context) =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              onError: (context, message) => Center(
                  child: Text(message,
                      style: Theme.of(context).textTheme.titleMedium)),
              onCompleted: (context, data) => const SizedBox());
              },
            ),
          ],
        ),
      ),
      {{/isGet}}
      {{#isPost}}
      SizedBox()
      {{/isPost}}
      {{#isNoThing}}
      SizedBox()
      {{/isNoThing}}
    );
  }
}
{{/isFlutterBloc}}

{{#isBloc}}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/view_model/{{folder_name}}/{{folder_name}}_view_model.dart';

{{#isGet}}
import '/utils/typedef_models.dart';
import '/resource/status_switcher.dart';
import '/view_model/{{folder_name}}/{{folder_name}}_state.dart';

{{/isGet}}

class {{class_name}}View extends StatelessWidget {
  final {{class_name}}ViewModel cubit;
  const {{class_name}}View({super.key,required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      {{#isGet}}
      RefreshIndicator.adaptive(
        onRefresh: cubit.refresh,
        child: ListView(
          children: [
            BlocBuilder(
              bloc: cubit,
              builder: (context, state) {
                state as {{class_name}}State;
                return StatusSwitcher<Typedef{{class_name}}>(
                    response: state.response,
                    onLoading: (context) =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              onError: (context, message) => Center(
                  child: Text(message,
                      style: Theme.of(context).textTheme.titleMedium)),
              onCompleted: (context, data) => const SizedBox());
              },
            ),
          ],
        ),
      ),
      {{/isGet}}
      {{#isPost}}
      SizedBox()
      {{/isPost}}
      {{#isNoThing}}
      SizedBox()
      {{/isNoThing}}
    );
  }
}
{{/isBloc}}
