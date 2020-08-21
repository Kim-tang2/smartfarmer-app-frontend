import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:smartfarm/firebase/auth_exception_handler.dart';
import 'package:smartfarm/firebase/auth_result_status.dart';
import 'package:smartfarm/provider/database_provider.dart';

Logger logger = Logger();

class FirebaseProvider with ChangeNotifier {
  final FirebaseAuth fAuth = FirebaseAuth.instance; // Firebase 인증 플러그인의 인스턴스
  FirebaseUser _user; // Firebase에 로그인 된 사용자
  AuthResultStatus _status; // Firebase 메시지(에러 처리용)

  String _lastFirebaseResponse = ""; // Firebase로부터 받은 최신 메시지(에러 처리용)

  FirebaseProvider() {
    logger.d("init FirebaseProvider");
    _prepareUser();
  }

  FirebaseUser getUser() {
    return _user;
  }

  void setUser(FirebaseUser value) {
    _user = value;
    notifyListeners();
  }

  // 최근 Firebase에 로그인한 사용자의 정보 획득
  _prepareUser() {
    fAuth.currentUser().then((FirebaseUser currentUser) {
      setUser(currentUser);
    });
  }

  // 이메일/비밀번호로 Firebase에 로그인
  Future<AuthResultStatus> signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        setUser(result.user);
        _status = AuthResultStatus.successful;
      }else{
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  // 이메일/비밀번호로 Firebase에 회원가입
  Future<AuthResultStatus> signUpWithEmail(String email, String password, String nickName) async {
    try {
      AuthResult result = await fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        signOut();
        await databaseProvider.createFarmer(farmerKey: result.user.uid, nickName: nickName);
        _user = result.user;
        _status = AuthResultStatus.successful;
      }
    } catch (e) {
      print(e.code);
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  // Firebase로부터 로그아웃
  signOut() async {
    await fAuth.signOut();
    setUser(null);
  }

  // 사용자에게 비밀번호 재설정 메일을 영어로 전송 시도
  sendPasswordResetEmailByEnglish() async {
    await fAuth.setLanguageCode("en");
    sendPasswordResetEmail();
  }

  // 사용자에게 비밀번호 재설정 메일을 한글로 전송 시도
  sendPasswordResetEmailByKorean() async {
    await fAuth.setLanguageCode("ko");
    sendPasswordResetEmail();
  }

  // 사용자에게 비밀번호 재설정 메일을 전송
  sendPasswordResetEmail() async {
    fAuth.sendPasswordResetEmail(email: getUser().email);
  }

  // Firebase로부터 회원 탈퇴
  withdrawalAccount() async {
    await getUser().delete();
    setUser(null);
  }
}
