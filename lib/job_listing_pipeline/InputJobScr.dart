import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:helping_hand/services/models.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

part 'InputJobController.dart';

class InputJobScr extends StatelessWidget {
  const InputJobScr({super.key});

  @override
  Widget build(BuildContext context) {
    var canPickup = false;
    var state;
    return Scaffold(
        appBar: AppBar(
          title: Text("Fill out the form to post a job",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontSize: 23, fontWeight: FontWeight.bold)),
        ),
        body: ChangeNotifierProvider(
          create: (context) => InputJobState(),
          child: Consumer<InputJobState>(
            builder: (context, state, child) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
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
                            //location
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: GooglePlacesAutoCompleteTextFormField(
                                cursorColor: Colors.orange,
                                textEditingController: state.location,
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
                                    content:
                                        Text('placeDetails${prediction.lat}'),
                                  );
                                },
                                itmClick: (prediction) => {
                                  state.location.text = prediction.description!,
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Choose a date or range of dates:",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Theme(
                                      data: ThemeData(
                                        buttonTheme: const ButtonThemeData(),
                                      ),
                                      child: FlutterToggleTab(
                                        width: 60,
                                        borderRadius: 20,
                                        height: 30,
                                        selectedIndex: state.dOrR,
                                        selectedBackgroundColors: [
                                          Colors.green.shade600
                                        ],
                                        unSelectedBackgroundColors: const[
                                          Color.fromARGB(255, 154, 238, 198)
                                        ],
                                        selectedTextStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                        unSelectedTextStyle: const TextStyle(
                                            color: Color.fromARGB(
                                                202, 69, 90, 100),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                        labels: const [
                                          "one day",
                                          "Range of days"
                                        ],
                                        selectedLabelIndex: (index) {
                                          if (index == 1) {
                                            state.oneDayJob = false;
                                            state.dOrR = 1;
                                          } else {
                                            state.oneDayJob = true;
                                            state.dOrR = 0;
                                          }
                                        },
                                        isScroll: false,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      "Selected ${state.oneDayJob ? "day: " : "range of days: "}",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: MediaQuery.of(context)
                                              .platformBrightness ==
                                          Brightness.dark
                                      ? ColorScheme.dark().copyWith(
                                          primary: Colors
                                              .white, // Color for dark mode
                                          secondary: Colors
                                              .orange, // Color for dark mode
                                        )
                                      : ColorScheme.light().copyWith(
                                          primary: Colors
                                              .black, // Color for light mode
                                          secondary: Colors
                                              .blue, // Color for light mode
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: ButtonStyle(
                                            backgroundColor: WidgetStateProperty.all<Color?>(Colors.green.shade800)
                                          )
                                        )
                                ),
                                child: SfDateRangePicker(
                                  enablePastDates: false,
                                  showActionButtons: true,
                                  showTodayButton: true,
                                  startRangeSelectionColor: Colors.lightGreen,
                                  endRangeSelectionColor: Colors.lightGreen,
                                  monthCellStyle: DateRangePickerMonthCellStyle(
                                    todayCellDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Color.fromARGB(103, 86, 255, 64),
                                      ),
                                    ),
                                    todayTextStyle: TextStyle(
                                        color: Colors.green.shade500,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  selectionShape:
                                      DateRangePickerSelectionShape.rectangle,
                                  navigationMode:
                                      DateRangePickerNavigationMode.scroll,
                                  navigationDirection:
                                      DateRangePickerNavigationDirection
                                          .vertical,
                                  monthViewSettings:
                                      const DateRangePickerMonthViewSettings(
                                    enableSwipeSelection: true,
                                  ),
                                  selectionColor: Colors.green.shade800,
                                  rangeSelectionColor:
                                      Colors.green.shade800.withOpacity(0.5),
                                  initialSelectedDate: DateTime.now(),
                                  initialSelectedRange: PickerDateRange(
                                      DateTime.now(),
                                      DateTime.now()
                                          .add(const Duration(days: 3))),
                                  onSelectionChanged: state._onSelectionChanged,
                                  selectionMode: state.oneDayJob
                                      ? DateRangePickerSelectionMode.single
                                      : DateRangePickerSelectionMode.range,
                                ),
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
                                    initTime:
                                        DateTime.parse("2011-07-06 08:00:00"),
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
                                    initTime:
                                        DateTime.parse("2011-07-06 08:00:00"),
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
                                  "Willing to pick up workers?",
                                  style: TextStyle(fontSize: 20),
                                ),
                                activeColor: Colors.orange,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                value: canPickup,
                                onChanged: (bool? value) {
                                  state.canPickup = value!;
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
                        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                          backgroundColor: WidgetStateProperty.all(Colors.green.shade700)
                        ),
                        onPressed: () {
                          if (state.validateJob()) {
                            state.submitJob();
                            Navigator.pushNamed(context, "/reviewJob");
                          }
                        },
                        label: const Text("Submit"),
                        icon: const Icon(Icons.send),
                      ),
                    ]),
              );
            },
          ),
        ));
  }
}
