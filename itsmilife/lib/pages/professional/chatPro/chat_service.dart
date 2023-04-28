import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  late IO.Socket socket;

  void connect() {
    socket = IO.io('http://51.145.251.116:81/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.onConnect((_) {
      print('Connected to server...');
    });

    socket.on('newMessage', (data) {
      print('Received new message: $data');
    });

    socket.onDisconnect((_) {
      print('Disconnected from server...');
    });

    socket.connect();
  }

  void joinRoom(String roomId) {
    socket.emit('join', roomId);
  }

  void sendMessage(Map<String, dynamic> message) {
    socket.emit('newMessage', message);
  }
}