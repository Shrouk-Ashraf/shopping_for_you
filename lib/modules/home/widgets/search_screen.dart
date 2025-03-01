import 'package:flutter/material.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';
import 'package:four_you_ecommerce/core/inputs/search_text_field.dart';
import 'package:four_you_ecommerce/main.dart';
import 'package:four_you_ecommerce/modules/home/cubit/home_cubit.dart';
import 'package:four_you_ecommerce/modules/home/widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen(
      {super.key,
      required this.cubit,
      required this.isSearch,
      required this.onSearch});
  final HomeCubit cubit;
  final bool isSearch;
  final Function(bool) onSearch;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isSearch = false;
  @override
  void initState() {
    super.initState();
    isSearch = widget.isSearch;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, ${prefs!.getString('username')}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 24,
              ),
              SearchTextField(
                controller: searchController,
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      isSearch = false;
                    });
                  } else {
                    setState(() {
                      isSearch = true;
                    });
                    widget.cubit.searchedProducts = widget.cubit.products
                        .where((product) => product.title
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                    widget.onSearch(isSearch).call();
                  }
                },
              ),
            ],
          ),
        ),
        widget.cubit.searchedProducts.isNotEmpty
            ? Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: widget.cubit.searchedProducts.length,
                  itemBuilder: (context, index) {
                    final product = widget.cubit.searchedProducts[index];
                    return ProductCard(
                      product: product,
                    );
                  },
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              ),
      ],
    );
  }
}
