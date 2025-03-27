import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kgk_diamond/logic/data_logic/diamond_data_cubit.dart';
import 'package:kgk_diamond/logic/data_logic/diamond_data_state.dart';

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
  }) {
    return Container(
      height: 40,
      width: 80,
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

  buildAmountWidget({required String title, required String amount}) {
    return Container(
      width: 140,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(66, 153, 244, 68),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black54),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: CommonWidgets().textStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            amount,
            style: CommonWidgets().textStyle(
              fontWeight: FontWeight.bold,
              fSize: 12,
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
}
