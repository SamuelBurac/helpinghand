part of "chats_overview_scr.dart";

String _getInterlocutorUID(
    List<String> participants, String currUID) {
  if (participants.isEmpty || participants.length < 2) {
    throw Exception('Participants list is empty or does not have enough elements');
  }
   if (participants[0] == currUID) {
    return participants[1];
  } else {
    return participants[0];
  }

}
