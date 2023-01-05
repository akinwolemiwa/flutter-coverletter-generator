class CoverLetter {
  String? sId;
  String? companyName;
  String? companyAddress;
  String? city;
  String? country;
  String? role;
  String? yearsOfExp;
  String? date;
  String? recipientName;
  String? recipientDepartment;
  String? recipientEmail;
  String? recipientPhoneNo;
  String? coverLetter;
  String? userId;
  int? iV;

  CoverLetter(
      {this.sId,
      this.companyName,
      this.companyAddress,
      this.city,
      this.country,
      this.role,
      this.yearsOfExp,
      this.date,
      this.recipientName,
      this.recipientDepartment,
      this.recipientEmail,
      this.recipientPhoneNo,
      this.coverLetter,
      this.userId,
      this.iV});

  CoverLetter.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    companyName = json['company_name'];
    companyAddress = json['company_address'];
    city = json['city'];
    country = json['country'];
    role = json['role'];
    yearsOfExp = json['years_of_exp'];
    date = json['date'];
    recipientName = json['recipient_name'];
    recipientDepartment = json['recipient_department'];
    recipientEmail = json['recipient_email'];
    recipientPhoneNo = json['recipient_phone_no'];
    coverLetter = json['cover_letter'];
    userId = json['user_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['_id'] = sId;
    data['company_name'] = companyName;
    data['company_address'] = companyAddress;
    data['city'] = city;
    data['country'] = country;
    data['role'] = role;
    data['years_of_exp'] = yearsOfExp;
    data['date'] = date;
    data['recipient_name'] = recipientName;
    data['recipient_department'] = recipientDepartment;
    data['recipient_email'] = recipientEmail;
    data['recipient_phone_no'] = recipientPhoneNo;
    data['cover_letter'] = coverLetter;
    data['user_id'] = userId;
    data['__v'] = iV;

    return data;
  }
}
