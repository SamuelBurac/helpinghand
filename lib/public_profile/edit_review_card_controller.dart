part of 'edit_review_card.dart';

class EditReviewCardController extends ChangeNotifier {
  late Review _review;
  double _rating = 0.0;
  final TextEditingController _reviewController = TextEditingController();

  EditReviewCardController(Review rev) {
    _review = rev;
    _rating = rev.rating;
    _reviewController.text = rev.reviewText;
  }




  TextEditingController get reviewController => _reviewController;

  double get rating => _rating;
  set rating(double value) {
    _rating = value;
    notifyListeners();
  }
}
