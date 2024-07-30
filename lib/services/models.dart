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
  final String location;
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
     this.location = " ",
     this.rating = 0.0,
     this.description = "",
     this.displayPhoneNumber = false,
     this.lookingForWork = true,
     this.lookingForWorkers = true,
  
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

DateTime dummyDate = DateTime.parse("2024-07-04");

@JsonSerializable()
class JobPosting {
  final String jobTitle;
  final String jobLocation;
  final String jobDetails;
  final String jobStartTime;
  final String jobEndTime;
  final bool oneDay;
  String? onlyDay;
  String? startDate;
  String? endDate;
  final int jobPay;
  final int jobDuration;
  final double hourlyRate;
  final String jobPosterName;
  final String jobPosterID;
  final bool canPickup;
  final double rating;
  final String pfpURL;
  String jobID;

  JobPosting({
    this.jobTitle = "Ball Crusher",
    this.jobLocation = "Alpharetta, GA",
    this.jobDetails = "I wanna buy me this damn ball crusher",
    this.jobStartTime = "6:00 AM",
    this.jobEndTime = "12:00 AM",
    this.oneDay = true,
    this.onlyDay = "07/04/2024",
    this.startDate = "07/04/2024",
    this.endDate = "07/04/2024",
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
  List<String>? availabilityDates;
  String? startDate;
  String? endDate;
  final bool rangeOfDates;
  final double rating;
  final String pfpURL;
  String avaPostID;
  final String posterID;

//rangeOfDates is true if the availability is for a range between two dates, false if it's for one or more dates
  AvailabilityPosting({
    this.generalLocation = "Atlanta, GA",
    this.availabilityDetails = "I'm available to work on the 4th of July!",
    this.jobPosterName = "Mihai Mare",
    this.availabilityDates = const ["07/04/2024"],
    this.startDate = "07/04/2024",
    this.endDate = "07/04/2024",
    this.rangeOfDates = false,
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



@JsonSerializable()
class Message {
  final String senderUID;
  final String message;
  final DateTime timeStampSent;
  final String? imageUrl;

  Message({
    required this.senderUID,
    required this.message,
    required this.timeStampSent ,
    this.imageUrl,
  });
  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);

}

@JsonSerializable()
class Chat {
  final List<String> participants;
  final DateTime createdTS;
  final DateTime lastMessageTS;
  final String lastMessage;

  Chat({
    required this.participants,
    required this.createdTS,
    required this.lastMessageTS,
    required this.lastMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);

}