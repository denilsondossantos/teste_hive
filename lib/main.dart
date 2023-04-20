import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:developer';
import 'package:hive_flutter/adapters.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var box = await Hive.openBox('testBox');


  runApp(MyCustomForm ());
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}
  class _MyCustomFormState extends State<MyCustomForm> {

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo lib h',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Exemplo lib Hive'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   final myController = TextEditingController();
   String text ='';

    var _box;

  @override
  void initState() {
    super.initState();
    _box = Hive.box('testBox');
  }

    //var box =    await  Hive.openBox('testBox');
  

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  void _writeLatestValue() {
  log('Valor digitado por user: ${myController.text}');
  _box.put('0', myController.text);
  }

  void _readLatestValue() {
      setState(() {
          var dados = _box.get('0');
          dados != null ? text = dados : text = 'Sem dados na memória';
          log('Texto recebido: ${text}');
      });
  }

  void _eraseLatestValue() {
    _box.delete('0');
    log('Valor deletado');
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
                 TextField(
                controller: myController,
                 decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Digite alguma coisa aqui',
                ),
              ),
             const SizedBox(height: 10,),
             TextButton(onPressed: _writeLatestValue , child: Text('Gravar'),
             style: TextButton.styleFrom(
              backgroundColor: Colors.amberAccent[400],
             ),),
             const SizedBox(height: 10,),
             TextButton(onPressed: _readLatestValue , child: Text('Ler'),
             style: TextButton.styleFrom(
              backgroundColor: Colors.blueAccent,
             ),),
             const SizedBox(height: 10,),
             TextButton(onPressed: _eraseLatestValue , child: Text('Apagar'),
               style: TextButton.styleFrom(
              backgroundColor: Colors.red[300],
             ),             
             ),
             Text('${text}'
              //controller: myController,
              ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
