class DiscountModel {
  final String Type;
  final String Title;
  final String createdAt;



  DiscountModel({
    required this.Type,
    required this.Title,
    required this.createdAt,

  });

// Convert the object to a map
  Map<String, dynamic> toMap() {
    return {
      'Type': Type,
      'Title': Title,
      'createdAt': createdAt,

    };
  }
}
