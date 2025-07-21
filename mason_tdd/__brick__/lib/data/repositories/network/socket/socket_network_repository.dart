// // ignore_for_file: avoid_print
// import 'package:socket_io_client/socket_io_client.dart' as io;

// import '/core/utils/app_url.dart';
// import '/core/widgets/app_print.dart';
// import '/domain/repositories/network/socket_network_base_api_service.dart';

// class SocketNetworkRepository implements SocketNetworkBaseApiService {
//   late io.Socket _socket;

//   SocketNetworkRepository() {
//     initializeSocket();
//   }
//   @override
//   void initializeSocket() {
//     _socket = io.io(
//       AppUrl.socketBaseUrl,
//       io.OptionBuilder()
//           .setTransports(['websocket'])
//           .disableAutoConnect()
//           .build(),
//     );

//     _socket.connect();
//     _socket.onConnect((_) => AppPrint.success('Connection $_'));
//     _socket.onDisconnect((_) => AppPrint.error('onDisconnect $_'));
//     _socket.onConnectError((_) => AppPrint.error('onConnectError $_'));
//     _socket.onError((_) => AppPrint.error('onError $_'));
//   }

//   @override
//   void sendMessage({required String event, required dynamic data}) {
//     _socket.emit(event, data);
//     AppPrint.success('sendMessage $event $data');
//   }

//   @override
//   void subscribe({
//     required String event,
//     required Function(dynamic) callback,
//   }) => _socket.on(event, callback);

//   @override
//   void unsubscribe({required String event}) {
//     _socket.off(event);
//     AppPrint.success('unsubscribe $event');
//   }

//   @override
//   void dispose() {
//     _socket.dispose();
//     AppPrint.success('dispose');
//   }
// }
