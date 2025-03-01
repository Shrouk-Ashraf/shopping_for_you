import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_you_ecommerce/modules/home/cubit/home_cubit.dart';

import '../../products/products_screen.dart';


class CategoryCard extends StatefulWidget {
  final String category;
  const CategoryCard({super.key, required this.category});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomeCubit,HomeState>(
      builder: (context,state) {
        final cubit = HomeCubit.get(context);
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BlocProvider.value(
                          value: cubit,
                          child: ProductsScreen(
                              category: widget.category),
                        ))).then((val) {
              cubit.getCategories();
            });
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 24),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.white,
                border: Border.all(color: Colors.blue)),
            child: Text(widget.category),
          ),
        );
      }
    );
  }
}
