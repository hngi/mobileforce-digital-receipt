// import 'package:digital_receipt/constant.dart';
// import 'package:digital_receipt/models/customer.dart';
// import 'package:digital_receipt/models/receipt.dart';
// import 'package:digital_receipt/screens/customer_detail_screen.dart';

// import 'package:digital_receipt/services/api_service.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:search_widget/search_widget.dart';

// import 'package:digital_receipt/screens/customer_detail_screen.dart';

// /// This code displays only the UI
// class CustomerList extends StatefulWidget {
//   @override
//   _CustomerListState createState() => _CustomerListState();
// }

// class _CustomerListState extends State<CustomerList> {
//   String dropdownValue = "Last Upadated";

//   ApiService _apiService = ApiService();

//   @override
//   void initState() {
//     super.initState();

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Color(0xffE5E5E5),
//       appBar: AppBar(
//         //backgroundColor: Color(0xff226EBE),

//         title: Text(
//           "Customer List",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             fontFamily: 'Montserrat',
//             letterSpacing: 0.03,
//           ),
//         ),
//         //centerTitle: true,
//       ),

//       body: FutureBuilder(
//         future: _apiService.getAllCustomers(), // receipts from API

//         builder: (context, snapshot) {
//           // If the API returns nothing it means the user has to upgrade to premium
//           // for now it doesn't validate if the user has upgraded to premium
//           /// If the API returns nothing it shows the dialog box `JUST FOR TESTING`
//           ///

//          // print(snapshot.data);
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(
//                 strokeWidth: 1.5,
//               ),
//             );
//           } else if (snapshot.connectionState == ConnectionState.done &&
//               snapshot.hasData &&
//               snapshot.data.length > 0) {
//             return Padding(
//               padding: EdgeInsets.only(top: 15.0, left: 16, right: 16),
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(height: 10.0),

//                   //##################################################//

//                   TextFormField(
//                     onTap: () {showSearch(context: context, delegate: SearchList());},
//                     decoration: InputDecoration(
//                       hintText: "Type a keyword",
//                       hintStyle: TextStyle(
//                         color: Color.fromRGBO(0, 0, 0, 0.38),
//                       ),
//                       prefixIcon: IconButton(
//                         icon: Icon(Icons.search),
//                         color: Color.fromRGBO(0, 0, 0, 0.38),
//                         onPressed: () {},
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(
//                           color: Color.fromRGBO(0, 0, 0, 0.12),
//                           width: 1,
//                         ),
//                       ),
//                       contentPadding: EdgeInsets.all(15),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5),
//                         borderSide: BorderSide(
//                           color: Color(0xFFC8C8C8),
//                           width: 1.5,
//                         ),
//                       ),
//                     ),
//                   ),

//                   //##################################################//

//                   SizedBox(height: 30.0),
//                   Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//                     Padding(
//                       padding: EdgeInsets.only(right: 10.0),
//                       child: Text("Sort By"),
//                     ),
//                     Container(
//                       width: 150,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         border: Border.all(
//                           color: Color(0xff25CCB3),
//                         ),
//                       ),
//                       child: SizedBox(
//                         height: 40,
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton(
//                             value: dropdownValue,
//                             underline: Divider(),
//                             items: <String>[
//                               "Last Upadated",
//                               "A to Z",
//                               "Z to A",
//                             ].map<DropdownMenuItem<String>>(
//                               (String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(left: 8.0),
//                                     child: Text(
//                                       value,
//                                       textAlign: TextAlign.start,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ).toList(),
//                             onChanged: (String value) {
//                               setState(() => dropdownValue = value);
//                               // No logic Implemented
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                   ]),
//                   SizedBox(height: 20.0),
//                   Flexible(
//                     child: ListView.builder(
//                       itemCount: snapshot.data.length,
//                       itemBuilder: (context, index) {
//                         return customer(
//                           customerName: snapshot.data[index]['name'],
//                           customerEmail: snapshot.data[index]['email'],
//                           phoneNumber: snapshot.data[index]['phoneNumber'],
//                           // numberOfReceipts: 0,
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return Container(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   kBrokenHeart,
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Center(
//                     child: Text(
//                       "You don't have any customer!",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontWeight: FontWeight.w300,
//                         fontSize: 16,
//                         letterSpacing: 0.3,
//                         color: Color.fromRGBO(0, 0, 0, 0.87),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                 ],
//               ),
//             );
//           }
//           // }
//         },
//       ),
//     );
//   }

//   Widget customer(
//       {String customerName, customerEmail, phoneNumber, int numberOfReceipts}) {
//     return Column(
//       children: <Widget>[
//         SizedBox(
//           height: 99,
//           child: Center(
//             child: Slidable(
//               actionPane: SlidableDrawerActionPane(),
//               actionExtentRatio: 0.25,
//               secondaryActions: <Widget>[
//                 Container(
//                   color: Color(0xFFB3E2F4),
//                   child: InkWell(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Icon(
//                           Icons.call,
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Text(
//                           "Call Customer",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   color: Color(0xffBFEDC7),
//                   child: InkWell(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Image.asset("assets/gmail.png", height: 24, width: 24),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Text(
//                           "Mail Customer",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//               child: InkWell(
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                         builder: (context) => CustomerDetail(
//                               customer: Customer(
//                                   name: customerName,
//                                   email: customerEmail,
//                                   phoneNumber: phoneNumber,
//                                   address: ''),
//                             )),
//                   );
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Color(0xff539C30),
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Color(0xff539C30),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Container(
//                       margin: EdgeInsets.only(left: 5.0),
//                       decoration: BoxDecoration(
//                         color: Color(0xffE8F1FB),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.all(10.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Text(
//                                   "$customerName",
//                                   style: TextStyle(
//                                     color: Color.fromRGBO(0, 0, 0, 0.6),
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                     fontFamily: 'Montserrat',
//                                     letterSpacing: 0.03,
//                                   ),
//                                 ),
//                                 /* Text(
//                                   "$numberOfReceipts Receipts",
//                                   style: TextStyle(
//                                     color: Color.fromRGBO(0, 0, 0, 0.6),
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w300,
//                                     fontFamily: 'Montserrat',
//                                     letterSpacing: 0.03,
//                                   ),
//                                 ), */
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
//                             child: Text(
//                               "$customerEmail",
//                               style: TextStyle(
//                                 color: Color.fromRGBO(0, 0, 0, 0.87),
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w300,
//                                 fontFamily: 'Montserrat',
//                                 letterSpacing: 0.03,
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
//                             child: Text(
//                               "$phoneNumber",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w300,
//                                 fontFamily: 'Montserrat',
//                                 letterSpacing: 0.03,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 19,
//         ),
//       ],
//     );
//   }
// }

// final customerr = [
//   'abcd',
//   'bcde',
//   'cdef',
//   'defg',
//   'efgh',
//   'fghi',
//   'ghij',
//   'hijk',
//   'ijkl',
//   'jklm',
//   'klmn',
//   'lmno',
//   'mnop',
//   'nopq',
//   'jane doe',
//   'opqr',
//   'pqrs',
//   'qrst',
//   'rstu',
//   'stuv',
//   'tuvw',
//   'uvwx',
//   'vwxy',
//   'wxyz',
//   'xyza',
//   'yzab',
//   'zabc',
// ];

// final customer1 = [
//   'jane doe',
// ];

// class SearchList extends SearchDelegate<CustomerList>{

//   @override
//   List<Widget> buildActions(BuildContext context) {
//       return [
//         IconButton(icon: Icon(Icons.clear),
//         onPressed: (){
//           query = '';
//         }
//         )
//       ];
//       throw UnimplementedError();
//     }

//     @override
//     Widget buildLeading(BuildContext context) {
//       return (
//         IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
//           close(context, null);
//         })
//       );
//       throw UnimplementedError();
//     }

//     @override
//     Widget buildResults(BuildContext context) {
//       return Center(
//         child: Container(
//           width: 400,
//           height: 200,
//           color: Color(0xffb3b3b3),
//           child: Text("This is supposed to be a receipt",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//         )
//       );

//     }

//     @override
//     Widget buildSuggestions(BuildContext context) {
//       final suggestionlist = query.isEmpty
//       // ignore: unnecessary_statements
//       ?customerr:customer1.where((searchitem)=> searchitem.startsWith(query)).toList();

//     return ListView.builder(itemBuilder: (context, index) => ListTile(
//       leading: Icon(Icons.receipt),
//       title: RichText(
//         text: TextSpan(
//           text: suggestionlist[index].substring(0, query.length),
//           style: TextStyle(color: Colors.black),
//           children: [
//             TextSpan(
//               text: customer1[index].substring(query.length),
//               style: TextStyle(color: Colors.grey)
//             )
//           ]
//         ),
//         ),
//        onTap: () {
//          showResults(context);
//          },
//       ));
//     throw UnimplementedError();
//   }

// }
