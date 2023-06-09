class RequestData {
  String? patientName;
  double? patientAdressLatitue;
  double? patientAdressLongitue;
  String? PatientPhoneNumber;
  String? DriverName;
  String? DriverPhone;
  String? DriverIdNumber;
  String? RequestId;
  String? PatientId;
  double? DriverLatitute;
  double? DriverLongitute;
  String? DriverPicture;

  RequestData({
    this.patientName,
    this.DriverIdNumber,
    this.DriverLatitute,
    this.DriverLongitute,
    this.DriverName,
    this.DriverPhone,
    this.DriverPicture,
    this.patientAdressLatitue,
    this.patientAdressLongitue,
    this.PatientId,
    this.PatientPhoneNumber,
    this.RequestId,
  });

  RequestData.fromMap(Map<String, dynamic> map) {
    patientName = map['patientName'] ?? '';
    DriverIdNumber = map['DriverIdNumber'] ?? '';
    DriverName = map['DriverName'] ?? '';
    DriverPhone = map['DriverPhone'] ?? '';
    DriverPicture = map['DriverPicture'] ?? '';
    PatientId = map['PatientId'] ?? '';

    PatientPhoneNumber = map['PatientPhoneNumber'] ?? '';
    RequestId = map['RequestId'] ?? '';

    DriverLatitute = map['DriverLatitute'] ?? 0;
    DriverLongitute = map['DriverLongitute'] ?? 0;
    patientAdressLatitue = map['patientAdressLatitue'] ?? 0.0;
    patientAdressLongitue = map['patientAdressLongitue'] ?? 0.0;
  }
}
