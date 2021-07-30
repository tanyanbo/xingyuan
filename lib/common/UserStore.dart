class UserStore {
  String nickname = '';
  int coins = 0;
  String accessToken = '';
  String id = '';

  static final UserStore _userInfo = UserStore._internal();

  UserStore._internal();

  factory UserStore(
      {String? nickname, int? coins, String? accessToken, String? id}) {
    if (nickname != null) {
      _userInfo.nickname = nickname;
    }

    if (coins != null) {
      _userInfo.coins = coins;
    }

    if (accessToken != null) {
      _userInfo.accessToken = accessToken;
    }

    if (id != null) {
      _userInfo.id = id;
    }

    return _userInfo;
  }
}
