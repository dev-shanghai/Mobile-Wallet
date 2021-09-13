class AppStyle {
  /// app style factory : singleton
  factory AppStyle() {
    return instance;
  }
  AppStyle._internal();


  /// singleton 
  static final AppStyle instance = AppStyle._internal();

  /// app fonts english language
  String appFontsEN = 'MavenPro';

  /// app fonts arabic language
  String appFontsAR = 'MavenPro';

}