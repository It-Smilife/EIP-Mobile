import '../../../../services/NetworkManager.dart';

Future<VerifCode> changeVerifCode(email) async {
  return await NetworkManager.get(
          "users/" + email + "/update-password-code-by-email")
      .then((value) {
    if (value.data["success"] == true) {
      final data = value.data["message"];
      final verifCode = VerifCode.fromData(data);
      return verifCode;
    } else {
      throw Exception('Failed to load themes');
    }
  });
}

class VerifCode {
  final String id;
  final String email;
  final String password;

  VerifCode({
    required this.id,
    required this.email,
    required this.password,
  });

  factory VerifCode.fromData(Map<String, dynamic> data) {
    return VerifCode(
      id: data['_id'],
      email: data['email'],
      password: data['password'],
    );
  }
}
