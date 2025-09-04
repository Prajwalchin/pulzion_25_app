class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  String? college;
  String? year;
  String? createdAt;
  String? updatedAt;
  String? referralCode;
  int? count;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.college,
    this.year,
    this.createdAt,
    this.updatedAt,
    this.referralCode,
    this.count,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json["user"]["id"];
    firstName = json["user"]["first_name"];
    lastName = json["user"]["last_name"];
    email = json["user"]["email"];
    mobileNumber = json["user"]["mobile_number"];
    college = json["user"]["college"];
    year = json["user"]["year"];
    createdAt = json["user"]["created_at"];
    updatedAt = json["user"]["updated_at"];
    referralCode = json["referral_code"];
    count = json["count"];
  }

  User.fromJson2(Map<String, dynamic> json) {
    id = json["id"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    email = json["email"];
    mobileNumber = json["mobile_number"];
    college = json["college"];
    year = json["year"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    referralCode = json["referral_code"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["user"]["id"] = id;
    data["user"]["first_name"] = firstName;
    data["user"]["last_name"] = lastName;
    data["user"]["email"] = email;
    data["user"]["mobile_number"] = mobileNumber;
    data["user"]["college"] = college;
    data["user"]["year"] = year;
    data["user"]["created_at"] = createdAt;
    data["user"]["updated_at"] = updatedAt;
    data["referral_code"] = referralCode;
    data["count"] = count;

    return data;
  }
}

// Creating a singleton class for user token
class UserToken {
  String? token;

  UserToken._privateConstructor();

  static final UserToken _instance = UserToken._privateConstructor();

  factory UserToken() {
    return _instance;
  }
}
