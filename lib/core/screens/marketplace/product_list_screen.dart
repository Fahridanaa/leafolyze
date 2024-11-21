import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafolyze/blocs/product/product_bloc.dart';
import 'package:leafolyze/blocs/product/product_event.dart';
import 'package:leafolyze/blocs/product/product_state.dart';
import 'package:leafolyze/core/widgets/common/custom_search_bar.dart';
import 'package:leafolyze/core/widgets/marketplace/detailed_product_card.dart';
import 'package:leafolyze/utils/constants.dart';

class ProductListScreen extends StatefulWidget {
  final int diseaseId;

  const ProductListScreen({
    super.key,
    required this.diseaseId,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String? selectedSortOption = 'Recently Added';

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProductsByDisease(widget.diseaseId));
  }

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppBorderRadius.radiusS),
        ),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text(
                'Sort By',
                style: TextStyle(
                  fontWeight: AppFontWeight.semiBold,
                  color: AppColors.textMutedColor,
                ),
              ),
            ),
            RadioListTile<String>(
              title: const Text('Recently Added'),
              value: 'Recently Added',
              groupValue: selectedSortOption,
              onChanged: (value) {
                setState(() {
                  selectedSortOption = value;
                });
                context.read<ProductBloc>().add(SortProducts(value!));
                Navigator.pop(context);
              },
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: AppColors.textColor,
            ),
            RadioListTile<String>(
              title: const Text('Price: Low to High'),
              value: 'Price: Low to High',
              groupValue: selectedSortOption,
              onChanged: (value) {
                setState(() {
                  selectedSortOption = value;
                });
                context.read<ProductBloc>().add(SortProducts(value!));
                Navigator.pop(context);
              },
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: AppColors.textColor,
            ),
            RadioListTile<String>(
              title: const Text('Price: High to Low'),
              value: 'Price: High to Low',
              groupValue: selectedSortOption,
              onChanged: (value) {
                setState(() {
                  selectedSortOption = value;
                });
                context.read<ProductBloc>().add(SortProducts(value!));
                Navigator.pop(context);
              },
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: AppColors.textColor,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return CustomScrollView(
            shrinkWrap: true,
            scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.backgroundColor,
                centerTitle: true,
                title: Text(
                  'Products',
                  style: TextStyle(
                    fontSize: AppFontSize.fontSizeXXL,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
                floating: true,
                snap: true,
                pinned: true,
                expandedHeight: 80,
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacingM),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    CustomSearchBar(
                      onChanged: (value) {
                        context.read<ProductBloc>().add(SearchProducts(value));
                      },
                      onSubmitted: (value) {
                        context.read<ProductBloc>().add(SearchProducts(value));
                      },
                    ),
                    SizedBox(height: AppSpacing.spacingM),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _showSortOptions(context),
                            icon: const Icon(
                              Icons.sort,
                              color: AppColors.textColor,
                              size: AppIconSize.iconS,
                            ),
                            label: Text(
                              'Sort By: ${selectedSortOption ?? "Recently Added"}',
                              style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: AppFontSize.fontSizeMS,
                                fontWeight: AppFontWeight.semiBold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(AppSpacing.spacingM),
                sliver: _buildProductList(state),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProductList(ProductState state) {
    if (state is ProductLoading) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state is ProductLoaded) {
      if (state.products.isEmpty) {
        return SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 64,
                  color: AppColors.textMutedColor,
                ),
                SizedBox(height: AppSpacing.spacingS),
                Text(
                  'No products available',
                  style: TextStyle(
                    color: AppColors.textMutedColor,
                    fontSize: AppFontSize.fontSizeL,
                    fontWeight: AppFontWeight.medium,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.63,
          mainAxisSpacing: AppSpacing.spacingMS,
          crossAxisSpacing: AppSpacing.spacingMS,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final product = state.products[index];
            return DetailedProductCard(product: product);
          },
          childCount: state.products.length,
        ),
      );
    }

    if (state is ProductError) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: AppColors.errorColor,
              ),
              SizedBox(height: AppSpacing.spacingS),
              Text(
                state.message,
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: AppFontSize.fontSizeL,
                  fontWeight: AppFontWeight.medium,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.spacingM),
              ElevatedButton.icon(
                onPressed: () {
                  context
                      .read<ProductBloc>()
                      .add(LoadProductsByDisease(widget.diseaseId));
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    return const SliverFillRemaining(
      child: Center(child: Text('Something went wrong')),
    );
  }
}
