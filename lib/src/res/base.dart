import 'package:ccms/src/utils/config.dart';

class BasePaths{

  const BasePaths._();

  static const baseImagePath = "assets/images";
  static const baseAnimationPath = "assets/animations";
  static const baseIconPath = "assets/icons";
  static const basePlaceholderPath = "assets/placeholders";
  // static const baseProdUrl = "http://productionURL.com";
  static const baseProdUrl = "https://ccms-1vkh.onrender.com";
  static const baseTestUrl = "https://ccms-1vkh.onrender.com";
  static const baseUrl = AppConfig.devMode ? baseTestUrl : baseProdUrl;
}