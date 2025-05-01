import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_template_plus/models/root_model/item.dart';
import 'package:provider/provider.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  // late StreamSubscription<List<ScanResult>> _scanResultsStream;

  // List<ScanResult> _blueList = [];
  BlueToothProvider _blueToothProvider = BlueToothProvider();

  @override
  void dispose() {
    // _scanResultsStream.cancel();
    _blueToothProvider.stopScan();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("蓝牙"),
        ),
        body: ChangeNotifierProvider(
          create: (context) => _blueToothProvider,
          child: Column(
            children: [
              TextButton(onPressed: () {
                _blueToothProvider.startScan();
              }, child: Text('开始扫描')),
              Consumer<BlueToothProvider>(
                builder: (context, value, child) {
                  if (value.blueList.length == 0) {
                    return Container();
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: value.blueList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Text(value.blueList[index].device.remoteId.toString()),
                            Text(value.blueList[index].advertisementData.serviceUuids.toString()),
                            Text(value.blueList[index].device.platformName ?? "NOName"),
                            Text(value.blueList[index].device.advName.toString()),
                            Text(value.blueList[index].rssi.toString()),
                            Divider(
                              height: 1,
                              color: Colors.red,
                            )
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}

class BlueToothProvider extends ChangeNotifier {
  List<ScanResult> _blueList = [];

  List<ScanResult> get blueList => _blueList;

  void setBlueList(List<ScanResult> list) {
    _blueList = list
        // .where((ScanResult result) {
        //   return result.device.advName.isNotEmpty || result.device.platformName.isNotEmpty;
        // })
        .toSet()
        .toList();
    debugPrint(_blueList.toString());
    notifyListeners();
  }

  startScan() {
    
    FlutterBluePlus.scanResults.skip(1).listen((results) {
      // debugPrint(results.toString());

      setBlueList(results);
    }, onError: (err) {
      debugPrint('scan error: $err');
    });
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 10), continuousUpdates: true, continuousDivisor: 1);

  }

  stopScan() {
    FlutterBluePlus.stopScan();
  }
}
