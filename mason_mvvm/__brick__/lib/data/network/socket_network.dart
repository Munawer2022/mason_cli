// // ignore_for_file: avoid_print

// import 'package:socket_io_client/socket_io_client.dart' as io;
// import '/resource/app_url.dart';

// class SocketNetwork {
//   late io.Socket _socket;

//   SocketNetwork() {
//     _initializeSocket();
//   }

//   void _initializeSocket() {
//     _socket = io.io(
//         AppUrl.socketBaseUrl,
//         io.OptionBuilder()
//             .setTransports(['websocket'])
//             .disableAutoConnect()
//             .build());

//     _socket.connect();
//     _socket.onConnect((_) => print('Connection $_'));
//     _socket.onDisconnect((_) => print('onDisconnect $_'));
//     _socket.onConnectError((_) => print('onConnectError $_'));
//     _socket.onError((_) => print('onError $_'));
//   }

//   void sendMessage(
//           {required String event, required Map<String, dynamic> data}) =>
//       _socket.emit(event, data);

//   void subscribe(
//           {required String event, required Function(dynamic) callback}) =>
//       _socket.on(event, callback);

//   void unsubscribe({required String event}) => _socket.off(event);

//   void dispose() => _socket.dispose();
// }
