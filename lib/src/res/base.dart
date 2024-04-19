import 'package:ccms/src/utils/config.dart';

class BasePaths{

  const BasePaths._();

  static const baseImagePath = "assets/images";
  static const baseAnimationPath = "assets/animations";
  static const baseIconPath = "assets/icons";
  static const basePlaceholderPath = "assets/placeholders";
  // static const baseProdUrl = "http://productionURL.com";
  static const baseProdUrl = "http://10.0.2.2:3000";
  static const baseTestUrl = "http://10.0.2.2:3000";
  static const baseUrl = AppConfig.devMode ? baseTestUrl : baseProdUrl;
}