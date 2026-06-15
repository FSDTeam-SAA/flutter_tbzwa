import 'package:get/get.dart';

class CommunityController extends GetxController {
  // Sample friend requests data
  final RxList<Map<String, String>> friendRequests = [
    {
      'name': 'Eduardo',
      'username': '@amelie.roche',
      'imageUrl': 'https://i.pravatar.cc/150?u=eduardo',
      'subtitle': 'French - Learning English',
      'mutual': '3 mutual friends',
    },
    {
      'name': 'Ronald',
      'username': '@julian.weber',
      'imageUrl': 'https://i.pravatar.cc/150?u=ronald',
      'subtitle': 'Spanish - Learning English',
      'mutual': '5 mutual friends',
    },
    {
      'name': 'Shane',
      'username': '@julian.weber',
      'imageUrl': 'https://i.pravatar.cc/150?u=shane',
      'subtitle': 'German - Learning English',
      'mutual': '2 mutual friends',
    },
    {
      'name': 'Leslie',
      'username': '@julian.weber',
      'imageUrl': 'https://i.pravatar.cc/150?u=leslie',
      'subtitle': 'Italian - Learning English',
      'mutual': '8 mutual friends',
    },
    {
      'name': 'Floyd',
      'username': '@amelie.roche',
      'imageUrl': 'https://i.pravatar.cc/150?u=floyd',
      'subtitle': 'Japanese - Learning English',
      'mutual': '1 mutual friend',
    },
    {
      'name': 'Nathan',
      'username': '@amelie.roche',
      'imageUrl': 'https://i.pravatar.cc/150?u=nathan',
      'subtitle': 'Chinese - Learning English',
      'mutual': '4 mutual friends',
    },
  ].obs;

  final RxList<Map<String, String>> sentRequests = [
    {
      'name': 'Robert',
      'username': 'Request Sent',
      'imageUrl': 'https://i.pravatar.cc/150?u=robert',
    },
    {
      'name': 'Philip',
      'username': 'Request Sent',
      'imageUrl': 'https://i.pravatar.cc/150?u=philip',
    },
    {
      'name': 'Soham',
      'username': 'Request Sent',
      'imageUrl': 'https://i.pravatar.cc/150?u=soham',
    },
  ].obs;

  void acceptRequest(int index) {
    friendRequests.removeAt(index);
  }

  void declineRequest(int index) {
    friendRequests.removeAt(index);
  }
}
