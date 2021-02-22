import 'package:example/CategoryScreen/Category_card.dart';
import 'package:example/CategoryScreen/category_bloc/category_bloc.dart';
import 'package:example/Consts/color_consts.dart';
import 'package:example/Consts/text_style_consts.dart';
import 'package:example/ProductsScreen/Product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();

  FocusNode _focusNode = FocusNode();

  double _width = double.maxFinite;

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _width = 270;
        });
      } else {
        setState(() {
          _width = double.maxFinite;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                height: 40,
                margin: EdgeInsets.only(top: 10),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            _focusNode.unfocus();
                            BlocProvider.of<CategoryBloc>(context).add(LoadCategories());
                          },
                          child: Text(
                            'Отменить',
                            style: AllTextStyles.CancelTextStyle,

                          ),
                        ),
                      ),
                    ),
                    AnimatedSize(
                      curve: Curves.ease,
                      vsync: this,
                      duration: Duration(milliseconds: 300),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 40,
                          width: _width,
                          child: CupertinoTextField(
                            onChanged: (String filter) {
                              context.read<CategoryBloc> ().add(SearchProductEvent(filter));
                            },
                            focusNode: _focusNode,
                            controller: _searchController,
                            decoration: BoxDecoration(
                                color: CupertinoColors.white,
                                borderRadius: BorderRadius.circular(8)),
                            suffixMode: OverlayVisibilityMode.editing,
                            suffix: GestureDetector(
                              child: Icon(CupertinoIcons.clear, color: AllColors.BottomNavBarItemColor),
                              onTap: () {
                                _searchController.clear();
                                _focusNode.unfocus();
                                BlocProvider.of<CategoryBloc>(context).add(LoadCategories());
                              },
                            ),
                            padding: EdgeInsets.all(8),
                            placeholder: 'Найти вещь',
                            style: AllTextStyles.AppBarTextStyle,
                            prefix: Icon(CupertinoIcons.search, color: AllColors.BottomNavBarItemColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return Center(child: CupertinoActivityIndicator());
            } else if (state is CategoryFailure) {
              return Text(state.errorMessage);
            } else if (state is CategorySuccess) {
              return Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 16,
                    );
                  },
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(category: state.categories[index]);
                  },
                ),
              );
            } else if(state is FilteredProductState){
              return Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
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
    );
  }
}

