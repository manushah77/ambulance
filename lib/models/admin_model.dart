class AdminData {
  String? image;
  String? phone;
  String? fname;
  String? lname;
  String? id;
  String? email;

  String? carDetail;
  String? idCardNumber;
  String? carName;
  String? carModel;

  String? pushToken;
  double? latituelocation;
  double? longitudelocation;

  AdminData({
    this.fname,
    this.lname,
    this.phone,
    this.email,
    this.id,
    this.image,
    this.pushToken,
    this.latituelocation,
    this.longitudelocation,

    this.carDetail,
    this.carModel,
    this.carName,
    this.idCardNumber,

  }
  );

  AdminData.fromMap(Map<String, dynamic> map) {
    image = map['image'] ?? '';
    phone = map['phoneNumber'] ?? '';
    email = map['email'] ?? '';
    id = map['id'] ?? '';
    pushToken = map['pushToken'] ?? '';
    fname = map['firstName'] ?? '';
    lname = map['lastName'] ?? '';
    longitudelocation = map['longitudeLocation'] ?? 0.0;
    latituelocation = map['latitueLocation'] ?? 0.0;

    carName = map['carName'] ?? '';
    carModel = map['carModel'] ?? '';
    carDetail = map['carDetail'] ?? '';
    idCardNumber = map['DriveridNumber'] ?? '';


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

    _data['carName'] = carName;
    _data['carModel'] = carModel;
    _data['carDetail'] = carDetail;
    _data['DriveridNumber'] = idCardNumber;


    return _data;
  }
}
