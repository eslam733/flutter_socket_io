import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'model/message.dart';

class ChatProvider extends ChangeNotifier {
  String name = '';
  late IO.Socket _socket;
  final TextEditingController messageInputController = TextEditingController();

  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  initSocket(String userName) {
    name = userName;
    _socket = IO.io(
      'http://localhost:3000',
      IO.OptionBuilder()
          .setTransports(['websocket']).setQuery({'username': name}).build(),
    );
    connectSocket();
  }

  sendMessage() {
    _socket.emit('message',
        {'message': messageInputController.text.trim(), 'sender': name});
    messageInputController.clear();
  }

  connectSocket() {
    _socket.onConnect((data) => print('Connection established'));
    _socket.onConnectError((data) => print('Connect Error: $data'));
    _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
    _socket.on(
      'message',
      (data) => addNewMessage(
        Message.fromJson(data),
      ),
    );
  }

  addNewMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    messageInputController.dispose();
  }
}
