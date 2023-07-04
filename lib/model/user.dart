class MyUser {
  final String uid;
  final String displayName;
  final String email;
  final String photoURL;
  bool isDoctor=false;
  MyUser({required this.uid,required this.displayName,required this.email,required this.photoURL});
}

class Doctor{
   String clinicName,educationalQualification ,timing ,address, fee, paymentMethod, bio,uid,displayName,email,photoURL;
   int counter;
   Doctor({required this.uid,required this.displayName,required this.email,required this.photoURL,required this.clinicName,required this.educationalQualification ,required this.timing ,required this.address, required this.fee, required this.paymentMethod, required this.bio,required this.counter, required String name});
}
