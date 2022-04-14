
class User {
  String? collegeName;
  String? rollNumber;
  int? collegeYear;
  User(this.collegeName, this.rollNumber, this.collegeYear);
  Map<String, dynamic> toMap() {
    return {'name': collegeName, 'rollNumber': rollNumber, 'year': collegeYear};
  }
}
