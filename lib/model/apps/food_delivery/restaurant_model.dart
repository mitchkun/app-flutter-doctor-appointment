class RestaurantModel {
  late int id;
  late String name;
  late String duration;
  late String price;
  late String currency;
  late double description;
  late double availabilitiesType;
  late String promo;
  late String location;

  RestaurantModel(
      {required this.id,
      required this.name,
      required this.duration,
      required this.price,
      required this.currency,
      required this.description,
      required this.availabilitiesType,
      required this.promo,
      required this.location});
}
