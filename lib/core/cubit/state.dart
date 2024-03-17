
abstract class AppStates  {}

class AppInitialState extends AppStates {}

// -------------------------------------------------- GetUserData
class ShowMoreState extends AppStates {}

class SocialGetUserDataLoadState extends AppStates {}
class SocialGetUserDataSuccessState extends AppStates {}
class SocialGetUserDataErrorState extends AppStates {
  final String error;
  SocialGetUserDataErrorState(this.error);
}
// -------------------------------------------------- UodateUserData

class SocialUpdateDataLoadState extends AppStates {}
class SocialUpdateDataSuccessState extends AppStates {}
class SocialUpdateDataErrorState extends AppStates {
  final String error;
  SocialUpdateDataErrorState(this.error);
}
// -------------------------------------------------- UodateUserData

class SocialUploadNewItemLoadState extends AppStates {}
class SocialUploadNewItemSuccessState extends AppStates {}
class SocialUploadNewItemErrorState extends AppStates {
  final String error;
  SocialUploadNewItemErrorState(this.error);
}
// -------------------------------------------------- Upload profile Image

class SocialUploadprofileImageLoadingState extends AppStates{}
class SocialUploadprofileImageSuccessState extends AppStates{}
class SocialUploadprofileImageErrorState extends AppStates {
  final String error;
  SocialUploadprofileImageErrorState(this.error);
}// -------------------------------------------------- Pick Item Image

class SocialCoverImagePickedLoadState extends AppStates{}
class SocialCoverImagePickedSuccessState extends AppStates{}
class SocialCoverImagePickedErrorState extends AppStates {
  final String error;
  SocialCoverImagePickedErrorState(this.error);
}
// -------------------------------------------------- Upload Item Image

class SocialAddtocartSuccessState extends AppStates{}
class SocialGetcartLoadState extends AppStates{}
class SocialGetcartSuccessState extends AppStates{}
class SocialGetcartErrorState extends AppStates{
  final String  error;
  SocialGetcartErrorState(this.error);
}
// -------------------------------------------------- Upload Item Image

class SocialUploadItemImageLoadingState extends AppStates{}
class SocialUploadItemImageSuccessState extends AppStates{}
class SocialUploadItemImageErrorState extends AppStates {
  final String error;
  SocialUploadItemImageErrorState(this.error);
}
// -------------------------------------------------- Remove Picked Image

class RemoveImageState extends AppStates{}


// -------------------------------------------------- GetImage

class SocialGetImageLoadState extends AppStates {}
class SocialGetImageSuccessState extends AppStates {}
class SocialGetImageErrorState extends AppStates {
  final String error;
  SocialGetImageErrorState(this.error);
}
// -------------------- Delete Item --------
class SocialDeleteItemSuccessState extends AppStates{}
class SocialDeleteItemErrorState extends AppStates{
  final String error;
  SocialDeleteItemErrorState(this.error);}
// -------------------- Send Message --------
class SocialSendMessageSuccessState extends AppStates{}
class SocialSendMessageErrorState extends AppStates{
  final String error;
  SocialSendMessageErrorState(this.error);}

// -------------------- get Message --------
class SocialgetMessageSuccessState extends AppStates{}
class SocialgetMessageErrorState extends AppStates{
  final String error;
  SocialgetMessageErrorState(this.error);}






// -------------------- Translation

class ChangeLanguageState extends AppStates {}

class LanguageLoaded extends AppStates {}

// -------------------- no internet

class InternetState extends AppStates {}

//-------------------------------------------bottem navigation
class SocialChangeBottemNavigationState extends AppStates {}

// ------------------------------------------language

class ChangeThemeloadState extends AppStates {}
//---------------------------------------------Theme
class ChangeThemeSuccessState extends AppStates {}
class ChangeThemeErrorState extends AppStates {}

