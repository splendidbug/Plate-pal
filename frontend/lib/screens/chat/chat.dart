import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/common/common.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ChatScreenArguments;
    final chatBloc = BlocProvider.of<ChatBloc>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BooperHeader(
              child: Expanded(
                child: Text(
                  args.recpie == "GENERAL" ? "Plate Pal" : args.recpie,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.inverseTextColor,
                      ),
                ),
              ),
            ),
            ChatList(),
            const SizedBox(height: 8),
            ChatInput()
          ],
        ),
      ),
    );
  }
}

class ChatList extends StatelessWidget {
  ChatList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      height: (MediaQuery.of(context).size.height * 0.85) - ChatInput.HEIGHT,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) => BooperListView.builder(
          reverse: true,
          count: state.chats.length,
          empty: const Text("Whats cookin ?"),
          builder: (context, index) => ChatCard(
            chat: state.chats[index],
            uid: userBloc.state.uid,
          ),
        ),
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  final Chat chat;
  final String uid;

  const ChatCard({
    Key? key,
    required this.chat,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: chat.isUser ? WrapAlignment.end : WrapAlignment.start,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: chat.isUser
                ? const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.zero,
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.zero,
                    bottomRight: Radius.circular(16),
                  ),
          ),
          color: chat.isUser ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.secondary,
          child: Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: chat.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  chat.message,
                  textAlign: chat.isUser ? TextAlign.right : TextAlign.left,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChatInput extends StatelessWidget {
  static const double HEIGHT = 99;

  final form = GlobalKey<FormBuilderState>();

  ChatInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatBloc = BlocProvider.of<ChatBloc>(context);
    final notificationBloc = BlocProvider.of<NotificationBloc>(context);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
      child: FormBuilder(
        key: form,
        initialValue: const {'message': ''},
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    chatBloc.add(const CEClose());
                  },
                  style: BooperPrimaryCircleButton(context, 48),
                  child: const Icon(Icons.arrow_back),
                ),
                Expanded(
                  child: FormBuilderTextField(
                    name: 'message',
                    textAlign: TextAlign.center,
                    validator: FormBuilderValidators.required(),
                    scrollPadding: const EdgeInsets.only(bottom: 160),
                    decoration: BooperInputDecoration(context),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final state = form.currentState!.saveAndValidate();

                    if (state) {
                      chatBloc.add(ChatEvent.send(
                        message: form.currentState!.value['message'],
                      ));
                      form.currentState!.reset();
                      FocusScope.of(context).unfocus();
                    } else {
                      notificationBloc.add(const NotificationEvent.show(
                        type: NotificationType.WARN,
                        message: 'Boop Needs A Title',
                      ));
                    }
                  },
                  style: BooperPrimaryCircleButton(context, 48),
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
