part of 'chat_screen.dart';

class MessageBarBetter extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final void Function()? onSend;
  final void Function()? onTyping;
  final void Function()? onPressCamera;
  final void Function()? onPressGallery;
  const MessageBarBetter(
      {this.controller,
      this.hintText,
      this.onPressCamera,
      this.onPressGallery,
      this.onSend,
      this.onTyping,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 1,
          thickness: 1,
        ),
        Expanded(
          child: Row(
            children: [
              IconButton(
                onPressed: onPressGallery,
                icon: Icon(Icons.photo_size_select_actual_outlined,
                    color: Colors.green.shade500,
                    size: 30,),
              ),
              IconButton(
                onPressed: onPressCamera,
                icon: Icon(Icons.camera_alt_rounded, color: Colors.blueGrey.shade400, size: 30,),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: (value) {
                    if (onTyping != null) {
                      onTyping!();
                    }
                  },
                  decoration: InputDecoration(
                    hintText: hintText,
                  ),
                ),
              ),
              IconButton(
                onPressed: onSend,
                icon: const Icon(
                  Icons.send,
                  color: Colors.lightBlue,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
