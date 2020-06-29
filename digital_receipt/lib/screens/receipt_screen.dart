import 'package:flutter/material.dart';


class ReceiptScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFFF2F8FF),
      appBar: AppBar(
        backgroundColor: Color(0xFF0b56a7),
        automaticallyImplyLeading: true,
        title: Text('Create Receipt',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              //Implement code for back action here
            }
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ReceiptScreenLayout()
          ],
        ),
      ),
    );
  }
}

Widget ReceiptScreenLayout() {

  return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          color: Color(0xFFF2F8FF),
          child: Text('All Done, share!',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          alignment: FractionalOffset(0.05, 0.05),
        ),


        //Main part of the receipt page

        Container(
          margin: EdgeInsets.fromLTRB(10,20,10,20),
          padding: EdgeInsets.all(0),
          alignment: Alignment.topCenter,
          width: 325,
          decoration: BoxDecoration(
            color: Color(0xFFF2F8FF),
            border: Border.all(
              color: Colors.grey[500],
            ),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //Colored green section
                      Container(
                        color:Color(0xFF539C30),
                        height: 13,
                        width: 323,
                      ),


                      Container(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              'Geek Tutor',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                      ),


                      Center(
                        child:Text(
                          '2118 Thornridge Cir. Syracuse, Connecticut',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),

                      Center(
                        child: Text(
                          '35624',
                          style: TextStyle(
                              color: Colors.black,
                          ),
                        ),
                      ),

                      Center(
                        child: Text(
                          'Tel No: (603) 555-0123',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),

                      Center(
                        child:Text(
                          'Email: cfroschauerc@ucoz.ru',
                          style: TextStyle(
                              color: Colors.black,
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: const DashedSeparator(color: Colors.grey),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        margin: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Container(
                              padding: EdgeInsets.only(bottom: 8),
                              child:
                              Text('Date: 17-06-2020'),
                            ),

                            Text('Reciept No: 10334'),

                            Container(
                              padding: EdgeInsets.fromLTRB(0,8,0,8),
                              child: Text('Customer Information',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text('Name: Denys Wilacot'),
                            ),

                            Container(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text('Email: zpopley3@nifty.com'),
                            ),

                            Container(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text('Phone No: 741-142-4459'),
                            ),

                            Container(
                              padding: EdgeInsets.only(top:8),
                              child: Text('Product details',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),


                      //List of products and quantities
                      Container(
                        //product details title
                        padding: EdgeInsets.only(top:8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(8,0,8,0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.fromLTRB(3,0,8,0),
                                              child: Text('1'),
                                            ),

                                            Expanded(
                                                child: Container(
                                                  child: Text('Description'),
                                                )
                                            ),

                                            Container(
                                              child: Text('Unit Price'),
                                            ),

                                          ],
                                        )
                                    )
                                  ],
                                )
                            )
                          ],
                        ),
                      ),

                      //First product on the list bought or purchased

                      Container(

                        padding: EdgeInsets.only(top:8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(8,0,8,0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[

                                            Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.fromLTRB(16,0,8,0),
                                                  child: Text('After effects for dummies course'),
                                                )
                                            ),

                                            Container(
                                              child: Text('₦50,000'),
                                            ),

                                          ],
                                        )
                                    )
                                  ],
                                )
                            )
                          ],
                        ),
                      ),


                      //quantity of products order and the total price (HEADER)
                      Container(

                        padding: EdgeInsets.only(top:8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(8,16,8,0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[

                                            Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.fromLTRB(16,0,8,0),
                                                  child: Text('Qty'),
                                                )
                                            ),

                                            Container(
                                              child: Text('Total'),
                                            ),

                                          ],
                                        )
                                    )
                                  ],
                                )
                            )
                          ],
                        ),
                      ),

                      Container(

                        padding: EdgeInsets.only(top:8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(8,0,8,0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[

                                            Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.fromLTRB(16,0,8,0),
                                                  child: Text('X 1'),
                                                )
                                            ),

                                            Container(
                                              child: Text('₦50,000'),
                                            ),

                                          ],
                                        )
                                    )
                                  ],
                                )
                            )
                          ],
                        ),
                      ),
                      Divider(),


                      //SECOND PRODUCT ORDER LIST

                      //List of products and quantities
                      Container(
                        //product details title
                        padding: EdgeInsets.only(top:8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(8,0,8,0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.fromLTRB(3,0,8,0),
                                              child: Text('2'),
                                            ),

                                            Expanded(
                                                child: Container(
                                                  child: Text('Description'),
                                                )
                                            ),

                                            Container(
                                              child: Text('Unit Price'),
                                            ),

                                          ],
                                        )
                                    )
                                  ],
                                )
                            )
                          ],
                        ),
                      ),

                      Container(

                        padding: EdgeInsets.only(top:8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(8,0,8,0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[

                                            Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.fromLTRB(16,0,8,0),
                                                  child: Text('Crytotrading course'),
                                                )
                                            ),

                                            Container(
                                              child: Text('₦30,000'),
                                            ),

                                          ],
                                        )
                                    )
                                  ],
                                )
                            )
                          ],
                        ),
                      ),


                      //quantity of products order and the total price (HEADER)
                      Container(

                        padding: EdgeInsets.only(top:8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(8,16,8,0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[

                                            Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.fromLTRB(16,0,8,0),
                                                  child: Text('Qty'),
                                                )
                                            ),

                                            Container(
                                              child: Text('Total'),
                                            ),

                                          ],
                                        )
                                    )
                                  ],
                                )
                            )
                          ],
                        ),
                      ),


                      //quantiy of purchased products and total price

                      Container(

                        padding: EdgeInsets.only(top:8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(8,0,8,0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[

                                            Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.fromLTRB(16,0,8,0),
                                                  child: Text('X 1'),
                                                )
                                            ),

                                            Container(
                                              child: Text('₦30,000'),
                                            ),

                                          ],
                                        )
                                    )
                                  ],
                                )
                            )
                          ],
                        ),
                      ),
                      Divider(),

                      Container(
                        //toatal payment and stamp
                        padding: EdgeInsets.only(top:8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(99,0,4,0),
                                        // alignment: Alignment.bottomRight,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.fromLTRB(32,0,8,0),
                                              child: Text('Total'),
                                            ),

                                            Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.fromLTRB(16,0,8,0),

                                                  child: Image.asset('assets/images/paid-stamp.png'),
                                                )
                                            ),

                                            Container(
                                              child: Text('₦80,000'),
                                            ),

                                          ],
                                        )
                                    )
                                  ],
                                )
                            )
                          ],
                        ),
                      ),

                      //SIGNATURE section
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                        height: 60,
                        width: 60,
                        child: Image.asset('assets/images/signature.png'),
                      ),

                      Container(
                          padding: const EdgeInsets.only(left: 20.0, right: 250.0),
                          child: Divider(
                            color: Colors.grey[500],
                          )),

                      Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                          child: Text("Signature")),

                    ],

                  ))
                ],
              ),
            ],

          ),

        ),

        //SHARE BUTTON

        MaterialButton(
          padding: EdgeInsets.all(5.0),
          color: Color(0xFF0b56a7),
          textTheme: ButtonTextTheme.primary ,
          minWidth: 350,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text('Share',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),),
          onPressed: (){
            //take this action
          },
        ),

      ]
  );


}


class DashedSeparator extends StatelessWidget {
  final double height;
  final Color color;

  const DashedSeparator({this.height = 1, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}