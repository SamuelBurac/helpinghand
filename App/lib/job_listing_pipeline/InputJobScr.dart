import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:helping_hand/job_listing_pipeline/ReviewJobListingScr.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/firestore.dart';
import 'package:helping_hand/services/models.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

part 'InputJobController.dart';

class InputJobScr extends StatelessWidget {
  final bool? isEditing;
  final JobPosting? jobPosting;
  const InputJobScr({super.key, this.isEditing, this.jobPosting});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text((isEditing != null && isEditing!) ? "Edit Job Posting" : "Fill out the form to post a job",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 23, fontWeight: FontWeight.bold)),
          ),
          body: ChangeNotifierProvider(
            create: (context) => InputJobState(isEditing: isEditing, jobPosting: jobPosting),
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
                              TextField(
                                controller: state.jobTitle,
                                maxLength: 30,
                                decoration: const InputDecoration(
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
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Theme(
                                          data: ThemeData(
                                            buttonTheme: const ButtonThemeData(),
                                          ),
                                          child: FlutterToggleTab(
                                            width: 75,
                                            borderRadius: 20,
                                            height: 30,
                                            selectedIndex: state.dOrR,
                                            selectedBackgroundColors: [
                                              Colors.orange.shade600
                                            ],
                                            unSelectedBackgroundColors: [
                                              Colors.amber.shade600
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
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        "Selected ${state.oneDayJob ? "day: ${DateFormat('MM/dd/yy').format(state.onlyDay)}" : "range of days: ${DateFormat('MM/dd/yy').format(state.startDate)} - ${DateFormat('MM/dd/yy').format(state.endDate)} "}",
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
                                          ? const ColorScheme.dark().copyWith(
                                              primary: Colors
                                                  .white, // Color for dark mode
                                              secondary: Colors
                                                  .orange, // Color for dark mode
                                            )
                                          : const ColorScheme.light().copyWith(
                                              primary: Colors
                                                  .black, // Color for light mode
                                              secondary: Colors
                                                  .blue, // Color for light mode
                                            ),
                                      textButtonTheme: TextButtonThemeData(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all<Color?>(
                                                      Colors.orange.shade800)))),
                                  child: SfDateRangePicker(
                                    controller: state.datePickerController,
                                    enablePastDates: false,
                                    showTodayButton: true,
                                    backgroundColor: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.black
                                      : Colors.grey.shade800,
                                    startRangeSelectionColor: Colors.orangeAccent.shade700,
                                    endRangeSelectionColor: Colors.orangeAccent.shade700,
                                    monthCellStyle: DateRangePickerMonthCellStyle(
                                      textStyle: TextStyle(
                                        color: Theme.of(context).brightness == Brightness.dark
                                          ? Colors.white
                                          : Colors.grey.shade100,
                                      ),
                                     
                                      todayCellDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.deepOrange.shade500,
                                        ),
                                      ),
                                      todayTextStyle: TextStyle(
                                          color: Colors.orange.shade500,
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
                                    selectionColor: Colors.orange.shade800,
                                    rangeSelectionColor:
                                        Colors.orange.shade800.withOpacity(0.5),
                                    initialSelectedDate: state.startDate,
                                    initialSelectedRange: PickerDateRange(
                                        state.startDate, state.endDate
                                        ),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text("Start Time:"),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TimePickerSpinnerPopUp(
                                          mode: CupertinoDatePickerMode.time,
                                          initTime: state.startTime,
                                          use24hFormat: false,
                                          timeFormat: "hh:mm a",
                                          minuteInterval: 5,
                                          onChange: (dateTime) {
                                            state.startTime = dateTime;
                                          },
                                        ),
                                      ],
                                    ),
                                    const VerticalDivider(),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text("End Time:"),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TimePickerSpinnerPopUp(
                                          mode: CupertinoDatePickerMode.time,
                                          initTime: state.endTime,
                                          use24hFormat: false,
                                          timeFormat: "hh:mm a",
                                          minuteInterval: 5,
                                          onChange: (dateTime) {
                                            state.endTime = dateTime;
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          width: 1.0, color: Colors.grey),
                                      bottom: BorderSide(
                                          width: 1.0, color: Colors.grey),
                                    ),
                                  ),
                                  child: CheckboxListTile(
                                    title: const Text(
                                      "Willing to pick up workers?",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    activeColor: Colors.orange,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    value: state.pickup,
                                    onChanged: (bool? value) {
                                      state.pickup = value!;
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: TextField(
                                  controller: state.pay,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: "Job Pay",
                                    hintText: "Per diem",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: TextField(
                                  minLines: 2,
                                  maxLines: 5,
                                  controller: state.jobDescription,
                                  decoration: const InputDecoration(
                                    labelText: "Job Description",
                                    hintText: "Enter the description of the job",
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  (isEditing != null && isEditing!) ? ElevatedButton.icon(
                                    style: Theme.of(context)
                                        .elevatedButtonTheme
                                        .style!
                                        .copyWith(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.orange.shade700)),
                                    onPressed: () {
                                      if (state.validateJob(context)) {
                                        state.assembleJob(context);
                                        state.updateDatabase();
                                        Navigator.pop(context);
                                      }
                                    },
                                    label: const Text("Update"),
                                    icon: const Icon(Icons.send),
                                  ) : ElevatedButton.icon(
                                    style: Theme.of(context)
                                        .elevatedButtonTheme
                                        .style!
                                        .copyWith(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.orange.shade700)),
                                    onPressed: () {
                                      if (state.validateJob(context)) {
                                        state.assembleJob(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ReviewListingScr(
                                                    jobPosting: state.job!),
                                          ),
                                        );
                                      }
                                    },
                                    label: const Text("Submit"),
                                    icon: const Icon(Icons.send),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
                );
              },
            ),
          )),
    );
  }
}
