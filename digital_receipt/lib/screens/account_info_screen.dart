import 'package:digital_receipt/widgets/app_solid_button.dart';
import 'package:digital_receipt/widgets/app_text_form_field.dart';
import 'package:digital_receipt/widgets/create_receipt_step2.dart';
import 'package:flutter/material.dart';
import 'package:digital_receipt/constant.dart';

class AccountInfoScreen extends StatefulWidget {
  @override
  _AccountInfoScreenState createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  TextEditingController _hexCodeController = TextEditingController()
    ..text = "F14C4C";
  final FocusNode _hexCodeFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Business card',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text(
                'Samples',
                style: Theme.of(context).textTheme.headline5.copyWith(
                      fontSize: 18,
                    ),
              ),
              SizedBox(
                height: 24,
              ),
              BusinessCardRow(),
              SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Choose a color (optional)',
                  ),
                  SizedBox(width: 12),
                  Text(_hexCodeController.text.toUpperCase()),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 33,
                child: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ColorButton(
                          color: Colors.red,
                          onPressed: () {
                            setState(() {
                              _hexCodeController.text = 'F14C4C';
                            });
                          },
                        ),
                        ColorButton(
                          color: Color(0xFF539C30),
                          onPressed: () {
                            setState(() {
                              _hexCodeController.text = '539C30';
                            });
                          },
                        ),
                        ColorButton(
                          color: Color(0xFF2C33D5),
                          onPressed: () {
                            setState(() {
                              _hexCodeController.text = '2C33D5';
                            });
                          },
                        ),
                        ColorButton(
                          color: Color(0xFFE7D324),
                          onPressed: () {
                            setState(() {
                              _hexCodeController.text = 'E7D324';
                            });
                          },
                        ),
                        ColorButton(
                          color: Color(0xFFC022B1),
                          onPressed: () {
                            setState(() {
                              _hexCodeController.text = 'C022B1';
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
              AppTextFormField(
                focusNode: _hexCodeFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) => _hexCodeFocus.unfocus(),
                controller: _hexCodeController,
                hintText: 'Enter Brand color hex code',
                hintColor: Theme.of(context).textTheme.subtitle2.color,
                borderWidth: 1.5,
                readOnly: true,
              ),
              SizedBox(height: 40),
              AppSolidButton(
                height: 50,
                //isLoading: isLoading,
                text: 'Generate Receipt',
                onPressed: () async {
                  // check the internet
                },
              ),
              // SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

class BusinessCardRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Card(child: BusinessCard0()),
          Card(
            child: SizedBox(
              height: 180,
              width: 293,
            ),
          ),
          Card(
            child: SizedBox(
              height: 180,
              width: 293,
            ),
          ),
          Card(
            child: SizedBox(
              height: 180,
              width: 293,
            ),
          ),
        ],
      ),
    );
  }
}

class BusinessCard0 extends StatefulWidget {
  @override
  _BusinessCard0State createState() => _BusinessCard0State();
}

class _BusinessCard0State extends State<BusinessCard0> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 293,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 30,
            child: Image.asset('assets/images/Rectangle 86.png'),
          ),
          Positioned(
            right: 0,
            bottom: 30,
            child: Image.asset('assets/images/Rectangle 87.png'),
          ),
          Container(
            height: 180,
            width: 293,
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 50,
                      height: 20,
                      child: Image.asset('assets/logos/logo.png'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Chief Priest',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontSize: 12,
                              ),
                        ),
                        Text(
                          'C.E.O',
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontSize: 12,
                              ),
                        ),
                      ],
                    )
                  ],
                ),
                Text(
                  'Degeit Technologies',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontSize: 14, color: Color(0xFF0B57A7)),
                ),
                SizedBox(height: 5.0),
                Text(
                  'Dealers in all form of digital technologies',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontSize: 9,
                      ),
                ),
                SizedBox(height: 20.0),
                Row(
                  children: <Widget>[
                    Image.asset('assets/icons/locationIcon.png'),
                    SizedBox(width: 7.0),
                    Text(
                      'No 16, IBB road, wuse zone 10, Abuja',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontSize: 11,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Image.asset('assets/icons/phoneIcon.png'),
                    SizedBox(width: 7.0),
                    Text(
                      '090 4433 9922, 080 2256 7343',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontSize: 11,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Image.asset('assets/icons/messageIcon.png'),
                    SizedBox(width: 7.0),
                    Text(
                      'Degeittech@yahoo.com',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontSize: 11,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          image:
              DecorationImage(image: AssetImage('assets/images/Vector.png'))),
    );
  }
}
