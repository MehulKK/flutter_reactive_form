import 'package:flutter/material.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  var controls = _Controls();
  var form;

  void _incrementCounter() {
    form.control(controls.counter).value = _counter++;
  }

  @override
  Widget build(BuildContext context) {
    form = FormGroup({
      controls.counter: FormControl<int>(),
      controls.text : FormControl<String>()
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ReactiveTextField(
                formControlName: controls.text,
              ),
              ReactiveValueListenableBuilder<String>(
                formControlName: controls.text,
                builder: (context, control, child) => Text(
                    control.value ?? '',
                    style: Theme.of(context).textTheme.headline6),
              ),
              ReactiveValueListenableBuilder<int>(
                formControlName: controls.counter,
                builder: (context, control, child) => Text(
                    control.isNull
                        ? 'Counter not set'
                        : 'Counter set to ${control.value?.toStringAsFixed(1)}',
                    style: Theme.of(context).textTheme.headline4),
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

class _Controls {
  String get counter => 'counter';
  String get text => 'text';
}
