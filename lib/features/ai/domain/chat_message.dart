/// Who wrote a chat message; names match the Gemini API roles
enum ChatRole { user, model }

class ChatMessage {
  const ChatMessage({
    required this.role,
    required this.text,
    this.isError = false,
    this.isQuota = false,
  });

  const ChatMessage.user(this.text)
    : role = ChatRole.user,
      isError = false,
      isQuota = false;

  const ChatMessage.model(this.text)
    : role = ChatRole.model,
      isError = false,
      isQuota = false;

  /// A failure shown in the thread; never sent back to the model
  const ChatMessage.error(this.text, {this.isQuota = false})
    : role = ChatRole.model,
      isError = true;

  final ChatRole role;
  final String text;
  final bool isError;

  /// The failure was the daily AI limit (offer an upgrade)
  final bool isQuota;

  bool get isUser => role == ChatRole.user;
}
