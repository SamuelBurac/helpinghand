import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:helping_hand/components/CropPic.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/auth.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:helping_hand/services/models.dart';
import 'package:provider/provider.dart';
part 'ProfileSetupController.dart';

class ProfileSetupScr extends StatefulWidget {
  final thirdPartySignup;
  final User newUser;
  final String password;
  const ProfileSetupScr(
      {required this.thirdPartySignup, required this.newUser, required this.password, super.key});

  @override
  State<ProfileSetupScr> createState() => _ProfileSetupScrState();
}

class _ProfileSetupScrState extends State<ProfileSetupScr> {
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  File? _selectedImage;
  bool _displayPhoneNumber = false;
  bool warned = false;
  bool loading = false;

  @override
  void dispose() {
    descriptionController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0).copyWith(top: 50),
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (context, viewportConstraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text(
                            "Setup your profile",
                            style: TextStyle(fontSize: 40.0),
                          ),
                          _buildProfilePictureSection(),
                          _buildLocationSection(),
                          _buildDescriptionSection(),
                          _buildPhoneNumberDisplayOption(),
                          _buildSubmitButton(),
                        ],
                      ),
                    ),
                  );
                },
              ),
              if (loading) _buildLoadingOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePictureSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Profile picture",
          style: TextStyle(fontSize: 20),
        ),
        InkWell(
          onTap: () => _selectProfilePicture(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 35,
                child: _selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset("assets/emptyProfilePic.png"),
              ),
              const Text(
                "Lets add a profile picture",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildLocationSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Flexible(
          flex: 1,
          child: SizedBox(width: 15),
        ),
        const Flexible(
          flex: 4,
          child: Text(
            "Where are you located?",
            style: TextStyle(fontSize: 20),
          ),
        ),
        const Flexible(
          flex: 1,
          child: SizedBox(width: 5),
        ),
        Flexible(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GooglePlacesAutoCompleteTextFormField(
                cursorColor: Colors.orange,
                textEditingController: locationController,
                countries: const ['US'],
                googleAPIKey: dotenv.env['GOOGLE_API_KEY']!,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelStyle: const TextStyle(
                    color: Colors.orange,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 1.0,
                    ),
                  ),
                  labelText: "ZIP code / City, State",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                maxLines: 1,
                overlayContainer: (child) => Material(
                  elevation: 1.0,
                  color: Colors.grey.shade500,
                  borderRadius: BorderRadius.circular(12),
                  child: child,
                ),
                getPlaceDetailWithLatLng: (prediction) {
                  SnackBar(
                    content: Text('placeDetails${prediction.lat}'),
                  );
                },
                itmClick: (prediction) {
                  locationController.text = prediction.description!;
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  "This is used to sort jobs based on distance",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Description of previous experience",
          style: TextStyle(fontSize: 20),
        ),
        Flexible(
          child: TextField(
            controller: descriptionController,
            minLines: 4,
            maxLines: 5,
            decoration: const InputDecoration(
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
              hintText:
                  "Talk about your previous experiences, the work that you do, or any other information you want to share to future connections.",
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumberDisplayOption() {
    return CheckboxListTile(
      title: const Text(
        "Display phone number on profile so that people can contact you?",
        style: TextStyle(fontSize: 17),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      value: _displayPhoneNumber,
      activeColor: Colors.orange,
      onChanged: (bool? value) {
        setState(() {
          _displayPhoneNumber = value!;
        });
      },
    );
  }

  Widget _buildSubmitButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(color: Colors.grey),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () => _handleSubmit(),
              icon: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoadingOverlay() {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        Center(
          child: LoadingAnimationWidget.inkDrop(
            color: const Color.fromARGB(255, 255, 123, 21),
            size: 100,
          ),
        ),
      ],
    );
  }

  void _selectProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File? croppedImage = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CropPic(
            imageFile: File(pickedFile.path),
          ),
        ),
      );

      setState(() {
        _selectedImage = croppedImage;
      });
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('You must select a profile picture'),
          content: const Text('You need a profile picture to continue.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _handleSubmit() async {
    if (_selectedImage == null) {
      _showAlert('You must select a profile picture',
          'You need a profile picture to continue.');
    } else if (locationController.text.isEmpty) {
      _showAlert(
          'You must enter a location', 'You need a location to continue.');
    } else if (descriptionController.text.isEmpty && !warned) {
      warned = true;
      _showAlert('You should enter a description',
          'This is like your resume to potential partners.');
    } else {
      setState(() {
        loading = true;
      });

      try {
        Provider.of<UserState>(context, listen: false).user =
            await submitProfileData(
          widget.thirdPartySignup,
          widget.newUser,
          widget.password,
          _selectedImage!,
          locationController.text,
          descriptionController.text,
          _displayPhoneNumber,
        );
        Navigator.pushNamed(context, '/congrats');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error creating account: $e")),
        );
      } finally {
        setState(() {
          loading = false;
        });
      }
    }
  }

  void _showAlert(String title, String content) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
