import 'package:example/CartScreen/cart_bloc.dart';
import 'package:example/CategoryScreen/category_bloc/category_bloc.dart';
import 'package:example/Consts/color_consts.dart';
import 'package:example/Consts/text_style_consts.dart';
import 'package:example/ProductsScreen/Product_card.dart';
import 'package:example/ProductsScreen/Product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  // final Product product;

  const CartScreen({Key key, }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int sum = 0;
  int totalCount;
  CartBloc cartBloc;

  refresh() {
    setState(() {});
  }

  @override
  void initState() {
    cartBloc = context.read<CartBloc>();

    _setValues(cartBloc.state);

    cartBloc.listen((state) {
      _setValues(state);
    });
    super.initState();
  }

  void _setValues(List<Product> state) {
    sum = state
        .map((e) => e.count * e.price)
        .reduce((value, element) => value + element).toInt();

    totalCount =
        state.map((e) => e.count).reduce((value, element) => value + element);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, List<Product>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return Offstage();
        } else {
          return Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 50,
                color: AllColors.CardBackgroundColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        'Корзина',
                        textAlign: TextAlign.center,
                        style: AllTextStyles.AppBarTextStyle,
                      ),
                      padding: EdgeInsets.only(left: 170),
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Очистить',
                          style: AllTextStyles.LogOutTextStyle
                        ),
                      ),
                      onTap: () {
                        cartBloc.add(ClearCart());
                      },
                    )
                  ],
                ),
              ),
              BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, categoryState) {
                return Expanded(
                  child: ListView.separated(
                      padding: EdgeInsets.only(top: 10, bottom: 20),
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: state.length,
                      itemBuilder: (context, index) {
                        return ProductCard(state[index], callBack: refresh);
                      }),
                );
              }),
              Container(
                height: 126,
                width: MediaQuery.of(context).size.width,
                color: AllColors.CardBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Общая сумма $sum тг',
                            style: AllTextStyles.SumTextStyle,
                          ),
                          Text('$totalCount вещи')
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 375,
                        height: 43,
                        child: CupertinoButton(
                          padding: EdgeInsets.all(1),
                          borderRadius: BorderRadius.circular(6),
                          color: AllColors.ButtonColor,
                          onPressed: () {
                            sum > 0 ? cartBloc.add(ConfirmCart()) : Offstage();
                          },
                          child: Text(
                            'Оформить',
                            style: AllTextStyles.ButtonTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        }
      },
    );
  }
}
