part of 'InputAvailabilityScr.dart';

class InputAvaState with ChangeNotifier {
  AvailabilityPosting avaPosting = AvailabilityPosting();
  late TextEditingController _locationController;
  final avaDetailsController = TextEditingController();
  final _datePickerController = DateRangePickerController();
  int _datesOrRange = 0;
  bool _needPickup = false;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 3));
  List<DateTime> _avaDates = [DateTime.now()];
  String _postID = "";


  InputAvaState(String location, {bool? isEdit = false, AvailabilityPosting? ava} ) {
    if (isEdit!= null && ava != null && isEdit) {
      
      avaPosting = ava;
      _postID = ava.avaPostID;
      _locationController = TextEditingController(text: ava.generalLocation);
      avaDetailsController.text = ava.availabilityDetails;
      _startDate = DateFormat('MM/dd/yy').parse(ava.startDate!);
      _endDate = DateFormat('MM/dd/yy').parse(ava.endDate!);
      _avaDates = ava.availabilityDates!
          .map((date) => DateFormat('MM/dd/yy').parse(date))
          .toList();
      _datePickerController.selectedDates = _avaDates;
      _datesOrRange = ava.rangeOfDates ? 1 : 0;
      _needPickup = ava.needsPickup;
    } else {
      _locationController = TextEditingController(
          text: location.length >= 15 ? location.substring(0, 15) : location);
    }
 
  }

  get dateRangePickerController => _datePickerController;


  TextEditingController get location => _locationController;
  TextEditingController get avaDetails => avaDetailsController;

  AvailabilityPosting get avaP => avaPosting;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  List<DateTime> get avaDates => _avaDates;
  bool get needPickup => _needPickup;
  int get datesOrRange => _datesOrRange;


  set needPickup(bool value) {
    _needPickup = value;
    notifyListeners();
  }

  set startDate(DateTime value) {
    _startDate = value;
    notifyListeners();
  }

  set endDate(DateTime value) {
    _endDate = value;
    notifyListeners();
  }

  set datesOrRange(int value) {
    _datesOrRange = value;
    notifyListeners();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      _startDate = args.value.startDate ?? _startDate;
      _endDate = args.value.endDate ?? _endDate;
      notifyListeners();
    } else if (args.value is List<DateTime>) {
      if (args.value.length <= 6) {
        _avaDates = args.value;
        notifyListeners();
      } else {
        _datePickerController.selectedDates = _avaDates;
        notifyListeners();
      }
    }
  }

  bool validateAva(context) {
    if (_locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          content: Text(
            'Please enter a location.',
            style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
          ),
        ),
      );
      return false;
    }
    if (avaDetailsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          content: Text(
            'Please enter availability details, this is the first thing future employers will see.',
            style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
          ),
        ),
      );
      return false;
    }
    if (_datesOrRange == 0) {
      if (_avaDates.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            content: Text(
              'Please select at least one date.',
              style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
            ),
          ),
        );
        return false;
      }
    }
    return true;
  }

  void assembleAva(context) {
    avaPosting = AvailabilityPosting(
      generalLocation: _locationController.text,
      availabilityDetails: avaDetailsController.text,
      startDate: DateFormat('MM/dd/yy').format(_startDate),
      endDate: DateFormat('MM/dd/yy').format(_endDate),
      availabilityDates:
          _avaDates.map((date) => DateFormat('MM/dd/yy').format(date)).toList(),
      rangeOfDates: _datesOrRange == 1,
      needsPickup: _needPickup,
      jobPosterName:
          "${Provider.of<UserState>(context, listen: false).user.firstName} ${Provider.of<UserState>(context, listen: false).user.lastName}",
      posterID: Provider.of<UserState>(context, listen: false).user.uid,
      rating: Provider.of<UserState>(context, listen: false).user.rating,
      pfpURL: Provider.of<UserState>(context, listen: false).user.pfpURL,
      avaPostID: _postID,
    );

  }

  void updateDatabase() async{
    FirestoreService().updateAvailability(avaPosting);
  }
}
