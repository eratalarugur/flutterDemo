import 'package:ali_ugur_eratalar_proj/utils/color.dart';
import 'package:flutter/material.dart';

class NewMessageWidget extends StatefulWidget {
  const NewMessageWidget({Key? key}) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {

  final _controller = TextEditingController();
  String message = '';

  void sendMessage() {
    print('send message');
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                controller: _controller,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Type your message..',
                  labelStyle: TextStyle(color: AppColors.primary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: AppColors.primaryTextColor,
                    ),
                    gapPadding: 8,
                  )
                ),
                onChanged: (newValue) {
                  setState(() {
                    message = newValue;
                    _controller.text = '';
                  });
                },
          ),
          ),

          SizedBox(width: 16,),
          GestureDetector(
            onTap: message.trim().isEmpty ? null:sendMessage,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.warningColor,
              ),
              child: Icon(
                Icons.send,
                color: AppColors.appBarTitleColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
