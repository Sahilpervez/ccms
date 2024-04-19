import 'package:ccms/src/res/base.dart';


/// Contains all the paths of image used across the project.
/// Every image path variable name must contain a name and its extension.
/// example :
///
/// for an image with name avatar.png,
/// a suitable variable can be [avatarImagePng].
/// ```dart
/// static const sampleImagePng = "$_base/image.png";
/// ```
/// can be used by doing
/// ```dart
/// ImageAssets.sampleImagePng
/// ```
class ImageAssets{

  const ImageAssets._(); 

  static const _base = BasePaths.baseImagePath;

  static const sampleImagePath = "$_base/image.png";

  static const profileImageJpeg = "$_base/profile.jpeg";
  static const profileImg = "$_base/profileImg.png";
  static const klmetaLogo = "$_base/meta.svg";
  static const klfacebookLogo =  "$_base/facebook.svg";
  static const googleIcon ="$_base/Google.svg";
  static const klgoogleLogo = "$_base/google.svg";
  static const klsearchIcon = "$_base/search.svg";
  static const klsettingsIcon = "$_base/settings.svg";
  static const klnotificationsIcon = "$_base/notifications.svg";
  static const klsendIcon = "$_base/send.svg";
  static const klcalanderIcon = "$_base/calendar.svg";
  static const kiproject1 = "$_base/project_img/p1.png";
  static const kiproject2 = "$_base/project_img/p2.png";
  static const kiproject3 = "$_base/project_img/p3.png";
  static const ktnl1 = "$_base/project_leads_thumbnails/l1.png";
  static const ktnl2 = "$_base/project_leads_thumbnails/l2.png";
  static const ktnl3 = "$_base/project_leads_thumbnails/l3.png";
  static const ktnl4 = "$_base/project_leads_thumbnails/l4.png";
  static const kLeadProfilePic1 = "$_base/leads_profile_img/leads_profile_pic_1.png";
  static const kLeadProfilePic2 = "$_base/leads_profile_img/leads_profile_pic_2.png";
  static const kLeadProfilePic3 = "$_base/leads_profile_img/leads_profile_pic_3.png";
  static const kLeadProfilePic4 = "$_base/leads_profile_img/leads_profile_pic_4.png";
  static const kLeadProfilePic5 = "$_base/leads_profile_img/leads_profile_pic_5.png";
  static const kLeadProfilePic6 = "$_base/leads_profile_img/leads_profile_pic_6.png";
  static const klcloudUpload = "$_base/upload_to_cloud.svg";
  static const klattach = "$_base/attach.svg";
  static const kiActivitylogProfileImage1 = "$_base/log_profile_image_1.png";
  static const kiActivitylogProfileImage2 = "$_base/log_profile_image_2.png";
  static const kiDrawerCalender = "$_base/app_drawer_assets/calender.svg";
  static const kiDrawerDashboard = "$_base/app_drawer_assets/dashboard.svg";
  static const kiDrawerLeads = "$_base/app_drawer_assets/leads.svg";
  static const kiDrawerLeaves = "$_base/app_drawer_assets/leaves.svg";
  static const kiDrawerLogout = "$_base/app_drawer_assets/logout.svg";
  static const kiDrawerMessenger = "$_base/app_drawer_assets/messanger.svg";
  static const kiDrawerProtal = "$_base/app_drawer_assets/portal.svg";
  static const kiDrawerProjects = "$_base/app_drawer_assets/projects.svg";
  static const kiDrawerSupport = "$_base/app_drawer_assets/support.svg";
  static const kiDrawerAboutUs = "$_base/app_drawer_assets/aboutUs.svg";
  static const kiDrawerClients = "$_base/app_drawer_assets/clients.svg";
  static const kiDrawerFAQs = "$_base/app_drawer_assets/faq.svg";
  static const kifilter = "$_base/filter.svg";
  static const kiAddLink = "$_base/addlink.svg";
  static const kiNearestEventsActive = "$_base/NearestEventsIcons/active.svg";
  static const kiNearestEventsBirthDay = "$_base/NearestEventsIcons/birthday.svg";
  static const kiNearestEventsConnect = "$_base/NearestEventsIcons/connect.svg";
  static const kiNearestEventsMeeting = "$_base/NearestEventsIcons/meeting.svg";
  static const kiStatistics = "$_base/info_portal_assets/statistics.svg";
  static const kiFolder = "$_base/info_portal_assets/folder.svg";
  static const kiFolder1 = "$_base/info_portal_assets/folder1.svg";
  static const kiFolder2 = "$_base/info_portal_assets/folder2.svg";
  static const kiFolder3 = "$_base/info_portal_assets/folder3.svg";
  static const kiInfoLocation = "$_base/location.svg";
  static const kiAboutUsPNG = "$_base/aboutUs.png";
  static const kiaddComment = "$_base/addcomment.svg";
  static const kiClientsProfile1 = "$_base/clients/c1.png";
  static const kiClientsProfile2 = "$_base/clients/c1.png";
  static const kiClientsProfile3 = "$_base/clients/c3.png";
  static const kiClientsProfile4 = "$_base/clients/c4.png";
  static const kiClientsProfile5 = "$_base/clients/c5.png";
  static const kiDmProfile1 = kLeadProfilePic6;
  static const kiDmProfile2 = "$_base/DMs_profile_image/DM2.png";
  static const kiDmProfile3 = "$_base/DMs_profile_image/DM3.png";
  static const kiDmProfile4 = kiActivitylogProfileImage1;
  static const kiDmProfile5 = "$_base/DMs_profile_image/DM5.png";
  static const klMessagePinMessage = "$_base/message_options_icons/pin.svg";
  static const klMessageReply = "$_base/message_options_icons/addcomment.svg";
  static const klMessageShare = "$_base/message_options_icons/share.svg";
  static const klMessageEdit = "$_base/message_options_icons/edit.svg";
  static const klMessageDelete = "$_base/message_options_icons/delete.svg";
  static const klFAQsGettingStarted = "$_base/faqs/getting_started.svg";
  static const klFAQsLeads = "$_base/faqs/leads.svg";
  static const klFAQsProjects = "$_base/faqs/projects.svg";
  static const klAddMember = "$_base/addmember.svg";
  static const klChatDetailsInfo = "$_base/chat_details_assets/info.svg";
  static const klChatDetailsMembers = "$_base/chat_details_assets/members.svg";
  static const klChatDetailsMedia = "$_base/chat_details_assets/media.svg";
  static const klChatDetailsFiles = "$_base/chat_details_assets/files.svg";
  static const klChatDetailsLinks = "$_base/chat_details_assets/links.svg";

  static const mainLogo = "$_base/main_logo.png";
   
  // auth assets
  static const emailSent = "$_base/email.png";
  static const setPassword = "$_base/set_password.png";
  static const setPassword1 = "$_base/set_password_1.png";
  static const loginImg = "$_base/auth_assets/login.jpg";
}

class AnimationAssets{

  const AnimationAssets._();

  /// Contains all the paths of animations used across the project.
  static const _base = BasePaths.baseAnimationPath;

  static const sampleAnimationPath = "$_base/animation.png";
  static const loginMobile = "$_base/login_mobile.json";
  static const loginLady = "$_base/login_lady.json";
  static const formLogin = "$_base/form_login.json";
  
}

class IconAssets{
  const IconAssets._();
  /// Contains all the paths of animations used across the project.
  static const _base = BasePaths.baseIconPath;

  static const sampleIconPath = "$_base/icon.png";
  static const logo123 = "$_base/logo_123.svg";
}

class AssetFonts{
  static const roboto = "Roboto";
  static const inter = "Inter";
  static const poppins = "Poppins";
  static const nunitosans = "Nutrino_Sans";
  static const lato = "Lato";

}
class PlaceholderAssets {

  const PlaceholderAssets._();

  static const _base = BasePaths.basePlaceholderPath;

  static const carouselCardJpeg = "$_base/carousel_placehoder.jpeg";
}