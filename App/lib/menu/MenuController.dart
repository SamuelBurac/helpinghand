part of 'MenuScr.dart';


class PostingsState with ChangeNotifier {
    late BuildContext context;
    late bool _showJobListings;
    late bool _showAvailabilityListings;
    late final bool _giveOptions;

    PostingsState(this.context) {
        _showJobListings = Provider.of<UserState>(context, listen: false).user.lookingForWorkers;
        _showAvailabilityListings = Provider.of<UserState>(context, listen: false).user.lookingForWork;
        _giveOptions = _showAvailabilityListings && _showJobListings;
    }

    int _selectedLabelIndex = 0;

    int get selectedLabelIndex => _selectedLabelIndex;

    set selectedLabelIndex(int value) {
        _selectedLabelIndex = value;
        notifyListeners();
    }

    bool get giveOptions => _giveOptions;
    bool get showAvailabilityListings => _showAvailabilityListings;
    bool get showJobListings => _showJobListings;

    set showAvailabilityListings(bool value) {
        _showAvailabilityListings = value;
        notifyListeners();
    }

    set showJobListings(bool value) {
        _showJobListings = value;
        notifyListeners();
    }

}

