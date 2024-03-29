class ApiConst {

  static const String ipAddress = "192.168.1.20";
  static const String baseUrl = "http://$ipAddress:8000/api"; //ip Address

  //authentication apis
  static const String register = "$baseUrl/register";
  static const String login = "$baseUrl/login";
  static const String getProfile = "$baseUrl/users/byId";
  static const String updateProfil = "$baseUrl/UpdateProfil";
  static const String updatePassword = "$baseUrl/updatepassword";
  static const String refreshToken = "$baseUrl/refreshtoken";
  static const String forgetPassword = "$baseUrl/forgetPassword";
  static const String verifyOTP = "$baseUrl/VerifCode";
  static const String resetPassword = "$baseUrl/Resetpassword";
  static const String updateUserImage = "$baseUrl/updateImage";

  //cart apis
  static const String addCart = "$baseUrl/cart/add";
  static const String getCart = "$baseUrl/cart/get";
  static const String updateCart = "$baseUrl/cart/update";
  static const String deleteCart = "$baseUrl/cart/delete";

   //cart apis
  static const String addWishlist = "$baseUrl/wishlist/add";
  static const String getWishlist = "$baseUrl/wishlist/get";
  static const String updateWishlist = "$baseUrl/wishlist/update";
  static const String deleteWishlist = "$baseUrl/wishlist/delete";



  //static const String paiement = "$baseUrl/payment";
/*
  //product apis
  static const String products = "$baseUrl/products";
  static const String category = "$baseUrl/products/category";

  //review apis
  static const String reviews = "$baseUrl/reviews";

  //rating apis
  static const String ratings = "$baseUrl/ratings";

  //promotions apis
  static const String getPromotions = "$baseUrl/";

  //cart apis
  static const String cart = "$baseUrl/carts";
  static const String getCart = "$baseUrl/carts/find";
  
  //fournisseur apis 
  static const String fournisseur = "$baseUrl/fournisseurs";

  //category apis
  static const String getCategories = "$baseUrl/categories";

 //category apis
  static const String sales = "$baseUrl/sales";

  //category apis
  static const String reclamations = "$baseUrl/reclamations";
*/
  //assets apis
  static const String images = "http://$ipAddress:8000/uploads/images";
}
