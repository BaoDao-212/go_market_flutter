class Tokens {
  late final String accessToken;
  late final String refreshToken;

  Tokens({required this.accessToken});

  Tokens.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }
}
