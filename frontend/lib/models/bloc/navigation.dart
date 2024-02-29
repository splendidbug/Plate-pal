enum NavigationType {
  POP,
  PUSH,
  POP_BACK,
  PUSH_EMPTY,
}

enum ProfileScreenMode {
  CREATE,
  EDIT,
}

class ProfileScreenArguments {
  final ProfileScreenMode mode;

  const ProfileScreenArguments({
    required this.mode,
  });
}

class ChatScreenArguments {
  final String recpie;

  const ChatScreenArguments({
    required this.recpie,
  });

  const ChatScreenArguments.initial() : recpie = '';
}
