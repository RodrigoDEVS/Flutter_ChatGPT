import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/helpers/constants.dart';
import 'package:flutter_chatgpt/models/chat_model.dart';
import 'package:flutter_chatgpt/models/message_model.dart';
import 'package:flutter_chatgpt/provider/chat_provider.dart';
import 'package:flutter_chatgpt/provider/models_provider.dart';
import 'package:flutter_chatgpt/services/api_services.dart';
import 'package:flutter_chatgpt/services/assets_manager.dart';
import 'package:flutter_chatgpt/services/services.dart';
import 'package:flutter_chatgpt/widgets/chat_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController chatController;
  late ScrollController chatScrollController;
  bool _isTyping = false;
  List<Choice> chatList = [];
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    chatController = TextEditingController();
    chatScrollController = ScrollController();
    focusNode = FocusNode();
    WidgetsBinding.instance!.addPersistentFrameCallback((_) => _scrollDown());
  }

  @override
  void dispose() {
    chatController.dispose();
    chatScrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);

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
                controller: chatScrollController,
                itemCount: chatProvider.getChatList.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    chatIndex: index,
                    msg: chatProvider.getChatList[index].content!,
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
                  focusNode: focusNode,
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
                          setState(() {
                            _isTyping = true;
                          });
                          await sendMessage(
                                  modelsProvider: modelsProvider,
                                  chatProvider: chatProvider)
                              .then((value) {
                            setState(() {
                              _isTyping = false;
                            });
                          });
                        },
                      )),
                  style: const TextStyle(color: Colors.white),
                  controller: chatController,
                  onSubmitted: (value) async {
                    setState(() {
                      _isTyping = true;
                    });
                    await sendMessage(
                            modelsProvider: modelsProvider,
                            chatProvider: chatProvider)
                        .then((value) {
                      setState(() {
                        _isTyping = false;
                      });
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

  Future<void> sendMessage(
      {required ModelsProvider modelsProvider,
      required ChatProvider chatProvider}) async {
    //Mensaje del usuario
    var message = MessageModel(
        model: modelsProvider.currentModel,
        messages: [Messages(role: 'user', content: chatController.text)]);
    setState(() {
      //Agregando el mensaje del usuario a la lista
      // chatList.add(Choice(
      //     index: 0,
      //     message: Message(role: 'user', content: chatController.text)));
      chatProvider.addUserMsg(userMsg: message.messages![0]);
      chatController.clear();
      focusNode.unfocus();
    });
    // chatList.addAll(await ApiServices.sendMessage(message));
    await chatProvider.sendMessageAndGetAnswer(
        chatList: chatProvider.getChatList, currentModel: message.model!);

    _scrollDown();

    setState(() {});
  }

  _scrollDown() {
    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut);
  }
}
