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

  Future<void> submitReview() async {
    try {
      final Review review = Review(
        revieweeID: _review.revieweeID,
        reviewerID: _review.reviewerID,
        reviewerPfpURL: _review.reviewerPfpURL,
        reviewerName: _review.reviewerName,
        reviewText: _reviewController.text,
        rating: _rating,
        reviewDate: DateTime.now(),
      );

      await FirestoreService().updateReview(review);
      
    } catch (e) {
      print(e);
    }
  }
}
