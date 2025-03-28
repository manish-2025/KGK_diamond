import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kgk_diamond/common/constants.dart';
import 'package:kgk_diamond/logic/data_logic/diamond_data_cubit.dart';
import 'package:kgk_diamond/logic/filterResult/filter_result_cubit.dart';
import 'package:kgk_diamond/logic/myCart/my_cart_cubit.dart';
import 'package:kgk_diamond/presentation/common_widgets.dart';
import 'package:kgk_diamond/presentation/pages/my_cart_page.dart';
import 'package:kgk_diamond/presentation/sort_by_widget.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late DiamondDataCubit diamondDataCubit;
  late FilterResultCubit filterResultCubit;
  late MyCartCubit myCartCubit;

  @override
  void initState() {
    diamondDataCubit = BlocProvider.of<DiamondDataCubit>(context);
    filterResultCubit = BlocProvider.of<FilterResultCubit>(context);
    myCartCubit = BlocProvider.of<MyCartCubit>(context);
    filterResultCubit.getFilteredData(diamondDataCubit: diamondDataCubit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(
          AppConstants.searchResult,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<FilterResultCubit, FilterResultState>(
        builder: (context, loadedState) {
          if (loadedState is FilterResultLoadedState) {
            return Column(
              children: [
                buildFilterAndCartWidget(loadedState: loadedState),
                Expanded(child: buildListView(loadedState: loadedState)),
              ],
            );
          } else {
            return Center(child: Text(AppConstants.somethingWentWrong));
          }
        },
      ),
    );
  }

  Widget buildFilterAndCartWidget({
    required FilterResultLoadedState loadedState,
  }) {
    return Container(
      color: const Color.fromARGB(255, 225, 198, 246),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 7,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => MyCartPage(
                          filterResultCubit: filterResultCubit,
                          diamondDataCubit: diamondDataCubit,
                        ),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppConstants.goToCart,
                      style: CommonWidgets().textStyle(
                        fSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 20),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/shopping-cart2.svg',
                          height: 35,
                          width: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: Text(
                            "${loadedState.myCardItem?.length}",
                            style: CommonWidgets().textStyle(
                              color: Colors.white,
                              fSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                modalBottomSheetMenu(
                  selectedId: 0,
                  filterResultCubit: filterResultCubit,
                  filterState: loadedState,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SvgPicture.asset(
                  "assets/icons/sorting.svg",
                  height: 40,
                  width: 40,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget buildListView({required FilterResultLoadedState loadedState}) {
    return ListView.builder(
      itemCount: loadedState.filteredDiamondData.length,
      itemBuilder: (context, index) {
        return CommonWidgets().buildDetailsWidget(
          diamond: loadedState.filteredDiamondData[index],
          myCartCubit: myCartCubit,
          filterResultCubit: filterResultCubit,
          context: context,
          iconWidget: SvgPicture.asset(
            filterResultCubit.myCardItem.any(
                  (diamond) =>
                      diamond.lotID ==
                      loadedState.filteredDiamondData[index].lotID,
                )
                ? 'assets/icons/shopping-cart2.svg'
                : 'assets/icons/shopping-cart-add.svg',
            height: 20,
            width: 20,
          ),
          fromMyCart: false,
        );
      },
    );
  }

  void modalBottomSheetMenu({
    required int selectedId,
    required FilterResultCubit filterResultCubit,
    required FilterResultLoadedState filterState,
  }) async {
    int id = 0;
    id = await showModalBottomSheet(
      context: context,
      builder: (builder) {
        return SortByWidget(filterResultCubit: filterResultCubit);
      },
    );

    if (id > 1) {
      filterResultCubit.sortById(fId: id, loadedState: filterState);
    }
  }
}
