//data models
import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class User{
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String pfpURL;
  final double rating;
  final String description;
  final bool displayPhoneNumber;
  final bool lookingForWork;
  final bool lookingForWorkers;

  User({
     this.uid = " ",
     this.firstName = " ",
     this.lastName = " ",
     this.email = " ",
     this.phoneNumber = " ",
     this.pfpURL = " ",
     this.rating = 0.0,
     this.description = "",
     this.displayPhoneNumber = false,
     this.lookingForWork = true,
     this.lookingForWorkers = true,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}



@JsonSerializable()
class JobPosting {
  final String jobTitle;
  final String jobLocation;
  final String jobDetails;
  final String jobStartTime;
  final String jobEndTime;
  final int jobPay;
  final int jobDuration;
  final double hourlyRate;
  final String jobPosterName;
  final String jobPosterID;
  final bool canPickup;
  final double rating;
  final String pfpURL;
  final String jobID;

  JobPosting({
    this.jobTitle = "Ball Crusher",
    this.jobLocation = "Alpharetta, GA",
    this.jobDetails = "I wanna buy me this damn ball crusher",
    this.jobStartTime = "6:00 AM",
    this.jobEndTime = "12:00 AM",
    this.jobPay = 360,
    this.jobDuration = 18,
    this.hourlyRate = 15,
    this.jobPosterName = "Mihai Mare",
    this.jobPosterID = "fajhskdhgfapdsi",
    this.canPickup = false,
    this.rating = 3.5,
    this.pfpURL =
        "https://firebasestorage.googleapis.com/v0/b/helping-hand-9002c.appspot.com/o/profilePics%2F7UO8OdTqkIS3IRFFHpGnGHZ6yfA3..jpg?alt=media&token=37fb5d76-6f6f-4517-9e8c-ac10387b6a47",
        this.jobID="ABC"
  });
  factory JobPosting.fromJson(Map<String, dynamic> json) => _$JobPostingFromJson(json);
  Map<String, dynamic> toJson() => _$JobPostingToJson(this);
}




@JsonSerializable()
class AvailabilityPosting {
  final String generalLocation;
  final String availabilityDetails;
  final String jobPosterName;
  final bool needsPickup;
  final double rating;
  final String pfpURL;
  final String avaPostID;
  final String posterID;

  AvailabilityPosting({
    this.generalLocation = " ",
    this.availabilityDetails = " ",
    this.jobPosterName = " ",
    this.needsPickup = false,
    this.rating = 0.0,
    this.pfpURL =
        "https://firebasestorage.googleapis.com/v0/b/helping-hand-9002c.appspot.com/o/profilePics%2F7UO8OdTqkIS3IRFFHpGnGHZ6yfA3..jpg?alt=media&token=37fb5d76-6f6f-4517-9e8c-ac10387b6a47",
        this.avaPostID="ABC",
        this.posterID="ABC"
  });

  factory AvailabilityPosting.fromJson(Map<String, dynamic> json) => _$AvailabilityPostingFromJson(json);
  Map<String, dynamic> toJson() => _$AvailabilityPostingToJson(this);
}
