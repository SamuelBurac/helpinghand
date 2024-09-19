part of 'chat_screen.dart';

class MessageBarBetter extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final void Function(String imageURL) onSend;

  const MessageBarBetter(
      {this.controller, this.hintText, required this.onSend, super.key});

  @override
  State<MessageBarBetter> createState() => _MessageBarBetterState();
}

class _MessageBarBetterState extends State<MessageBarBetter> {
  File? imageFile;
  String imageURL = "";

  bool showImage = false;

  void _toggleImage() {
    setState(() {
      showImage = !showImage;
    });
  }

  @override
  void dispose() {
    widget.controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () async {
            //open up gallery to select a picture
            final picker = ImagePicker();
            final pickedFile =
                await picker.pickImage(source: ImageSource.gallery);

            if (pickedFile != null) {
              _toggleImage();
              setState(() {
                imageFile = File(pickedFile.path);
              });
            }
          },
          icon: Icon(
            Icons.photo_size_select_actual_outlined,
            color: Colors.green.shade500,
            size: 30,
          ),
        ),
        IconButton(
          onPressed: () async {
            final File? capturedImage = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CameraScreen(),
              ),
            );

            if (capturedImage != null) {
              _toggleImage();
              setState(() {
                imageFile = capturedImage;
              });
            }
          },
          icon: Icon(
            Icons.camera_alt_rounded,
            color: Colors.blueGrey.shade400,
            size: 30,
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                width: .70,
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showImage)
                  Column(
                    children: [
                      Container(
                        constraints: const BoxConstraints(
                          maxHeight: 150,
                          maxWidth: 200,
                        ),
                        child: Stack(
                          children: [
                            if (imageFile != null)
                              Image.file(
                                imageFile!,
                                fit: BoxFit.cover,
                              )
                            else
                              Image.asset("assets/logoHH.png"),
                            Positioned(
                              right: -9,
                              top: -9,
                              child: IconButton(
                                padding:
                                    EdgeInsets.zero, // Remove default padding
                                constraints: const BoxConstraints(
                                  minWidth: 20,
                                  minHeight: 20,
                                  maxWidth: 20,
                                  maxHeight: 20,
                                ),
                                iconSize: 15, // Set the icon size
                                onPressed: () {
                                  _toggleImage();
                                  setState(() {
                                    imageFile = null;
                                  });
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                style: ButtonStyle(
                                  side: WidgetStateProperty.all(
                                    const BorderSide(color: Colors.white),
                                  ),
                                  backgroundColor: WidgetStateProperty.all(
                                    Colors.grey.shade800,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 0.7,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ],
                  ),
                TextField(
                  minLines: 1,
                  maxLines: 5,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1,
                  ),
                  controller: widget.controller,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    hintText: widget.hintText,
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () async {
            if (showImage) {
              _toggleImage();
            }
            if (imageFile != null) {
              imageURL = await FirestoreService().uploadImage(
                  Provider.of<UserState>(context, listen: false).user.uid,
                  imageFile!);
              imageFile = null;
            }
            
            widget.onSend(imageURL);
          },
          icon: const Icon(
            Icons.send,
            color: Colors.lightBlue,
            size: 30,
          ),
        ),
      ],
    );
  }
}

Widget _image(String imageUrl) {
  return Container(
    constraints: const BoxConstraints(
      minHeight: 20.0,
      minWidth: 20.0,
    ),
    child: CachedNetworkImage(
      imageUrl: imageUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    ),
  );
}
