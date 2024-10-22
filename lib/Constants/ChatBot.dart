import 'package:flutter/material.dart';

class BotScreen extends StatefulWidget {
  const BotScreen({super.key});

  @override
  _BotScreenState createState() => _BotScreenState();
}

class _BotScreenState extends State<BotScreen> {
  final List<Map<String, String>> _messages = [];  // To store messages from bot and user
  final TextEditingController _controller = TextEditingController();
  bool _showTextField = false;  // Controls the visibility of the TextField
  String _userName = "";

  @override
  void initState() {
    super.initState();
    _botSendMessage("Hello! Please enter your name.");
  }

  // Function to send bot messages
  void _botSendMessage(String message) {
    setState(() {
      _messages.add({"sender": "bot", "message": message});
      _showTextField = true;  // Show TextField when the bot asks for the name
    });
  }

  // Function to handle user input and send messages
  void _handleUserInput() {
    String input = _controller.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _messages.add({"sender": "user", "message": input});
      _controller.clear();  // Clear TextField after input
      _showTextField = false;  // Hide TextField after user submits name

      if (_userName.isEmpty) {
        _userName = input;  // Store the user's name
        Future.delayed(const Duration(milliseconds: 500), () {
          _botSendMessage("Nice to meet you, $_userName! How can I assist you today?");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bot Interaction'),
      ),
      body: Column(
        children: [
          // Display messages in a ListView
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Align(
                    alignment: message['sender'] == 'user'
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: message['sender'] == 'user'
                            ? Colors.blue[100]
                            : Colors.green[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(message['message']!),
                    ),
                  ),
                );
              },
            ),
          ),

          // Show TextField only when required
          if (_showTextField)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: _userName.isEmpty ? 'Enter your name' : 'Type your message...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _handleUserInput,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
