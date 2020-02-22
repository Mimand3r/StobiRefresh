import 'dart:ui';

class AppColors {
  static final top_bar_gradient_start = HexColor("#024547");
  static final top_bar_gradient_end = HexColor("#003334");
  static final top_bar_schieberegler = HexColor("#9EBEBF");
  static final background_gradient_start = HexColor("#568485");
  static final background_gradient_end = HexColor("#74C6C8");
  static final myChatBubble_gradient_start = HexColor("#1D3A60");
  static final myChatBubble_gradient_end = HexColor("#152944");
  static final otherChatBubble_gradient_start = HexColor("#0F3434");
  static final otherChatBubble_gradient_end = HexColor("#1A5858");
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
