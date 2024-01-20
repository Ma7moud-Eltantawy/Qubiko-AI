class UserData{
  final String? userid;
  final String? name;
  final String?email;
  final String?phone;
  final String? pic;
  final bool? verified;
  final bool? Premiun;
  final String? premuimtodate;
  final String? Premuimplan;
  final String? DateofBirth;


  UserData(  {
    required this.email,
    required this.userid,
    required this.name,
    required this.phone,
    required this.pic,
    required this.verified,
    required this.Premiun,
    required this.premuimtodate,
    required this.Premuimplan,
    required this.DateofBirth,
  });
}