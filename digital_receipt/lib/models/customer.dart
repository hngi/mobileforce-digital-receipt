import 'package:flutter/cupertino.dart';

class Customer extends ChangeNotifier{
  String name;
  String email;
  String phoneNumber;
  String address;

  Customer({
    this.name,
    this.email,
    this.phoneNumber,
    this.address,
  });

  setName(name) => this.name = name;
  setEmail(email) => this.email = email;
  setPhoneNumber(phoneNumber) => this.phoneNumber = phoneNumber;
  setAddress(address) => this.address = address;

  @override
  String toString() {
    return '$name : $email : $phoneNumber : $address';
  }

  static List<Customer> dummy() => [
        Customer(
            name: 'Carole Froschauer',
            email: 'Carole@gmail.com',
            phoneNumber: '+234 8123 4567 890',
            address: '2118 Thornridge Cir. Syracuse, Ikorodu'),
        Customer(
            name: 'Froschauer Carole',
            email: 'Froschauer@gmail.com',
            phoneNumber: '+234 8123 4567 890',
            address: '2118 Thornridge Cir. Syracuse, Belgium, Mushin'),
        Customer(
            name: 'Seyi Ipaye',
            email: 'Seyi@gmail.com',
            phoneNumber: '+234 8123 4567 890',
            address: '2118 Thornridge Cir. Syracuse, Ogun, Mushin'),
        Customer(
            name: 'Froooooschauer Carole',
            email: 'Froschauer@gmail.com',
            phoneNumber: '+234 8123 4567 890',
            address: '2118 Thornridge Cir. Syracuse, UAE'),
      ];
}
