import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/helpers/constants.dart';
import 'package:flutter_chatgpt/services/assets_manager.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.chatIndex});

  final String msg;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex % 2 != 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                    chatIndex % 2 != 0
                        ? AssetsManager.userImage
                        : AssetsManager.botImage,
                    width: 30,
                    height: 30),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    msg,
                    style: const TextStyle(color: Colors.white60),
                  ),
                ),
                chatIndex % 2 != 0
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.thumb_up_alt_outlined,
                              color: Colors.white),
                          Icon(Icons.thumb_down_alt_outlined,
                              color: Colors.white)
                        ],
                      )
              ],
            ),
          ),
        )
      ],
    );
  }
}