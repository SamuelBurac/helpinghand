import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

part 'InputJobController.dart';

class InputJobScr extends StatelessWidget {
  const InputJobScr({super.key});

  @override
  Widget build(BuildContext context) {
    var canPickup = false;

    var locationController = TextEditingController();
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 5),
              child: Text("Fill out the form to post a job listing.",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontSize: 23, fontWeight: FontWeight.bold)),
            ),
            const Divider(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 18.0),
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Job Title",
                      hintText: "Enter the title of the job",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: GooglePlacesAutoCompleteTextFormField(
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
                        labelText: "Location",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      // proxyURL: _yourProxyURL,
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
                      itmClick: (prediction) => {
                        locationController.text = prediction.description!,
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Start Time:"),
                        const SizedBox(
                          width: 30,
                        ),
                        TimePickerSpinnerPopUp(
                          mode: CupertinoDatePickerMode.time,
                          initTime: DateTime.parse("2011-07-06 08:00:00"),
                          use24hFormat: false,
                          timeFormat: "hh:mm a",
                          minuteInterval: 5,
                          onChange: (dateTime) {
                            // Implement your logic with select dateTime
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("End Time:"),
                        const SizedBox(
                          width: 30,
                        ),
                        TimePickerSpinnerPopUp(
                          mode: CupertinoDatePickerMode.time,
                          initTime: DateTime.parse("2011-07-06 08:00:00"),
                          use24hFormat: false,
                          timeFormat: "hh:mm a",
                          minuteInterval: 5,
                          onChange: (dateTime) {
                            // Implement your logic with select dateTime
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: CheckboxListTile(
                      title: const Text(
                        "Looking for work?",
                        style: TextStyle(fontSize: 20),
                      ),
                      activeColor: Colors.orange,
                      controlAffinity: ListTileControlAffinity.trailing,
                      value: canPickup,
                      onChanged: (bool? value) {
                        canPickup = value!;
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 18.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Job Pay",
                        hintText: "\$150",
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 18.0),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Job Description",
                        hintText: "Enter the description of the job",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              style: Theme.of(context).elevatedButtonTheme.style!,
              onPressed: () {
                submitJob();
                Navigator.pushNamed(context, "/reviewJob");
              },
              label: Text("Submit"),
              icon: Icon(Icons.send),
            ),
          ]),
    ));
  }
}
