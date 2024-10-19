part of 'edit_review_card.dart';

class EditReviewCardController extends ChangeNotifier {
  late Review _review;
  double _rating = 0.0;
  final TextEditingController _reviewController = TextEditingController();
  bool _isSubmitting = false;

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
  bool get isSubmitting => _isSubmitting;

  Future<void> submitReview(User reviewee) async {
    _isSubmitting = true;
    notifyListeners();
    try {
      final Review newReview = Review(
        revieweeID: _review.revieweeID,
        reviewerID: _review.reviewerID,
        reviewID: _review.reviewID.trim(),
        reviewerPfpURL: _review.reviewerPfpURL,
        reviewerName: _review.reviewerName,
        reviewText: _reviewController.text,
        rating: _rating,
        reviewDate: DateTime.now(),
      );
      

      await FirestoreService().updateReview(_review, newReview, reviewee);
      _review = newReview;
      _isSubmitting = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
