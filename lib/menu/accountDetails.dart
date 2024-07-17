import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helping_hand/menu/MenuScr.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';
import 'package:provider/provider.dart';
part 'accountDetailsController.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Details'),
      ),
      body: SingleChildScrollView(
        child: ChangeNotifierProvider(
          create: (context) => AccountDetailsController(context),
          child: Consumer<AccountDetailsController>(
            builder: (context, controller, child) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    EditTextWithButton(
                      controller: controller.firstNameController,
                      labelText: "First Name",
                    ),
                    const Divider(),
                    EditTextWithButton(
                      controller: controller.lastNameController,
                      labelText: "Last Name",
                    ),
                    const Divider(),
                    EditTextWithButton(
                      controller: controller.emailController,
                      labelText: "Email",
                    ),
                    const Divider(),
                    EditTextWithButton(
                      controller: controller.phoneNumberController,
                      labelText: "Phone Number",
                    ),
                    const Divider(),
                    EditTextWithButton(
                      controller: controller.locationController,
                      labelText: "Location",
                    ),
                    const Divider(),
                    EditTextWithButton(
                      controller: controller.descriptionController,
                      labelText: "Description",
                    ),
                    const Divider(),
                    CheckboxListTile(
                      title: const Text(
                        "Display phone number on profile page?",
                        style: TextStyle(fontSize: 20),
                      ),
                      activeColor: Colors.orange,
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: controller.displayPhoneNumber,
                      onChanged: (bool? value) {
                        controller.setDisplayPhoneNumber = value!;
                      },
                    ),
                    const Divider(),
                    CheckboxListTile(
                      title: const Text(
                        "Looking for work?",
                        style: TextStyle(fontSize: 20),
                      ),
                      activeColor: Colors.orange,
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: controller.lookingForWork,
                      onChanged: (bool? value) {
                        controller.setLookingForWork = value!;
                      },
                    ),
                    const Divider(),
                    CheckboxListTile(
                      title: const Text(
                        "Looking for workers?",
                        style: TextStyle(fontSize: 20),
                      ),
                      activeColor: Colors.orange,
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: controller.lookingForWorkers,
                      onChanged: (bool? value) {
                        controller.setLookingForWorkers = value!;
                      },
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.delete_forever_rounded),
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style!
                                .copyWith(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.red),
                                ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Delete Account"),
                                    content: const Text(
                                        "Are you sure you want to delete your account?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        style: Theme.of(context)
                                            .textButtonTheme
                                            .style!
                                            .copyWith(
                                              backgroundColor:
                                                  WidgetStateProperty.all<
                                                      Color>(Colors.red),
                                            ),
                                        onPressed: () {
                                          FirestoreService().deleteUser(
                                              Provider.of<UserState>(context,
                                                      listen: false)
                                                  .user);
                                          Provider.of<UserState>(context,
                                                  listen: false)
                                              .user = User();
                                          Navigator.popAndPushNamed(
                                              context, "/");
                                        },
                                        child: const Text("Delete"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            label: const Text("Delete Account"),
                          ),
                          ElevatedButton(
                            style: Theme.of(context)
                                .elevatedButtonTheme
                                .style!
                                .copyWith(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.green),
                                ),
                            onPressed: () {
                              if (controller.verifyInputs()) {
                                controller.updateProfile();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MenuScr()));
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Error"),
                                      content: const Text(
                                          "Please fill out all fields"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("OK"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text("Update"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
