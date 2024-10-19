// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      isPremium: json['isPremium'] as bool? ?? false,
      uid: json['uid'] as String? ?? " ",
      firstName: json['firstName'] as String? ?? " ",
      lastName: json['lastName'] as String? ?? " ",
      email: json['email'] as String? ?? " ",
      phoneNumber: json['phoneNumber'] as String? ?? " ",
      numPostsLeft: (json['numPostsLeft'] as num?)?.toInt() ?? 0,
      pfpURL: json['pfpURL'] as String? ?? " ",
      location: json['location'] as String? ?? " ",
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      numReviews: (json['numReviews'] as num?)?.toInt() ?? 0,
      description: json['description'] as String? ?? "",
      displayPhoneNumber: json['displayPhoneNumber'] as bool? ?? false,
      lookingForWork: json['lookingForWork'] as bool? ?? true,
      lookingForWorkers: json['lookingForWorkers'] as bool? ?? true,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'pfpURL': instance.pfpURL,
      'location': instance.location,
      'isPremium': instance.isPremium,
      'numPostsLeft': instance.numPostsLeft,
      'rating': instance.rating,
      'numReviews': instance.numReviews,
      'description': instance.description,
      'displayPhoneNumber': instance.displayPhoneNumber,
      'lookingForWork': instance.lookingForWork,
      'lookingForWorkers': instance.lookingForWorkers,
    };

JobPosting _$JobPostingFromJson(Map<String, dynamic> json) => JobPosting(
      jobTitle: json['jobTitle'] as String? ?? "Soccer Ball Crusher",
      jobLocation: json['jobLocation'] as String? ?? "Alpharetta, GA",
      jobDetails: json['jobDetails'] as String? ??
          "I wanna play soccer but I need someone to crush the balls for me",
      jobStartTime: json['jobStartTime'] as String? ?? "6:00 AM",
      jobEndTime: json['jobEndTime'] as String? ?? "12:00 AM",
      oneDay: json['oneDay'] as bool? ?? true,
      onlyDay: json['onlyDay'] as String? ?? "07/04/2024",
      startDate: json['startDate'] as String? ?? "07/04/2024",
      endDate: json['endDate'] as String? ?? "07/04/2024",
      jobPay: (json['jobPay'] as num?)?.toInt() ?? 360,
      jobDuration: (json['jobDuration'] as num?)?.toInt() ?? 18,
      hourlyRate: (json['hourlyRate'] as num?)?.toDouble() ?? 15,
      jobPosterName: json['jobPosterName'] as String? ?? "Mihai Mare",
      jobPosterID: json['jobPosterID'] as String? ?? "fajhskdhgfapdsi",
      canPickup: json['canPickup'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 3.5,
      pfpURL: json['pfpURL'] as String? ??
          "https://firebasestorage.googleapis.com/v0/b/helping-hand-9002c.appspot.com/o/profilePics%2F7UO8OdTqkIS3IRFFHpGnGHZ6yfA3..jpg?alt=media&token=37fb5d76-6f6f-4517-9e8c-ac10387b6a47",
      jobID: json['jobID'] as String? ?? "ABC",
    );

Map<String, dynamic> _$JobPostingToJson(JobPosting instance) =>
    <String, dynamic>{
      'jobTitle': instance.jobTitle,
      'jobLocation': instance.jobLocation,
      'jobDetails': instance.jobDetails,
      'jobStartTime': instance.jobStartTime,
      'jobEndTime': instance.jobEndTime,
      'oneDay': instance.oneDay,
      'onlyDay': instance.onlyDay,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'jobPay': instance.jobPay,
      'jobDuration': instance.jobDuration,
      'hourlyRate': instance.hourlyRate,
      'jobPosterName': instance.jobPosterName,
      'jobPosterID': instance.jobPosterID,
      'canPickup': instance.canPickup,
      'rating': instance.rating,
      'pfpURL': instance.pfpURL,
      'jobID': instance.jobID,
    };

AvailabilityPosting _$AvailabilityPostingFromJson(Map<String, dynamic> json) =>
    AvailabilityPosting(
      generalLocation: json['generalLocation'] as String? ?? "Atlanta, GA",
      availabilityDetails: json['availabilityDetails'] as String? ??
          "I'm available to work on the 4th of July!",
      jobPosterName: json['jobPosterName'] as String? ?? "Mihai Mare",
      availabilityDates: (json['availabilityDates'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const ["07/04/2024"],
      startDate: json['startDate'] as String? ?? "07/04/2024",
      endDate: json['endDate'] as String? ?? "07/04/2024",
      rangeOfDates: json['rangeOfDates'] as bool? ?? false,
      needsPickup: json['needsPickup'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      pfpURL: json['pfpURL'] as String? ??
          "https://firebasestorage.googleapis.com/v0/b/helping-hand-9002c.appspot.com/o/profilePics%2F7UO8OdTqkIS3IRFFHpGnGHZ6yfA3..jpg?alt=media&token=37fb5d76-6f6f-4517-9e8c-ac10387b6a47",
      avaPostID: json['avaPostID'] as String? ?? "ABC",
      posterID: json['posterID'] as String? ?? "ABC",
    );

Map<String, dynamic> _$AvailabilityPostingToJson(
        AvailabilityPosting instance) =>
    <String, dynamic>{
      'generalLocation': instance.generalLocation,
      'availabilityDetails': instance.availabilityDetails,
      'jobPosterName': instance.jobPosterName,
      'needsPickup': instance.needsPickup,
      'availabilityDates': instance.availabilityDates,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'rangeOfDates': instance.rangeOfDates,
      'rating': instance.rating,
      'pfpURL': instance.pfpURL,
      'avaPostID': instance.avaPostID,
      'posterID': instance.posterID,
    };

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      senderUID: json['senderUID'] as String,
      message: json['message'] as String,
      timeStampSent: const TimestampConverter().fromJson(json['timeStampSent']),
      imageUrl: json['imageUrl'] as String? ?? "",
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'senderUID': instance.senderUID,
      'message': instance.message,
      'timeStampSent':
          const TimestampConverter().toJson(instance.timeStampSent),
      'imageUrl': instance.imageUrl,
    };

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdTS: const TimestampConverter().fromJson(json['createdTS']),
      lastMessageTS: const TimestampConverter().fromJson(json['lastMessageTS']),
      lastMessage: json['lastMessage'] as String,
      unreadUID: json['unreadUID'] as String? ?? "",
      chatID: json['chatID'] as String? ?? "ABC",
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'participants': instance.participants,
      'createdTS': const TimestampConverter().toJson(instance.createdTS),
      'lastMessageTS':
          const TimestampConverter().toJson(instance.lastMessageTS),
      'lastMessage': instance.lastMessage,
      'unreadUID': instance.unreadUID,
      'chatID': instance.chatID,
    };

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      rating: (json['rating'] as num).toDouble(),
      reviewDate: const TimestampConverter().fromJson(json['reviewDate']),
      reviewText: json['reviewText'] as String,
      reviewerID: json['reviewerID'] as String,
      revieweeID: json['revieweeID'] as String,
      reviewerName: json['reviewerName'] as String,
      reviewerPfpURL: json['reviewerPfpURL'] as String,
      reviewID: json['reviewID'] as String? ?? "ABC",
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'reviewID': instance.reviewID,
      'reviewerID': instance.reviewerID,
      'revieweeID': instance.revieweeID,
      'reviewText': instance.reviewText,
      'reviewerName': instance.reviewerName,
      'reviewerPfpURL': instance.reviewerPfpURL,
      'rating': instance.rating,
      'reviewDate': const TimestampConverter().toJson(instance.reviewDate),
    };
