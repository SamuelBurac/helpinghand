part of 'InputJobScr.dart';

class InputJobState with ChangeNotifier {
  bool? isEditing = false;
  JobPosting? jobPosting = JobPosting();
  String _jobID = "";
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
  final DateRangePickerController _datePickerController =
      DateRangePickerController();

  TextEditingController get jobTitle => jobTitleController;
  TextEditingController get location => _locationController;
  TextEditingController get jobDescription => jobDescriptionController;
  TextEditingController get pay => payController;

  InputJobState({this.isEditing = false, this.jobPosting}) {
    if (isEditing != null && isEditing! && jobPosting != null) {
      _jobID = jobPosting!.jobID;
      jobTitleController.text = jobPosting!.jobTitle;
      _locationController.text = jobPosting!.jobLocation;
      jobDescriptionController.text = jobPosting!.jobDetails;
      payController.text = jobPosting!.jobPay.toString();
      _startTime = DateFormat('h:mm a').parse(jobPosting!.jobStartTime);
      _endTime = DateFormat('h:mm a').parse(jobPosting!.jobEndTime);
      _oneDayJob = jobPosting!.oneDay;
      _onlyDay = DateFormat('MM/dd/yyyy').parse(jobPosting!.onlyDay!);
      _startDate = DateFormat('MM/dd/yyyy').parse(jobPosting!.startDate!);
      _endDate = DateFormat('MM/dd/yyyy').parse(jobPosting!.endDate!);
      _duration = Duration(hours: jobPosting!.jobDuration);
      _datePickerController.selectedDate = _onlyDay;
      _datePickerController.selectedRange =
          PickerDateRange(_startDate, _endDate);
      canPickup = jobPosting!.canPickup;
    }
  }

  bool get oneDayJob => _oneDayJob;
  int get dOrR => _dOrR;
  bool get pickup => canPickup;

  DateTime get startTime => _startTime;
  DateTime get endTime => _endTime;
  DateTime get onlyDay => _onlyDay;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  DateRangePickerController get datePickerController => _datePickerController;
  JobPosting? get job => jobPosting;

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
      jobID: _jobID,
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
    if (payController.text.isEmpty ||
        !RegExp(r'^\d+$').hasMatch(payController.text)) {
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

  void updateDatabase() {
    FirestoreService().updateJob(jobPosting!);
  }
}
