import 'package:example/CartScreen/cart_bloc.dart';
import 'package:example/Consts/color_consts.dart';
import 'package:example/Consts/text_style_consts.dart';
import 'package:example/ProductsScreen/ActionSheet.dart';
import 'package:example/ProductsScreen/Product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final bool isHided = true;
  final void Function() callBack;

  const ProductCard(this.product, {Key key, this.callBack}) : super(key: key);

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
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Container(

        height: 102,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AllColors.CardBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
                width: 64,
                height: 102,
                child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
                          child: Image(
                            height: double.maxFinite,
                            fit: BoxFit.fitHeight,
                            image: NetworkImage("https://api.doover.tech${widget.product.picture}"),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: widget.callBack != null ?  InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(child: ActionSheet(widget.product));
                                }
                            );
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: AllColors.QuestionBackgroundColor,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(8.0),
                                  topLeft: Radius.circular(8.0)),
                            ),
                            child: Center(
                              child: Text(
                                '?',
                                style: AllTextStyles.QuestionTextStyle,
                              ),
                            ),
                          ),
                        ) : Offstage(),
                      ),
                    ]
                )
            ),
            SizedBox(width: 16,),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Container(
                    width: MediaQuery.of(context).size.width - 185,
                    child: Text(
                        widget.product.name,
                        overflow: TextOverflow.ellipsis,
                      style: AllTextStyles.ProductTitleTextStyle,
                    ),
                  ),
                  SizedBox(height: 3),
                  Row(
                      children: [
                        Text(
                          'Срок чистки / ',
                          style: AllTextStyles.Day_TextStyle,
                        ),
                        Text(
                            '${Duration(seconds: widget.product.duration.toInt()).inDays}'
                                ' дня',
                        style: AllTextStyles.Price_Day_TextStyle)
                      ]
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              count++;
                              box.put(widget.product.id, widget.product..count = count);
                              if (widget.callBack != null) widget.callBack();
                            });
                            cartBloc.add(AddProduct(widget.product..count = count));
                          },
                          child: Icon(
                            CupertinoIcons.add_circled,
                            color: AllColors.BottomNavBarSelectedItemColor,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text('$count'),
                        SizedBox(width: 12),
                        count > 0 ? InkWell(
                          onTap: () {
                            count != 1
                                ? setState(() {
                              count--;
                              box.put(widget.product.id, widget.product..count = count);
                              if (widget.callBack != null) widget.callBack();
                            })
                                : box.delete(widget.product.id);
                            cartBloc.add(RemoveProduct(widget.product));
                          },
                          child: Icon(
                            CupertinoIcons.minus_circle,
                            color: AllColors.BottomNavBarSelectedItemColor,
                          ),
                        ) : Container(),
                      ],
                    ),
                  ),
                ]
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                widget.callBack == null
                    ? InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(child: ActionSheet(widget.product));
                        }
                    );
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AllColors.QuestionBackgroundColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0)),
                    ),
                    child: Center(
                      child: Text(
                        '?',
                        style: AllTextStyles.QuestionTextStyle,
                    ),
                  ),
                ),
                    ): InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        setState(() {
                          box.delete(widget.product.id);
                          cartBloc.add(RemoveProduct(widget.product));
                          widget.callBack();
                        });
                      },
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Color(0xFFEDEFF6),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                        ),
                        child: Center(
                          child: Icon(
                            CupertinoIcons.clear,
                            color: AllColors.BottomNavBarItemColor,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 14, 16),
                  child: Text(
                    '${widget.product.price.toInt()} тг',
                    overflow: TextOverflow.ellipsis,
                    style: AllTextStyles.Price_Day_TextStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}