// ignore_for_file: require_trailing_commas
// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

part of firebase_auth;

/// A user account.
class User {
  UserPlatform _delegate;

  final FirebaseAuth _auth;

  User._(this._auth, this._delegate) {
    UserPlatform.verifyExtends(_delegate);
  }

  /// The users display name.
  ///
  /// Will be `null` if signing in anonymously or via password authentication.
  String? get displayName {
    return _delegate.displayName;
  }

  set displayName(String? value) {
    if(value == null) {
      throw new ArgumentError();
    }
    _delegate.displayName = value;
  }

  /// The users email address.
  ///
  /// Will be `null` if signing in anonymously.
  String? get email {
    return _delegate.email;
  }

  set email(String? value) {
    if(value == null) {
      throw new ArgumentError();
    }
    _delegate.email = value;
  }

  /// Returns whether the users email address has been verified.
  ///
  /// To send a verification email, see [sendEmailVerification].
  ///
  /// Once verified, call [reload] to ensure the latest user information is
  /// retrieved from Firebase.
  bool get emailVerified {
    return _delegate.emailVerified;
  }

  set emailVerified(bool value) {
    if(value == null) {
      throw new ArgumentError();
    }
    _delegate.emailVerified = value;
  }

  /// Returns whether the user is a anonymous.
  bool get isAnonymous {
    return _delegate.isAnonymous;
  }

  set isAnonymous(bool value) {
    if(value == null) {
      throw new ArgumentError();
    }
    _delegate.isAnonymous = value;
  }

  /// Returns additional metadata about the user, such as their creation time.
  UserMetadata get metadata {
    return _delegate.metadata;
  }

  set metadata(UserMetadata value) {
    if(value == null) {
      throw new ArgumentError();
    }
    _delegate.metadata = value;
  }

  /// Returns the users phone number.
  ///
  /// This property will be `null` if the user has not signed in or been has
  /// their phone number linked.
  String? get phoneNumber {
    return _delegate.phoneNumber;
  }

  set phoneNumber(String? value) {
    if(value == null) {
      throw new ArgumentError();
    }
    _delegate.phoneNumber = value;
  }

  /// Returns a photo URL for the user.
  ///
  /// This property will be populated if the user has signed in or been linked
  /// with a 3rd party OAuth provider (such as Google).
  String? get photoURL {
    return _delegate.photoURL;
  }

  set photoURL(String? value) {
    if(value == null) {
      throw new ArgumentError();
    }
    _delegate.photoURL = value;
  }

  /// Returns a list of user information for each linked provider.
  List<UserInfo> get providerData {
    return _delegate.providerData;
  }

  set providerData(List<UserInfo> value) {
    if(value == null) {
      throw new ArgumentError();
    }
    _delegate.providerData = value;
  }

  /// Returns a JWT refresh token for the user.
  ///
  /// This property maybe `null` or empty if the underlying platform does not
  /// support providing refresh tokens.
  String? get refreshToken {
    return _delegate.refreshToken;
  }

  set refreshToken(String? value) {
    if(value == null) {
      throw new ArgumentError();
    }
    _delegate.refreshToken = value;
  }

  /// The current user's tenant ID.
  ///
  /// This is a read-only property, which indicates the tenant ID used to sign
  /// in the current user. This is `null` if the user is signed in from the
  /// parent project.
  String? get tenantId {
    return _delegate.tenantId;
  }

  set tenantId(String? value) {
    if(value == null) {
      throw new ArgumentError();
    }
    _delegate.tenantId = value;
  }

  /// The user's unique ID.
  String get uid {
    return _delegate.uid;
  }

  set uid(String? value) {
    if(value == null) {
      throw new ArgumentError();
    }
    _delegate.uid = value;
  }

  /// Deletes and signs out the user.
  ///
  /// **Important**: this is a security-sensitive operation that requires the
  /// user to have recently signed in. If this requirement isn't met, ask the
  /// user to authenticate again and then call [User.reauthenticateWithCredential].
  ///
  /// A [FirebaseAuthException] maybe thrown with the following error code:
  /// - **requires-recent-login**:
  ///  - Thrown if the user's last sign-in time does not meet the security
  ///    threshold. Use [User.reauthenticateWithCredential] to resolve. This
  ///    does not apply if the user is anonymous.
  Future<void> delete() async {
    return _delegate.delete();
  }

  /// Returns a JSON Web Token (JWT) used to identify the user to a Firebase
  /// service.
  ///
  /// Returns the current token if it has not expired. Otherwise, this will
  /// refresh the token and return a new one.
  ///
  /// If [forceRefresh] is `true`, the token returned will be refreshed regardless
  /// of token expiration.
  Future<String> getIdToken([bool forceRefresh = false]) {
    return _delegate.getIdToken(forceRefresh);
  }

  /// Returns a [IdTokenResult] containing the users JSON Web Token (JWT) and
  /// other metadata.
  ///
  /// If [forceRefresh] is `true`, the token returned will be refreshed regardless
  /// of token expiration.
  Future<IdTokenResult> getIdTokenResult([bool forceRefresh = false]) {
    return _delegate.getIdTokenResult(forceRefresh);
  }

  /// Links the user account with the given credentials.
  ///
  /// A [FirebaseAuthException] maybe thrown with the following error code:
  /// - **provider-already-linked**:
  ///  - Thrown if the provider has already been linked to the user. This error
  ///    is thrown even if this is not the same provider's account that is
  ///    currently linked to the user.
  /// - **invalid-credential**:
  ///  - Thrown if the provider's credential is not valid. This can happen if it
  ///    has already expired when calling link, or if it used invalid token(s).
  ///    See the Firebase documentation for your provider, and make sure you
  ///    pass in the correct parameters to the credential method.
  /// - **credential-already-in-use**:
  ///  - Thrown if the account corresponding to the credential already exists
  ///    among your users, or is already linked to a Firebase User. For example,
  ///    this error could be thrown if you are upgrading an anonymous user to a
  ///    Google user by linking a Google credential to it and the Google
  ///    credential used is already associated with an existing Firebase Google
  ///    user. The fields `email`, `phoneNumber`, and `credential`
  ///    ([AuthCredential]) may be provided, depending on the type of
  ///    credential. You can recover from this error by signing in with
  ///    `credential` directly via [signInWithCredential]. Please note, you will
  ///    not recover from this error if you're using a [PhoneAuthCredential] to link
  ///    a provider to an account. Once an attempt to link an account has been made,
  ///    a new sms code is required to sign in the user.
  /// - **email-already-in-use**:
  ///  - Thrown if the email corresponding to the credential already exists
  ///    among your users. When thrown while linking a credential to an existing
  ///    user, an `email` and `credential` ([AuthCredential]) fields are also
  ///    provided. You have to link the credential to the existing user with
  ///    that email if you wish to continue signing in with that credential. To
  ///    do so, call [fetchSignInMethodsForEmail], sign in to `email` via one of
  ///    the providers returned and then [User.linkWithCredential] the original
  ///    credential to that newly signed in user.
  /// - **operation-not-allowed**:
  ///  - Thrown if you have not enabled the provider in the Firebase Console. Go
  ///    to the Firebase Console for your project, in the Auth section and the
  ///    Sign in Method tab and configure the provider.
  /// - **invalid-email**:
  ///  - Thrown if the email used in a [EmailAuthProvider.credential] is
  ///    invalid.
  /// - **invalid-email**:
  ///  - Thrown if the password used in a [EmailAuthProvider.credential] is not
  ///    correct or when the user associated with the email does not have a
  ///    password.
  /// - **invalid-verification-code**:
  ///  - Thrown if the credential is a [PhoneAuthProvider.credential] and the
  ///    verification code of the credential is not valid.
  /// - **invalid-verification-id**:
  ///  - Thrown if the credential is a [PhoneAuthProvider.credential] and the
  ///    verification ID of the credential is not valid.
  Future<UserCredential> linkWithCredential(AuthCredential credential) async {
    return UserCredential._(
      _auth,
      await _delegate.linkWithCredential(credential),
    );
  }

  /// Links the user account with the given provider.
  ///
  /// A [FirebaseAuthException] maybe thrown with the following error code:
  /// - **provider-already-linked**:
  ///  - Thrown if the provider has already been linked to the user. This error
  ///    is thrown even if this is not the same provider's account that is
  ///    currently linked to the user.
  /// - **invalid-credential**:
  ///  - Thrown if the provider's credential is not valid. This can happen if it
  ///    has already expired when calling link, or if it used invalid token(s).
  ///    See the Firebase documentation for your provider, and make sure you
  ///    pass in the correct parameters to the credential method.
  /// - **credential-already-in-use**:
  ///  - Thrown if the account corresponding to the credential already exists
  ///    among your users, or is already linked to a Firebase User. For example,
  ///    this error could be thrown if you are upgrading an anonymous user to a
  ///    Google user by linking a Google credential to it and the Google
  ///    credential used is already associated with an existing Firebase Google
  ///    user. The fields `email`, `phoneNumber`, and `credential`
  ///    ([AuthCredential]) may be provided, depending on the type of
  ///    credential. You can recover from this error by signing in with
  ///    `credential` directly via [signInWithCredential].
  /// - **email-already-in-use**:
  ///  - Thrown if the email corresponding to the credential already exists
  ///    among your users. When thrown while linking a credential to an existing
  ///    user, an `email` and `credential` ([AuthCredential]) fields are also
  ///    provided. You have to link the credential to the existing user with
  ///    that email if you wish to continue signing in with that credential.
  ///    To do so, call [fetchSignInMethodsForEmail], sign in to `email` via one
  ///    of the providers returned and then [User.linkWithCredential] the
  ///    original credential to that newly signed in user.
  /// - **operation-not-allowed**:
  ///  - Thrown if you have not enabled the provider in the Firebase Console. Go
  ///    to the Firebase Console for your project, in the Auth section and the
  ///    Sign in Method tab and configure the provider.
  Future<UserCredential> linkWithPopup(AuthProvider provider) async {
    return UserCredential._(
      _auth,
      await _delegate.linkWithPopup(provider),
    );
  }

  /// Links the user account with the given phone number.
  ///
  /// This method is only supported on web platforms. Use [verifyPhoneNumber] and
  /// then [linkWithCredential] on these platforms.
  ///
  /// A [FirebaseAuthException] maybe thrown with the following error code:
  /// - **provider-already-linked**:
  ///  - Thrown if the provider has already been linked to the user. This error
  ///    is thrown even if this is not the same provider's account that is
  ///    currently linked to the user.
  /// - **captcha-check-failed**:
  ///  - Thrown if the reCAPTCHA response token was invalid, expired, or if this
  ///    method was called from a non-whitelisted domain.
  /// - **invalid-phone-number**:
  ///  - Thrown if the phone number has an invalid format.
  /// - **quota-exceeded**:
  ///  - Thrown if the SMS quota for the Firebase project has been exceeded.
  /// - **user-disabled**:
  ///  - Thrown if the user corresponding to the given phone number has been disabled.
  /// - **credential-already-in-use**:
  ///  - Thrown if the account corresponding to the phone number already exists
  ///    among your users, or is already linked to a Firebase User.
  /// - **operation-not-allowed**:
  ///  - Thrown if you have not enabled the phone authentication provider in the
  ///  Firebase Console. Go to the Firebase Console for your project, in the Auth
  ///  section and the Sign in Method tab and configure the provider.
  Future<ConfirmationResult> linkWithPhoneNumber(
    String phoneNumber, [
    RecaptchaVerifier? verifier,
  ]) async {
    assert(phoneNumber.isNotEmpty);
    verifier ??= RecaptchaVerifier();
    return ConfirmationResult._(
      _auth,
      await _delegate.linkWithPhoneNumber(phoneNumber, verifier.delegate),
    );
  }

  /// Re-authenticates a user using a fresh credential.
  ///
  /// Use before operations such as [User.updatePassword] that require tokens
  /// from recent sign-in attempts.
  ///
  /// A [FirebaseAuthException] maybe thrown with the following error code:
  /// - **user-mismatch**:
  ///  - Thrown if the credential given does not correspond to the user.
  /// - **user-not-found**:
  ///  - Thrown if the credential given does not correspond to any existing
  ///    user.
  /// - **invalid-credential**:
  ///  - Thrown if the provider's credential is not valid. This can happen if it
  ///    has already expired when calling link, or if it used invalid token(s).
  ///    See the Firebase documentation for your provider, and make sure you
  ///    pass in the correct parameters to the credential method.
  /// - **invalid-email**:
  ///  - Thrown if the email used in a [EmailAuthProvider.credential] is
  ///    invalid.
  /// - **wrong-password**:
  ///  - Thrown if the password used in a [EmailAuthProvider.credential] is not
  ///    correct or when the user associated with the email does not have a
  ///    password.
  /// - **invalid-verification-code**:
  ///  - Thrown if the credential is a [PhoneAuthProvider.credential] and the
  ///    verification code of the credential is not valid.
  /// - **invalid-verification-id**:
  ///  - Thrown if the credential is a [PhoneAuthProvider.credential] and the
  ///    verification ID of the credential is not valid.
  Future<UserCredential> reauthenticateWithCredential(
    AuthCredential credential,
  ) async {
    return UserCredential._(
      _auth,
      await _delegate.reauthenticateWithCredential(credential),
    );
  }

  /// Refreshes the current user, if signed in.
  Future<void> reload() async {
    await _delegate.reload();
  }

  /// Sends a verification email to a user.
  ///
  /// The verification process is completed by calling [applyActionCode].
  Future<void> sendEmailVerification([
    ActionCodeSettings? actionCodeSettings,
  ]) async {
    await _delegate.sendEmailVerification(actionCodeSettings);
  }

  /// Unlinks a provider from a user account.
  ///
  /// A [FirebaseAuthException] maybe thrown with the following error code:
  /// - **no-such-provider**:
  ///  - Thrown if the user does not have this provider linked or when the
  ///    provider ID given does not exist.
  Future<User> unlink(String providerId) async {
    return User._(_auth, await _delegate.unlink(providerId));
  }

  /// Updates the user's email address.
  ///
  /// An email will be sent to the original email address (if it was set) that
  /// allows to revoke the email address change, in order to protect them from
  /// account hijacking.
  ///
  /// **Important**: this is a security sensitive operation that requires the
  ///   user to have recently signed in. If this requirement isn't met, ask the
  ///   user to authenticate again and then call [User.reauthenticateWithCredential].
  ///
  /// A [FirebaseAuthException] maybe thrown with the following error code:
  /// - **invalid-email**:
  ///  - Thrown if the email used is invalid.
  /// - **email-already-in-use**:
  ///  - Thrown if the email is already used by another user.
  /// - **requires-recent-login**:
  ///  - Thrown if the user's last sign-in time does not meet the security
  ///    threshold. Use [User.reauthenticateWithCredential] to resolve. This
  ///    does not apply if the user is anonymous.
  Future<void> updateEmail(String newEmail) async {
    await _delegate.updateEmail(newEmail);
  }

  /// Updates the user's password.
  ///
  /// **Important**: this is a security sensitive operation that requires the
  ///   user to have recently signed in. If this requirement isn't met, ask the
  ///   user to authenticate again and then call [User.reauthenticateWithCredential].
  ///
  /// A [FirebaseAuthException] maybe thrown with the following error code:
  /// - **weak-password**:
  ///  - Thrown if the password is not strong enough.
  /// - **requires-recent-login**:
  ///  - Thrown if the user's last sign-in time does not meet the security
  ///    threshold. Use [User.reauthenticateWithCredential] to resolve. This
  ///    does not apply if the user is anonymous.
  Future<void> updatePassword(String newPassword) async {
    await _delegate.updatePassword(newPassword);
  }

  /// Updates the user's phone number.
  ///
  /// A credential can be created by verifying a phone number via [verifyPhoneNumber].
  ///
  /// A [FirebaseAuthException] maybe thrown with the following error code:
  /// - **invalid-verification-code**:
  ///  - Thrown if the verification code of the credential is not valid.
  /// - **invalid-verification-id**:
  ///  - Thrown if the verification ID of the credential is not valid.
  Future<void> updatePhoneNumber(PhoneAuthCredential phoneCredential) async {
    await _delegate.updatePhoneNumber(phoneCredential);
  }

  /// Update the user name.
  Future<void> updateDisplayName(String? displayName) {
    return _delegate
        .updateProfile(<String, String?>{'displayName': displayName});
  }

  /// Update the user's profile picture.
  Future<void> updatePhotoURL(String? photoURL) {
    return _delegate.updateProfile(<String, String?>{'photoURL': photoURL});
  }

  /// Updates a user's profile data.
  @Deprecated(
    'Will be removed in version 2.0.0. '
    'Use updatePhotoURL and updateDisplayName instead.',
  )
  Future<void> updateProfile({String? displayName, String? photoURL}) {
    return _delegate.updateProfile(<String, String?>{
      'displayName': displayName,
      'photoURL': photoURL,
    });
  }

  /// Sends a verification email to a new email address. The user's email will
  /// be updated to the new one after being verified.
  ///
  /// If you have a custom email action handler, you can complete the
  /// verification process by calling [applyActionCode].
  Future<void> verifyBeforeUpdateEmail(
    String newEmail, [
    ActionCodeSettings? actionCodeSettings,
  ]) async {
    await _delegate.verifyBeforeUpdateEmail(newEmail, actionCodeSettings);
  }

  @override
  String toString() {
    return '$User('
        'displayName: $displayName, '
        'email: $email, '
        'emailVerified: $emailVerified, '
        'isAnonymous: $isAnonymous, '
        'metadata: $metadata, '
        'phoneNumber: $phoneNumber, '
        'photoURL: $photoURL, '
        'providerData, $providerData, '
        'refreshToken: $refreshToken, '
        'tenantId: $tenantId, '
        'uid: $uid)';
  }
}
