import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kgk_diamond/common/constants.dart';
import 'package:kgk_diamond/data/entity/diamond_entity.dart';
import 'package:kgk_diamond/logic/data_logic/diamond_data_cubit.dart';
import 'package:kgk_diamond/logic/data_logic/diamond_data_state.dart';
import 'package:kgk_diamond/logic/filterResult/filter_result_cubit.dart';
import 'package:kgk_diamond/presentation/common_widgets.dart';
import 'package:kgk_diamond/presentation/pages/my_cart_page.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late DiamondDataCubit diamondDataCubit;
  late FilterResultCubit filterResultCubit;

  @override
  void initState() {
    diamondDataCubit = BlocProvider.of<DiamondDataCubit>(context);
    filterResultCubit = BlocProvider.of<FilterResultCubit>(context);
    filterResultCubit.getCartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          AppConstants.searchResult,
          style: TextStyle(color: Colors.white),
        ),
        actions: buildAppBarActionButton(context),
      ),
      body: BlocBuilder<DiamondDataCubit, DiamondDataState>(
        builder: (context, state) {
          if (state is DiamondDataLoadedState) {
            return buildListView(state: state);
          } else {
            return Center(child: Text(AppConstants.somethingWentWrong));
          }
        },
      ),
    );
  }

  List<Widget> buildAppBarActionButton(BuildContext context) {
    return [
      GestureDetector(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/shopping-cart2.svg',
                  height: 30,
                  width: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: BlocBuilder<FilterResultCubit, FilterResultState>(
                    builder: (context, state) {
                      return Text(
                        "${filterResultCubit.myCardItem.length}",
                        style: CommonWidgets().textStyle(
                          color: Colors.white,
                          fSize: 13,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Text(
              AppConstants.myCart,
              style: CommonWidgets().textStyle(
                fSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      SizedBox(width: 15),
    ];
  }

  Widget buildListView({required DiamondDataLoadedState state}) {
    return ListView.builder(
      itemCount: state.filteredDiamondData.length,
      itemBuilder: (context, index) {
        return buildDetailsWidget(
          diamond: state.filteredDiamondData,
          index: index,
          state: state,
        );
      },
    );
  }

  Widget buildDetailsWidget({
    required List<DiamondEntity> diamond,
    required int index,
    required DiamondDataLoadedState state,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("ID : ${diamond[index].lotID.toString()}"),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text("${diamond[index].discount}"),
              ),
              SizedBox(width: 8),
              buildCartIcon(data: diamond[index]),
            ],
          ),
          Divider(height: 10),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppConstants.carates),
                      Text(AppConstants.size),
                      Text(AppConstants.labs),
                      Text(AppConstants.shaps),
                      Text(AppConstants.colors),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(": ${diamond[index].carat}"),
                    Text(": ${diamond[index].size}"),
                    Text(": ${diamond[index].lab}"),
                    Text(": ${diamond[index].shape}"),
                    Text(": ${diamond[index].color}"),
                  ],
                ),
                VerticalDivider(thickness: 2, color: Colors.black26),
                SizedBox(
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppConstants.cut),
                      Text(AppConstants.polish),
                      Text(AppConstants.clarity),
                      Text(AppConstants.symmetry),
                      Text(AppConstants.fluorescence),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(": ${diamond[index].cut.toString()}"),
                    Text(": ${diamond[index].polish.toString()}"),
                    Text(": ${diamond[index].clarity.toString()}"),
                    Text(": ${diamond[index].symmetry.toString()}"),
                    Text(": ${diamond[index].fluorescence.toString()}"),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonWidgets().buildAmountWidget(
                title: AppConstants.perCarateRate,
                amount: diamond[index].perCaratRate.toString(),
              ),
              CommonWidgets().buildAmountWidget(
                title: AppConstants.finalAmount,
                amount: diamond[index].finalAmount.toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCartIcon({required DiamondEntity data}) {
    return BlocBuilder<FilterResultCubit, FilterResultState>(
      builder: (context, fRState) {
        return GestureDetector(
          onTap: () async {
            bool existsByName = filterResultCubit.myCardItem.any(
              (person) => person.lotID == data.lotID,
            );

            if (existsByName) {
              bool returnVal = await buildDialog(context);

              if (returnVal == true) {
                filterResultCubit.addToCart(
                  diamondData: diamondDataCubit.filteredDiamondData,
                  item: data,
                );
              }
            } else {
              filterResultCubit.addToCart(
                diamondData: diamondDataCubit.filteredDiamondData,
                item: data,
              );
            }
          },
          child: SvgPicture.asset(
            filterResultCubit.myCardItem.any(
                  (person) => person.lotID == data.lotID,
                )
                ? 'assets/icons/shopping-cart2.svg'
                : 'assets/icons/shopping-cart-add.svg',
            height: 20,
            width: 20,
          ),
        );
      },
    );
  }

  buildDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Warning"),
          content: Text("Do you want to remove diamond from Cart?"),
          actions: [
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }
}
