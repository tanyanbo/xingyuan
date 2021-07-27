const BASE_URL = 'https://murmuring-river-82645.herokuapp.com';

class UserStore {
  String nickname = '';
  int coins = 0;
  String accessToken = '';

  static final UserStore _userInfo = UserStore._internal();

  UserStore._internal();

  factory UserStore({String? nickname, int? coins, String? accessToken}) {
    if (nickname != null) {
      _userInfo.nickname = nickname;
    }

    if (coins != null) {
      _userInfo.coins = coins;
    }

    if (accessToken != null) {
      _userInfo.accessToken = accessToken;
    }

    return _userInfo;
  }
}

String accessToken = '';
