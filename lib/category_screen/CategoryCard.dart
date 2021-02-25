import 'package:example/category_screen/CategoryModel.dart';
import 'package:example/Consts/text_style_consts.dart';
import 'package:example/products_screen/ProductsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            maintainState: false,
            builder: (context) => ProductsScreen(category: category),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 84,
          decoration: BoxDecoration(color: CupertinoColors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
                      child: Text(category.name.toUpperCase(),
                          style: AllTextStyles.CategoryTitleTextStyle),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 4, 16, 10),
                      child: Text(
                        category.description,
                        style: AllTextStyles.CardHintTextStyle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: (MediaQuery.of(context).size.width - 32) *
                    (343 - 229) /
                    343,
                child: Image(
                  image: NetworkImage(
                      "https://api.doover.tech${category.picture}"),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
