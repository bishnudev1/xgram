class User{
  String? name;
  String? email;
  String? password;
  String? phone;
  String? address;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? uid;

  User({this.name, this.email, this.password, this.phone, this.address, this.city, this.state, this.country, this.pincode, this.uid});

  User.fromMap(Map<String, dynamic> data){
    name = data['name'];
    email = data['email'];
    password = data['password'];
    phone = data['phone'];
    address = data['address'];
    city = data['city'];
    state = data['state'];
    country = data['country'];
    pincode = data['pincode'];
    uid = data['uid'];
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'pincode': pincode,
      'uid': uid,
    };
  }
}