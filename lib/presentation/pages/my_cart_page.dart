import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk_diamond/data/entity/diamond_entity.dart';
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("My Cart", style: TextStyle(color: Colors.white)),
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
                    "Your Cart is Empty",
                    style: CommonWidgets().textStyle(
                      color: Colors.grey,
                      fSize: 15,
                    ),
                  ),
                  Text(
                    "+ Add Diamond",
                    style: CommonWidgets().textStyle(
                      color: Colors.black,
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
            return buildDetailsWidget(diamond: myCartCubit.diamondData[index]);
          },
        );
      },
    );
  }

  Widget buildDetailsWidget({required DiamondEntity diamond}) {
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
              Text("ID : ${diamond.lotID.toString()}"),
              Spacer(),
              GestureDetector(
                onTap: () async {
                  bool returnVal = await buildDialog(context);
                  if (returnVal == true) {
                    myCartCubit.removeFromCart(
                      diamond: diamond,
                      filterResultCubit: filterResultCubit,
                    );
                  }
                },
                child: Icon(Icons.delete, color: Colors.red),
              ),
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
                      Text('Carate'),
                      Text('Size'),
                      Text('Lab'),
                      Text('Shape'),
                      Text('Color'),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(": ${diamond.carat}"),
                    Text(": ${diamond.size}"),
                    Text(": ${diamond.lab}"),
                    Text(": ${diamond.shape}"),
                    Text(": ${diamond.color}"),
                  ],
                ),
                VerticalDivider(thickness: 2, color: Colors.black26),
                SizedBox(
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cut'),
                      Text('Polish'),
                      Text('Clarity'),
                      Text('Symmetry'),
                      Text('Fluorescence'),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(": ${diamond.cut.toString()}"),
                    Text(": ${diamond.polish.toString()}"),
                    Text(": ${diamond.clarity.toString()}"),
                    Text(": ${diamond.symmetry.toString()}"),
                    Text(": ${diamond.fluorescence.toString()}"),
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
                title: 'Per Carate Rate',
                amount: diamond.perCaratRate.toString(),
              ),
              CommonWidgets().buildAmountWidget(
                title: 'Final Amount',
                amount: diamond.finalAmount.toString(),
              ),
            ],
          ),
        ],
      ),
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
