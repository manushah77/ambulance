class UserData {
  String? image;
  String? phone;
  String? fname;
  String? lname;
  String? id;
  String? email;
  String? pushToken;
  double? latituelocation;
  double? longitudelocation;

  UserData({
    this.fname,
    this.lname,
    this.phone,
    this.email,
    this.id,
    this.image,
    this.pushToken,
    this.latituelocation,
    this.longitudelocation,
  });

  UserData.fromMap(Map<String, dynamic> map) {
    image = map['image'] ?? '';
    phone = map['phoneNumber'] ?? '';
    email = map['email'] ?? '';
    id = map['id'] ?? '';
    pushToken = map['pushToken'] ?? '';
    fname = map['firstName'] ?? '';
    lname = map['lastName'] ?? '';
    longitudelocation = map['longitudeLocation'] ?? 0.0;
    latituelocation = map['latitueLocation'] ?? 0.0;
  }

  Map<String, dynamic> toMap() {
    final _data = <String, dynamic>{};
    _data['image'] = image;
    _data['firstName'] = fname;
    _data['lastName'] = lname;
    _data['phoneNumber'] = phone;
    _data['pushToken'] = pushToken;
    _data['id'] = id;
    _data['email'] = email;
    _data['longitudeLocation'] = longitudelocation;
    _data['latitueLocation'] = latituelocation;

    return _data;
  }
}
