import 'package:contacts_service/contacts_service.dart';
import 'package:digital_receipt/constant.dart';
import 'package:digital_receipt/models/customer.dart';
import 'package:digital_receipt/widgets/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../widgets/create_receipt_step0.dart';

class ContactDropdown extends StatefulWidget {
  const ContactDropdown({
    this.contacts,
    this.onSubmit,
  });
  final List contacts;  
  final Function onSubmit;

  @override
  _ContactDropdownState createState() => _ContactDropdownState();
}

class _ContactDropdownState extends State<ContactDropdown> {
  List<Contact> contacts = [];
  List<Contact> tempContactList = [];
  Future contactFuture;
  getContact() async {
    if (await Permission.contacts.request().isGranted) {
      var val = await contactFuture;
      setState(() {
        contacts = List.from(val);
        tempContactList = List.from(val);
      });
    }
  }

  searchContactList(String val) {
    //print(_customerList[0].name.contains(val));
    setState(() {
      contacts = tempContactList
          .where((e) => e.displayName.toLowerCase().contains(val.toLowerCase()))
          .toList();
    });
  }

  setFuture() async {
    if (await Permission.contacts.request().isGranted) {
      contactFuture = ContactsService.getContacts();
    }
  }

//permission_handler
  @override
  void initState() {
    setFuture();
    getContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<Customer> customers = Provider.of<Customer>(context).customerList;
    return SizedBox(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 100,
              bottom: 10,
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).dialogBackgroundColor,
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width - 32,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onChanged: (val) {
                        //print('jhj');
                        searchContactList(val);
                      },
                      decoration: InputDecoration(
                        hintText: "Search...",
                        prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        ),
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                    SizedBox(height: 20),
                    FutureBuilder(
                        future: contactFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Expanded(
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.5,
                                ),
                              ),
                            );
                          } else if (
                              contacts.isNotEmpty) {
                            print(contacts);
                            return Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: contacts.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      widget.onSubmit(contacts[index]);
                                      Navigator.pop(context);
                                    },
                                    child: ContactCard(
                                      receiptTitle: contacts[index].displayName,
                                      subtitle: contacts[index]
                                          .phones
                                          .toList()[0]
                                          .value,
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return Expanded(child: kEmpty);
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
