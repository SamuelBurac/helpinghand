part of 'InputJobScr.dart';

JobPosting jobPosting = JobPosting();

class InputJobState with ChangeNotifier {
    final _locationController = TextEditingController();
    var jobTitleController = TextEditingController();
    var jobDescriptionController = TextEditingController();
    var payController = TextEditingController();
    bool _oneDayJob = true;
    int _dOrR = 0;
    bool canPickup = false;

    DateTime _startTime = DateTime.now();
    DateTime _endTime = DateTime.now();
    DateTime _startDate = DateTime.now();
    DateTime _endDate = DateTime.now();
    DateTime _onlyDay = DateTime.now();
    Duration _duration = Duration();

    double _hoursEstimated = 0;
    int _payPerhour = 0;
    int _pay = 0;



    TextEditingController get jobTitle => jobTitleController;
    TextEditingController get location => _locationController;
    TextEditingController get jobDescription => jobDescriptionController;
    TextEditingController get pay => payController;

    bool get oneDayJob => _oneDayJob;
    int get dOrR => _dOrR;
    bool get pickup => canPickup;

    DateTime get startTime => _startTime;
    DateTime get endTime => _endTime;
    
    DateTime get onlyDay => _onlyDay;
    DateTime get startDate => _startDate;
    DateTime get endDate => _endDate;

    set startDate (DateTime value) {
        _startDate = value;
        notifyListeners();
    }
    set endDate (DateTime value) {
        _endDate = value;
        notifyListeners();
    }
    set onlyDay (DateTime value) {
        _onlyDay = value;
        notifyListeners();
    }

    set startTime (DateTime value) {
        _startTime = value;
        _duration = _endTime.difference(_startTime);
    }
    set endTime (DateTime value) {
        _endTime = value;
        _duration = _endTime.difference(_startTime);
    }

    set pickup (bool value) {
        canPickup = value;
        notifyListeners();
    }

    set dOrR (int value) {
        _dOrR = value;
        notifyListeners();
    }

    set oneDayJob(bool value) {
        _oneDayJob = value;
        notifyListeners();
    }

void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
   if (args.value is PickerDateRange) {
          _startDate = args.value.startDate;
          _endDate = args.value.endDate;
          notifyListeners();
        } else if (args.value is DateTime) {
          _onlyDay = args.value;
          notifyListeners();
        } 

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
