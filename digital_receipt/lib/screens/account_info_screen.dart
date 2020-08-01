import 'package:digital_receipt/widgets/app_solid_button.dart';
import 'package:digital_receipt/widgets/app_text_form_field.dart';
import 'package:digital_receipt/widgets/create_receipt_step2.dart';
import 'package:flutter/material.dart';

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
