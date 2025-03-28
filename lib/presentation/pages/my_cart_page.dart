import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk_diamond/common/constants.dart';
import 'package:kgk_diamond/logic/data_logic/diamond_data_cubit.dart';
import 'package:kgk_diamond/logic/filterResult/filter_result_cubit.dart';
import 'package:kgk_diamond/logic/myCart/my_cart_cubit.dart';
import 'package:kgk_diamond/presentation/common_widgets.dart';

class MyCartPage extends StatefulWidget {
  final FilterResultCubit filterResultCubit;
  final DiamondDataCubit diamondDataCubit;
  const MyCartPage({
    super.key,
    required this.filterResultCubit,
    required this.diamondDataCubit,
  });

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  late FilterResultCubit filterResultCubit;
  late DiamondDataCubit diamondDataCubit;

  late MyCartCubit myCartCubit;

  @override
  void initState() {
    filterResultCubit = widget.filterResultCubit;
    diamondDataCubit = widget.diamondDataCubit;

    myCartCubit = BlocProvider.of<MyCartCubit>(context);
    myCartCubit.getCartData(
      diamondDataCubit: diamondDataCubit,
      filterResultCubit: filterResultCubit,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(AppConstants.myCart, style: TextStyle(color: Colors.white)),
      ),
      body: buildBodyWidget(context),
    );
  }

  buildBodyWidget(BuildContext context) {
    return BlocBuilder<MyCartCubit, double>(
      builder: (context, state) {
        if (myCartCubit.diamondData.isEmpty) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppConstants.emptyCartMsg,
                    style: CommonWidgets().textStyle(
                      color: Colors.white54,
                      fSize: 18,
                    ),
                  ),
                  Text(
                    AppConstants.addDiamondMsg,
                    style: CommonWidgets().textStyle(
                      color: Colors.white,
                      fSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount: myCartCubit.diamondData.length,
          itemBuilder: (context, index) {
            return CommonWidgets().buildDetailsWidget(
              diamond: myCartCubit.diamondData[index],
              myCartCubit: myCartCubit,
              filterResultCubit: filterResultCubit,
              context: context,
              iconWidget: Icon(Icons.delete, color: Colors.red),
            );
          },
        );
      },
    );
  }
}
