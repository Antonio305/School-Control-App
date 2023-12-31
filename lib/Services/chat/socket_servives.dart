import 'package:flutter/material.dart';
import 'package:sistema_escolar_prepa/Services/login_provider.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../global/enviroment.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket? _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket get socket => _socket!;
  
  Function get emit => _socket!.emit;


  void connect() async {

 // hacemos la instancia del token 
   final token  =await  LoginServices.getToken();


    // Dart client
    _socket = IO.io(Enviroment.checkUrlSocket, {
      // _socket = IO.io('http:localhost:3000', {

      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      // 'extraHaders': token
      // podemos enviar um  mapa
      'extraHeaders': {
        'x-token': token
      }
    });


    _socket!.on('connect', (_) {
      print('Estamos conectados');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket!.on('disconnect', (_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  // para la desconecion del socket
  void disconnect() async {
    _socket!.disconnect();
    // _socket!.onDisconnect((data) {
    //   print('ESTAMOS DESCONECTADOS');
    // });
  }
}
