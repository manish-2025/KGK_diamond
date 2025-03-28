import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kgk_diamond/common/constants.dart';
import 'package:kgk_diamond/data/entity/diamond_entity.dart';
import 'package:kgk_diamond/logic/data_logic/diamond_data_cubit.dart';
import 'package:kgk_diamond/logic/data_logic/diamond_data_state.dart';
import 'package:kgk_diamond/logic/filterResult/filter_result_cubit.dart';
import 'package:kgk_diamond/logic/myCart/my_cart_cubit.dart';

class CommonWidgets {
  textStyle({Color? color, double? fSize, FontWeight? fontWeight}) {
    return TextStyle(
      color: color ?? Colors.black,
      fontWeight: fontWeight,
      fontSize: fSize ?? 11.0,
    );
  }

  commonButton({
    required String title,
    required Color buttonColor,
    required Color textColor,
    double? height,
    double? width,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 40,
        width: width ?? 80,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color.fromARGB(255, 231, 230, 230)),
        ),
        child: Center(
          child: Text(
            title,
            style: textStyle(
              color: textColor,
              fSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget commonTextFormField({
    required String validationValue,
    required String title,
    required TextEditingController controller,
    DiamondDataLoadedState? loadedState,
    DiamondDataCubit? diamondDataCubit,
    String? Function(String?)? validator,
    int? maxLen,
    List<TextInputFormatter>? inputFormatters,
    required BuildContext context,
  }) {
    return SizedBox(
      height: 35,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: title.length < 4 ? 10 : 5,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: CommonWidgets().textStyle(
                  color: Colors.black,
                  fSize: 14,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: TextFormField(
                validator:
                    validator ??
                    (value) {
                      if (value?.isEmpty == true) {
                        return validationValue;
                      }
                      return null;
                    },

                style: CommonWidgets().textStyle(fSize: 14.5),
                cursorHeight: 20,
                controller: controller,
                inputFormatters: inputFormatters,
                keyboardType: TextInputType.number,
                maxLength: maxLen,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 7.0),
                  border: InputBorder.none,
                  hintText: validationValue,
                  hintStyle: CommonWidgets().textStyle(
                    color: Colors.grey,
                    fSize: 14.5,
                  ),
                ),

                onChanged: (value) {
                  if (diamondDataCubit != null &&
                      loadedState is DiamondDataLoadedState) {
                    diamondDataCubit.updateState(loadedState: loadedState);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildAmountWidget({
    required String title,
    required String amount,
    Color? bgColor,
    Color? textColor,
  }) {
    return Container(
      width: 140,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: bgColor ?? const Color.fromARGB(66, 153, 244, 68),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black54),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: CommonWidgets().textStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            amount,
            style: CommonWidgets().textStyle(
              fontWeight: FontWeight.bold,
              fSize: 12,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  filterItemTitleText({
    required BuildContext context,
    required String title,
    required Color textColor,
    required Color bgColor,
    required Color borderColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
        border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: Text(
        title,
        style: CommonWidgets().textStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
          fSize: 15,
        ),
      ),
    );
  }

  Widget buildDetailsWidget({
    required BuildContext context,
    required DiamondEntity diamond,
    required FilterResultCubit filterResultCubit,
    required MyCartCubit myCartCubit,
    required Widget iconWidget,
    bool fromMyCart = true,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 10, right: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "${double.parse(diamond.discount.toString())} %",
                  style: textStyle(
                    fSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () async {
                  if (fromMyCart) {
                    bool returnVal = await buildDialog(context);
                    if (returnVal == true) {
                      myCartCubit.removeFromCart(
                        diamond: diamond,
                        filterResultCubit: filterResultCubit,
                      );
                    }
                  } else {
                    bool existsById = filterResultCubit.myCardItem.any(
                      (dd) => dd.lotID == diamond.lotID,
                    );

                    if (existsById) {
                      bool returnVal = await buildDialog(context);

                      if (returnVal == true) {
                        filterResultCubit.addToCart(
                          diamondData: filterResultCubit.filteredDiamondData,
                          item: diamond,
                        );
                      }
                    } else {
                      filterResultCubit.addToCart(
                        diamondData: filterResultCubit.filteredDiamondData,
                        item: diamond,
                      );
                    }
                  }
                },
                child: iconWidget,
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
                title: AppConstants.perCarateRate,
                amount: diamond.perCaratRate.toString(),
              ),
              CommonWidgets().buildAmountWidget(
                title: AppConstants.finalAmount,
                amount: diamond.finalAmount.toString(),
                bgColor: Colors.green,
                textColor: Colors.white,
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
