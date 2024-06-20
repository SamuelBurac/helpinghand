import 'package:flutter/material.dart';
import 'package:progressive_time_picker/progressive_time_picker.dart';


//https://pub.dev/packages/progressive_time_picker todo this must add date picker

class InputJobScr extends StatelessWidget {
  const InputJobScr({super.key});

  @override
  Widget build(BuildContext context) {
    var canPickup = false;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Fill out the form to post a job listing."),
            const TextField(
              decoration: InputDecoration(
                labelText: "Job Title",
                hintText: "Enter the title of the job",
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: "location",
                hintText: "Location of the job",
              ),
            ),
            TimePicker(
              initTime: PickedTime(h: 9, m: 0),
              endTime: PickedTime(h: 17, m: 0),
              primarySectors: 24,
              secondarySectors: 48,
              decoration: TimePickerDecoration(
                baseColor: const Color(0xFF1F2633),
                pickerBaseCirclePadding: 15.0,
                sweepDecoration: TimePickerSweepDecoration(
                  pickerStrokeWidth: 30.0,
                  pickerColor:  Colors.amber.shade700,
                  showConnector: true,
                ),
                initHandlerDecoration: TimePickerHandlerDecoration(
                  color: const Color(0xFF141925),
                  shape: BoxShape.circle,
                  radius: 12.0,
                  icon: const Icon(
                    Icons.work_outline,
                    size: 20.0,
                    color: Color(0xFF3CDAF7),
                  ),
                ),
                endHandlerDecoration: TimePickerHandlerDecoration(
                  color: const Color(0xFF141925),
                  shape: BoxShape.circle,
                  radius: 12.0,
                  icon: const Icon(
                    Icons.home,
                    size: 20.0,
                    color: Color(0xFF3CDAF7),
                  ),
                ),
                primarySectorsDecoration: TimePickerSectorDecoration(
                  color: Colors.white,
                  width: 1.0,
                  size: 4.0,
                  radiusPadding: 25.0,
                ),
                secondarySectorsDecoration: TimePickerSectorDecoration(
                  color: const Color(0xFF3CDAF7),
                  width: 1.0,
                  size: 2.0,
                  radiusPadding: 25.0,
                ),
                clockNumberDecoration: TimePickerClockNumberDecoration(
                  defaultTextColor: Colors.white,
                  defaultFontSize: 12.0,
                  scaleFactor: 2.0,
                  showNumberIndicators: true,
                  clockTimeFormat: ClockTimeFormat.twentyFourHours,
                  clockIncrementTimeFormat: ClockIncrementTimeFormat.fiveMin,
                ),
              ),
              onSelectionChange: (start, end, isDisableRange) => print(
                  'onSelectionChange => init : ${start.h}:${start.m}, end : ${end.h}:${end.m}, isDisableRangeRange: $isDisableRange'),
              onSelectionEnd: (start, end, isDisableRange) => print(
                  'onSelectionEnd => init : ${start.h}:${start.m}, end : ${end.h}:${end.m},, isDisableRangeRange: $isDisableRange'),
            
            
            
            ),
            CheckboxListTile(
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
            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Job Pay",
                hintText: "\$150",
              ),
            ),
            const TextField(
              decoration: InputDecoration(
                labelText: "Job Description",
                hintText: "Enter the description of the job",
              ),
            ),
          ]),
    ));
  }
}
