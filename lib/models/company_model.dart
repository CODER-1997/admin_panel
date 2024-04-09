class CompanyData {
  final String companyName;
  final String companyPhone;
  final String price20LWater;
  final String companyLogo;
  final String createdAt;
  final String discountRate;



  CompanyData({
    required this.companyName,
    required this.companyLogo,
    required this.companyPhone,
    required this.price20LWater,
    required this.createdAt,
    required this.discountRate,

  });

// Convert the object to a map
  Map<String, dynamic> toMap() {
    return {
      'companyName': companyName,
      'companyLogo': companyLogo,
      'companyPhone': companyPhone,
      'price20LWater': price20LWater,
      'createdAt': createdAt,
      'discountRate': discountRate,

    };
  }
}
