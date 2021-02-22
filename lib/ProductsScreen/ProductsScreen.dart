import 'package:example/CategoryScreen/Category_model.dart';
import 'package:example/CategoryScreen/category_bloc/category_bloc.dart';
import 'package:example/Consts/text_style_consts.dart';
import 'package:example/LoginScreen/injections.dart';
import 'package:example/ProductsScreen/Product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatefulWidget {
  final Category category;


  const ProductsScreen({Key key, this.category}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryBloc>(
      create: (_) =>
      getIt<CategoryBloc>()
        ..add(LoadProducts()),
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            height: 50,
            color: CupertinoColors.white,
            child: Stack(
              children: [
                CupertinoButton(
                    child: Icon(
                      CupertinoIcons.back,
                      color: CupertinoColors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Center(
                    child: Text(
                      widget.category.name,
                      textAlign: TextAlign.center,
                      style: AllTextStyles.AppBarTextStyle,
                    )),
              ],
            ),
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is ProductsLoading) {
                return Center(child: CupertinoActivityIndicator());
              } else if (state is ProductsFailure) {
                return Text(state.error);
              } else if (state is ProductsSuccess) {
                return Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 5,
                      );
                    },
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return ProductCard( state.products[index]);
                    },
                  ),
                );
              } else {
                return Offstage();
              }
            },
          )
        ],
      ),
    );
  }
}
