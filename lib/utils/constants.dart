class Constants {
  // space values
  static const double smallSpace = 10.0;
  static const double mediumSpace = 20.0;
  static const double largeSpace = 30.0;

  // border radius
  static const double borderRadius = 10.0;

  // keys
  static const String user = 'User';
  static const String isLoggedIn = 'IsLoggedIn';

  // courier types
  static const String express = "express";
  static const String standard = "standard";
  static const String custom = "custom";

  // courier package size
  static const String smallPackage = "small";
  static const String mediumPackage = "medium";
  static const String largePackage = "large";

  // courier package type
  static const String document = "document";
  static const String electronics = "electronics";
  static const String fragile = "fragile";

  // payment types
  static const String cash = 'Cash';
  static const String card = "Card payment";

  // order status
  static const String orderPlaced = "Order placed";
  static const String orderPickedUp = "Order picked-up";
  static const String processing = "Processing";
  static const String readyForPickup = "Ready for pick-up";
  static const String readyForDelivery = "Ready for delivery";
  static const String atBranch = "At branch";
  static const String atStorage = "At store";
  static const String outForDelivery = "Out for delivery";
  static const String delivered = "Delivered";
  static const String returnInProcess = "Return in-process";
  static const String refunded = "Refunded";

  // default order status Ids
  static const String statusOrderPickedUp = "65e33666b6d7601896f4b1cc";
  static const String statusDelivered = '65e336d4b6d7601896f4b1d4';

  // baseURLs
  static const String development_URL = "http://192.168.1.6:8000/api/v1";
  static const String production_URL = "http://192.168.1.6:8000/api/v1";
  static const String server_URL = "http://192.168.1.6:8000";
}
