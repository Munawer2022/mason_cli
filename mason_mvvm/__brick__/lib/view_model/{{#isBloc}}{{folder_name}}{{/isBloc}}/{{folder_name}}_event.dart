class {{class_name}}Event{}
{{#isGet}}
class {{class_name}} extends {{class_name}}Event{}
class Refresh extends {{class_name}}Event{}
{{/isGet}}
{{#isPost}}
class {{class_name}} extends {{class_name}}Event{
  final Map<String, dynamic> body;
  {{class_name}}({required this.body});
}
{{/isPost}}