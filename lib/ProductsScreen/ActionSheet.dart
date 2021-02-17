import 'package:example/ProductsScreen/Product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class ActionSheet extends StatelessWidget {
  final Product product;

  const ActionSheet(this.product, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 204,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16,),
                  Text(
                    product.hintTitle,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24,),
                  Container(
                    width: MediaQuery.of(context).size.width - 60,
                    child: Text(
                      product.hintDescription,
                    ),
                  )
                ],
              ),
              Spacer(),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Color(0xFFEDEFF6),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                ),
                child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.close,
                        color: Color(0xFF172853),
                        size: 18,
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}