// // ignore_for_file: avoid_print
// import 'package:socket_io_client/socket_io_client.dart' as io;
// import '/domain/repositories/network/socket_network_base_api_service.dart';
// import '/core/app_url.dart';

// class SocketNetworkRepository implements SocketNetworkBaseApiService {
//   late io.Socket _socket;

//   SocketNetworkRepository() {
//     initializeSocket();
//   }
//   @override
//   void initializeSocket() {
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

//   @override
//   void sendMessage(
//           {required String event, required Map<String, dynamic> data}) =>
//       _socket.emit(event, data);

//   @override
//   void subscribe(
//           {required String event, required Function(dynamic) callback}) =>
//       _socket.on(event, callback);

//   @override
//   void unsubscribe({required String event}) => _socket.off(event);

//   @override
//   void dispose() => _socket.dispose();
// }
