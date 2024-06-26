part of 'InputJobScr.dart';

JobPosting jobPosting = JobPosting();

class InputJobState with ChangeNotifier {
    var _locationController = TextEditingController();
    var jobTitleController = TextEditingController();
    var jobDescriptionController = TextEditingController();
    bool _oneDayJob = true;
    int _dOrR = 0;
    bool canPickup = false;


    TextEditingController get location => _locationController;

    bool get oneDayJob => _oneDayJob;
    int get dOrR => _dOrR;

    set dOrR (int value) {
        _dOrR = value;
        notifyListeners();
    }

    set oneDayJob(bool value) {
        _oneDayJob = value;
        notifyListeners();
    }

void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
  
  
}
void submitJob() {
  // Submit the job to the database
  // ...
  
  
}

bool validateJob() {
  // Validate the job
  // ...
  
  return true;
}

}
