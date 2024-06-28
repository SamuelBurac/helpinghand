part of 'InputJobScr.dart';

class InputJobState with ChangeNotifier {
  JobPosting jobPosting = JobPosting();
  final _locationController = TextEditingController();
  var jobTitleController = TextEditingController();
  var jobDescriptionController = TextEditingController();
  var payController = TextEditingController();
  bool _oneDayJob = true;
  int _dOrR = 0;
  bool canPickup = false;

  DateTime _startTime = DateTime.parse("2011-07-06 09:00:00");
  DateTime _endTime = DateTime.parse("2011-07-06 17:00:00");
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 3));
  DateTime _onlyDay = DateTime.now();
  Duration _duration = const Duration(hours: 8);

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

  JobPosting get job => jobPosting;

  set startDate(DateTime value) {
    _startDate = value;
    notifyListeners();
  }

  set endDate(DateTime value) {
    _endDate = value;
    notifyListeners();
  }

  set onlyDay(DateTime value) {
    _onlyDay = value;
    notifyListeners();
  }

  set startTime(DateTime value) {
    _startTime = value;
    _duration = _endTime.difference(_startTime);
  }

  set endTime(DateTime value) {
    _endTime = value;
    _duration = _endTime.difference(_startTime);
  }

  set pickup(bool value) {
    canPickup = value;
    notifyListeners();
  }

  set dOrR(int value) {
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

  void assembleJob(context) {
    int duration = _duration.inHours;
    int pay = int.parse(payController.text);

    jobPosting = JobPosting(
      jobTitle: jobTitleController.text,
      jobLocation: _locationController.text,
      jobDetails: jobDescriptionController.text,
      jobStartTime: DateFormat('h:mm a').format(_startTime),
      jobEndTime: DateFormat('h:mm a').format(_endTime),
      oneDay: _oneDayJob,
      onlyDay: DateFormat('MM/dd/yyyy').format(_onlyDay),
      startDate: DateFormat('MM/dd/yyyy').format(_startDate),
      endDate: DateFormat('MM/dd/yyyy').format(_endDate),
      jobPay: pay,
      jobDuration: duration,
      hourlyRate: pay / duration,
      jobPosterName:
          "${Provider.of<UserState>(context, listen: false).user.firstName} ${Provider.of<UserState>(context, listen: false).user.lastName}",
      jobPosterID: Provider.of<UserState>(context, listen: false).user.uid,
      canPickup: canPickup,
      rating: Provider.of<UserState>(context, listen: false).user.rating,
      pfpURL: Provider.of<UserState>(context, listen: false).user.pfpURL,
      jobID: " ",
    );
  }

  bool validateJob(context) {
    var isMissing = [];
    bool isValid = true;
    if (jobTitleController.text.isEmpty) {
      isMissing.add("Job Title");
      isValid = false;
    }
    if (_locationController.text.isEmpty) {
      isMissing.add("Location");
      isValid = false;
    }
    if (jobDescriptionController.text.isEmpty) {
      isMissing.add("Description");
      isValid = false;
    }
    if (payController.text.isEmpty) {
      isMissing.add("Pay");
      isValid = false;
    }
    if (!isValid) {
      String missing = isMissing.join(", ");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          content: Text(
            'The field(s) $missing are invalid. Please correct them.',
            style: const TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
          ),
        ),
      );
    }

    return isValid;
  }
}
