import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:helping_hand/availability_listing_pipeline/ReviewPersonListingScr.dart';
import 'package:helping_hand/services/UserState.dart';
import 'package:helping_hand/services/models.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

part 'InputAvailabilityController.dart';

class InputAvailabilityScr extends StatelessWidget {
  const InputAvailabilityScr({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Fill out the form to post a job",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 23, fontWeight: FontWeight.bold)),
          ),
          body: ChangeNotifierProvider(
            create: (context) => InputAvaState(
                Provider.of<UserState>(context, listen: false).user.location),
            child: Consumer<InputAvaState>(
              builder: (context, state, child) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              //location
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: GooglePlacesAutoCompleteTextFormField(
                                  maxLength: 15,
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
                                    hintText: "Enter your general location",
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
                                    state.location.text =
                                        prediction.description!,
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Choose up to 6 dates or range of dates:",
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
                                          selectedIndex: state.datesOrRange,
                                          selectedBackgroundColors: [
                                            Colors.green.shade600
                                          ],
                                          unSelectedBackgroundColors: const [
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
                                            "Date(s)",
                                            "Range of days"
                                          ],
                                          selectedLabelIndex: (index) {
                                            if (index == 1) {
                                              state.datesOrRange = 1;
                                            } else {
                                              state.datesOrRange = 0;
                                            }
                                          },
                                          isScroll: false,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        "Selected ${state._datesOrRange == 0 ? "dates" : "range"}: ${state._datesOrRange == 0 ? state.avaDates.map((e) => DateFormat.yMMMd().format(e)).join(", ") : DateFormat.yMMMd().format(state.startDate) + " - " + DateFormat.yMMMd().format(state.endDate)}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
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
                                                  WidgetStateProperty.all<
                                                          Color?>(
                                                      Colors.green.shade800)))),
                                  child: SfDateRangePicker(
                                    enablePastDates: false,
                                    showTodayButton: true,
                                    startRangeSelectionColor: Colors.lightGreen,
                                    endRangeSelectionColor: Colors.lightGreen,
                                    controller: state.dateRangePickerController,
                                    monthCellStyle:
                                        DateRangePickerMonthCellStyle(
                                      todayCellDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              103, 86, 255, 64),
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
                                    initialSelectedDate: state.startDate,
                                    initialSelectedRange: PickerDateRange(
                                        state.startDate, state.endDate),
                                    onSelectionChanged:
                                        state._onSelectionChanged,
                                    selectionMode: state.datesOrRange == 0
                                        ? DateRangePickerSelectionMode.multiple
                                        : DateRangePickerSelectionMode.range,
                                  ),
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
                                      "Need to be picked up?",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    activeColor: Colors.orange,
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    value: state.needPickup,
                                    onChanged: (bool? value) {
                                      state.needPickup = value!;
                                    },
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: TextField(
                                  minLines: 3,
                                  maxLines: 3,
                                  controller: state.avaDetails,
                                  decoration: const InputDecoration(
                                    labelText: "Availability Description",
                                    hintText:
                                        "Enter additional details about your availability \nYour profile description will be availble to employers",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton.icon(
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style!
                              .copyWith(
                                  backgroundColor: WidgetStateProperty.all(
                                      Colors.green.shade700)),
                          onPressed: () {
                            if (state.validateAva(context)) {
                              state.assembleAva(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReviewPersonListingScr(
                                    avaPosting: state.avaP,
                                  ),
                                ),
                              );
                            }
                          },
                          label: const Text("Submit"),
                          icon: const Icon(Icons.send),
                        ),
                      ]),
                );
              },
            ),
          )),
    );
  }
}
