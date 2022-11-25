import 'package:flutter/material.dart';
import 'package:flutter_socket_io/pages/chat/chat_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  const ChatScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<ChatScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ChatProvider>(context, listen: false).initSocket(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (_, provider, __) => ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final message = provider.messages[index];
                  return Wrap(
                    alignment: message.senderUsername == chatProvider.name
                        ? WrapAlignment.end
                        : WrapAlignment.start,
                    children: [
                      Card(
                        color: message.senderUsername == chatProvider.name
                            ? Theme.of(context).primaryColorLight
                            : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment:
                                message.senderUsername == chatProvider.name
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                            children: [
                              Text(message.message),
                              Text(
                                DateFormat('hh:mm a').format(message.sentAt),
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (_, index) => const SizedBox(
                  height: 5,
                ),
                itemCount: provider.messages.length,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: chatProvider.messageInputController,
                      decoration: const InputDecoration(
                        hintText: 'Type your message here...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => chatProvider.sendMessage(),
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
