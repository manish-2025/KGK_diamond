import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk_diamond/common/constants.dart';
import 'package:kgk_diamond/logic/filterResult/filter_result_cubit.dart';
import 'package:kgk_diamond/presentation/common_widgets.dart';

class SortByWidget extends StatefulWidget {
  final FilterResultCubit filterResultCubit;

  const SortByWidget({super.key, required this.filterResultCubit});

  @override
  State<SortByWidget> createState() => _SortByWidgetState();
}

class _SortByWidgetState extends State<SortByWidget> {
  late final FilterResultCubit filterResultCubit;
  int selectedIndex = 1;

  @override
  void initState() {
    filterResultCubit = widget.filterResultCubit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterResultCubit, FilterResultState>(
      builder: (context, filterState) {
        if (filterState is FilterResultLoadedState) {
          selectedIndex = filterResultCubit.filterId;
          return Container(
            height: 350.0,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0),
                ),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    ListView.separated(
                      itemCount: filterResultCubit.sortBy.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String title = filterResultCubit.sortBy[index];
                        if (title.isEmpty) {
                          return SizedBox.shrink();
                        }
                        return buildSortByItem(
                          index: index,
                          filterResultCubit: filterResultCubit,
                          filterState: filterState,
                        );
                      },
                      separatorBuilder: (context, index) {
                        if (index % 2 == 1) {
                          return Divider(height: 10);
                        }
                        return SizedBox.shrink();
                      },
                    ),

                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CommonWidgets().commonButton(
                            onTap: () {
                              Navigator.pop(context, 0);
                            },
                            width: 130,
                            height: 45,
                            title: AppConstants.cancel,
                            buttonColor: Colors.white,
                            textColor: Colors.black,
                          ),

                          CommonWidgets().commonButton(
                            onTap: () {
                              Navigator.pop(context, selectedIndex);
                            },
                            width: 130,
                            height: 45,
                            title: AppConstants.apply,
                            buttonColor: Colors.blueGrey,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  Widget buildSortByItem({
    required int index,
    required FilterResultCubit filterResultCubit,
    required FilterResultLoadedState filterState,
  }) {
    return GestureDetector(
      onTap: () async {
        if (selectedIndex != index) {
          selectedIndex = index;
          await filterResultCubit.setFilterId(
            fId: selectedIndex,
            filterState: filterState,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          spacing: 10,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Container(
                margin: EdgeInsets.all(2.5),
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      index == selectedIndex
                          ? Colors.black
                          : Colors.transparent,
                ),
              ),
            ),
            Text(filterResultCubit.sortBy[index]),
          ],
        ),
      ),
    );
  }
}
