import 'package:example/CartScreen/cart_bloc.dart';
import 'package:example/ProductsScreen/Product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final bool isHided = true;

  const ProductCard({Key key, this.product}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Box box = Hive.box('Cart');
  CartBloc cartBloc;
  int count;

  @override
  void initState() {
    count = widget.product.count;
    cartBloc = context.read<CartBloc>()..add(InitCart());
    cartBloc.listen((state) {
      Product product = box.get(widget.product.id);

      setState(() {
        count = product?.count ?? 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 102,
      margin: EdgeInsets.only(left: 16, right: 16, top: 10),
      decoration: BoxDecoration(
          color: CupertinoColors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Image(
              width: 100,
              image: NetworkImage(
                  "https://api.doover.tech${widget.product.picture}"),
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            width: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.product.name,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Срок чистки /',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                        '${Duration(seconds: widget.product.duration.toInt()).inDays}'
                        ' дня')
                  ],
                ),


                     Row(
                      children: [
                        CupertinoButton(
                          child: Icon(
                            CupertinoIcons.add_circled,
                            color: CupertinoColors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              count++;
                              box.put(widget.product.id, widget.product..count = count);
                            });
                            cartBloc.add(AddProduct(widget.product..count = count));
                          },
                          padding: EdgeInsets.all(1),
                        ),
                        Text('$count'),
                        Offstage(
                          offstage: count == 0,
                          child: CupertinoButton(
                            child: Icon(
                              CupertinoIcons.minus_circle,
                              color: CupertinoColors.black,
                            ),
                            onPressed: () {
                              count != 1
                                  ? setState(() {
                                      count--;
                                      box.put(widget.product.id, widget.product..count = count);
                                    })
                                  : box.delete(widget.product.id);
                              cartBloc.add(RemoveProduct(widget.product));
                            },
                            padding: EdgeInsets.all(1),
                          ),
                        ),
                      ],
                    ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 109,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                          color: CupertinoColors.lightBackgroundGray,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8))),
                      child: Center(
                        child: GestureDetector(
                          child: Text(
                            '?',
                            style: TextStyle(color: Colors.grey),
                          ),
                          onTap: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) => Container(
                                child: CupertinoActionSheet(
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            widget.product.hintTitle,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  CupertinoColors.systemGrey3,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(5),
                                                  bottomLeft:
                                                      Radius.circular(5)),
                                            ),
                                            child: GestureDetector(
                                              child: Icon(
                                                Icons.clear,
                                                color: Colors.black,
                                              ),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child:
                                          Text(widget.product.hintDescription),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '${widget.product.price.toInt()}' + ' тг',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
