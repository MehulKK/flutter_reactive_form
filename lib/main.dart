import 'package:flutter/material.dart';
import 'package:flutter_reactive_forms/home_control.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Reactive form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Reactive form'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var controls = HomeControl();
  var form;

  void _incrementCounter() {
    form.control(controls.counter).value = _counter++;
  }

  @override
  Widget build(BuildContext context) {
    form = FormGroup({
      controls.counter: FormControl<int>(),
      controls.name : FormControl<String>(validators: [Validators.required])
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ReactiveForm(
        formGroup: form,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              ReactiveTextField(
                validationMessages: {
                  ValidationMessage.required: (_) =>
                  'The password must not be empty'
                },
                formControlName: controls.name,
                decoration: const InputDecoration(
                  hintText: 'Enter text'
                ),
              ),
             /* ReactiveValueListenableBuilder<String>(
                formControlName: controls.name,
                builder: (context, control, child) => Text(
                    control.value ?? '',
                    style: Theme.of(context).textTheme.headline6),
              ),*/
              ReactiveValueListenableBuilder<int>(
                formControlName: controls.counter,
                builder: (context, control, child) => Text(
                    control.isNull
                        ? 'Counter not set'
                        : 'Counter set to ${control.value?.toStringAsFixed(1)}',
                    style: Theme.of(context).textTheme.headline4),
              ),
              ElevatedButton(
                onPressed: () => form.reset(),
                child: const Text('RESET'),
              ),
              ReactiveFormConsumer(
                builder: (context, form, child) => ElevatedButton(
                  onPressed: form.valid ? () => print(form.value) : null,
                  child: const Text('Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}