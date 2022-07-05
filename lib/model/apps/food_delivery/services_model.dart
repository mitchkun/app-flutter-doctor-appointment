class ServicesModel {
  late int id;
  late String name;
  late int duration;
  late int price;
  late String currency;
  late String description;
  late String availabilitiesType;

  late String location;

  ServicesModel(
      {required this.id,
      required this.name,
      required this.duration,
      required this.price,
      required this.currency,
      required this.description,
      required this.availabilitiesType,
      required this.location});
}
