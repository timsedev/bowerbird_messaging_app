class Path {
  static const baseUrl =
      'https://bowerbird-test-api-production-42f964da9407.herokuapp.com/api/v1';

  // login
  static const login = '$baseUrl/login';

  // message_groups
  static const indexMessageGroups = '$baseUrl/message_groups';
  static String getMessageGroup(String id) => '$baseUrl/message_groups/$id';
  static const createMessageGroup = '$baseUrl/message_groups';
  static String updateMessageGroup(String id) => '$baseUrl/message_groups/$id';
  static String deleteMessageGroup(String id) => '$baseUrl/message_groups/$id';

  // message group members
  static const indexMessageGroupMembers = '$baseUrl/message_group_members';
  static String getMessageGroupMember(String id) =>
      '$baseUrl/message_group_members/$id';
  static const createMessageGroupMember = '$baseUrl/message_group_members';
  static String deleteMessageGroupMember(String id) =>
      '$baseUrl/message_group_members/$id';

  // message
  static const indexMessages = '$baseUrl/messages';
  static String getMessage(String id) => '$baseUrl/messages/$id';
  static const createMessage = '$baseUrl/messages';
  static String updateMessage(String id) => '$baseUrl/messages/$id';
  static String deleteMessage(String id) => '$baseUrl/messages/$id';

  // images
  static const indexImages = '$baseUrl/images';
  static String getImage(String id) => '$baseUrl/images/$id';
  static const createImage = '$baseUrl/images';
  static String updateImage(String id) => '$baseUrl/images/$id';
  static String deleteImage(String id) => '$baseUrl/images/$id';

  // tags
  static const indexTags = '$baseUrl/tags';
  static String getTag(String id) => '$baseUrl/tags/$id';
}
