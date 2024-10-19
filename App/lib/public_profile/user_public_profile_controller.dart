part of 'UserPublicProfileScr.dart';

class PublicProfileState with ChangeNotifier {
  User? _displayedUser;
  User? _currentUser;
  double _overallRating = 0.0;
  int _numReviews = 0;
  double _rating = 0.0;
  bool _submittedReview = false;
  bool _canReview = false;
  bool _hasReviewed = false; 
  final TextEditingController _reviewController = TextEditingController();

  //constructor for the class
  PublicProfileState(User user, User currentUser, bool canReview, bool hasReviewed) {
    _displayedUser = user;
    _overallRating = user.rating;
    _numReviews = user.numReviews;
    _currentUser = currentUser;
    _canReview = canReview;
    _hasReviewed = hasReviewed;
  }
  TextEditingController get reviewController => _reviewController;

  double get rating => _rating;

  bool get canReview => _canReview;
  bool get hasReviewed => _hasReviewed;

  set canReview(bool value) {
    _canReview = value;
    notifyListeners();
  }
  set hasReviewed(bool value) {
    _hasReviewed = value;
    notifyListeners();
  }

  set rating(double value) {
    _rating = value;
    notifyListeners();
  }

  get submittedReview => _submittedReview;

  double get overallRating => _overallRating;
  int get numReviews => _numReviews;

  Future<void> submitReview() async {
    try {
      if (_reviewController.text.isNotEmpty || _rating != 0.0) {
        final Review review = Review(
          revieweeID: _displayedUser!.uid,
          reviewerID: _currentUser!.uid,
          reviewerPfpURL: _currentUser!.pfpURL,
          reviewerName: "${_currentUser!.firstName} ${_currentUser!.lastName}",
          reviewText: _reviewController.text,
          rating: _rating,
          reviewDate: DateTime.now(),
        );

        await FirestoreService().addReview(review);

        
        _displayedUser!.rating = (_numReviews == 0)
              ? _rating
              : (_displayedUser!.rating * (_numReviews) +
                      _rating) /
                  (_numReviews + 1);
        _displayedUser!.numReviews++;

        await FirestoreService().updateUser(_displayedUser!);
        await FirestoreService().updatePostingsRating(_displayedUser!.uid, _displayedUser!.rating);

        _overallRating = _displayedUser!.rating;
        _numReviews++;
        _reviewController.clear();



        _submittedReview = true;


        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  void onDelete() {
    _reviewController.clear();
    _rating = 0.0;
    _submittedReview = false;
    _hasReviewed = false;
    notifyListeners();
  }


}
