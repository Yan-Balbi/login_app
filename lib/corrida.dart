import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _BluetoothPageState();
  }
}
class _BluetoothPageState extends State<BluetoothPage> {

  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  @override
  void initState(){
    super.initState();

  }

  _getBTState(){
    FlutterBluetoothSerial.instance.state.then((state){
      _bluetoothState = state;
      setState(() {});
    });
  }

  _stateChangeListener(){
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state){
          _bluetoothState = state;
          print("State isEnabled: ${state.isEnabled}");
          setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PAREAR DISPOSITIVO')),
      body: Container(
        child: Column(
          children: <Widget>[
          SwitchListTile(
            title: Text('Enabel Bluetooth'),
            value: _bluetoothState.isEnabled,
            onChanged: (bool value) {
              future() async{
                if(value){
                  await FlutterBluetoothSerial.instance.requestEnable();
                } else {
                  await FlutterBluetoothSerial.instance.requestDisable();
                }
                future().then((_){
                  setState(() {});
                });
              }
            },
          ),
            ListTile(
              title: Text('Bluetooth Status'),
              subtitle: Text(_bluetoothState.toString()),
              trailing: ElevatedButton(
                child: Text("Settings"),
                onPressed: (){
                  FlutterBluetoothSerial.instance.openSettings();
                },
              ),
            ),
        ],),
      ),
    );
  }
}