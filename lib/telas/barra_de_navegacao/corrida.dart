import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothPairingScreen extends StatefulWidget {
  @override
  _BluetoothPairingScreenState createState() => _BluetoothPairingScreenState();
}

class _BluetoothPairingScreenState extends State<BluetoothPairingScreen> {
  // Cria uma lista para armazenar os dispositivos disponíveis para pareamento
  List<BluetoothDevice> _availableDevices = [];

  // Inicializa o FlutterBluetoothSerial
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;

  // Inicializa o estado do dispositivo pareado
  BluetoothDevice? _dispositivospareados;

  // Atualiza a lista de dispositivos disponíveis para pareamento
  void _refreshDeviceList() {
    _bluetooth.getBondedDevices().then((pairedDevices) {
      setState(() {
        _availableDevices = pairedDevices;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshDeviceList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parear dispositivo Bluetooth'),
      ),
      body: Column(
        children: <Widget>[
          // Exibe uma lista de dispositivos disponíveis para pareamento
          Expanded(
            child: ListView.builder(
              itemCount: _availableDevices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_availableDevices[index].name.toString()),
                  onTap: () {
                    // Quando o usuário seleciona um dispositivo, atualiza o estado do dispositivo pareado
                    setState(() {
                      _dispositivospareados = _availableDevices[index];
                    });
                  },
                );
              },
            ),
          ),
          // Exibe o dispositivo pareado atual
          ListTile(
            title: Text('Dispositivo pareado: ${_dispositivospareados?.name ?? 'Nenhum'}'),
          ),
        ],
      ),
    );
  }
}