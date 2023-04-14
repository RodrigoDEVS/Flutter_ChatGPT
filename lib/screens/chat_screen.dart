import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/helpers/constants.dart';
import 'package:flutter_chatgpt/services/api_services.dart';
import 'package:flutter_chatgpt/services/assets_manager.dart';
import 'package:flutter_chatgpt/services/services.dart';
import 'package:flutter_chatgpt/widgets/chat_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController chatController;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    chatController = TextEditingController();
  }

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  await Services.showModalSheet(context: context);
                },
                icon: const Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                ))
          ],
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(AssetsManager.openaiLogo),
          ),
          title: const Text('ChatGPT')),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    chatIndex: index,
                    msg:
                        'sfdsfasdfdsafaesefaefd dafaeaeaedadf afweqefadfawe fadsfqefaef faeqefaeq faefeawefw',
                  );
                },
              ),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
            ],
            Row(
              children: [
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Send a message...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: cardColor,
                      border: const OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        color: Colors.white,
                        onPressed: () async {
                          await ApiServices.getModels();
                        },
                      )),
                  style: const TextStyle(color: Colors.white),
                  controller: chatController,
                  onSubmitted: (value) {
                    setState(() {
                      chatController.clear();
                      _isTyping = true;
                    });
                  },
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
