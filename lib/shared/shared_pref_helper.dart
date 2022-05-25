import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPrefHelper._();

  static final sharedPrefHelper = SharedPrefHelper._();
   SharedPreferences prefs;

  initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  addProductToFavourite(int id) {
    prefs.setBool('$id\_isFavourite', true);
  }

  addProductToCart(int id) {
    prefs.setBool('$id\_isInCart', true);
    increaseProductQuantity(id);
  }

  deleteProductFromFavourite(int id) {
    prefs.setBool('$id\_isFavourite', false);
  }

  deleteProductFromCart(int id) {
    prefs.setBool('$id\_isInCart', false);
    clearProductQuantity(id);
  }

  bool isProductInFavourite(int id) {
    return prefs.getBool('$id\_isFavourite') ?? false;
  }

  bool isProductInCart(int id) {
    return prefs.getBool('$id\_isInCart') ?? false;
  }

  increaseProductQuantity(int id) {
    int previousQuantity = getProductQuantity(id);
    prefs.setInt('$id\_quantity', ++previousQuantity);
  }

  clearProductQuantity(int id) {
    prefs.setInt('$id\_quantity', 0);
  }

  int getProductQuantity(int id) {
    return prefs.getInt('$id\_quantity') ?? 0;
  }

}
