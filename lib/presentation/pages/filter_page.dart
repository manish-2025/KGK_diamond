import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk_diamond/logic/data_logic/diamond_data_cubit.dart';
import 'package:kgk_diamond/logic/data_logic/diamond_data_state.dart';
import 'package:kgk_diamond/presentation/common_widgets.dart';
import 'package:kgk_diamond/presentation/pages/result_page.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late DiamondDataCubit diamondDataCubit;

  @override
  void initState() {
    diamondDataCubit = BlocProvider.of<DiamondDataCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "Filter",
          style: CommonWidgets().textStyle(color: Colors.white, fSize: 25),
        ),
      ),
      body: buildBody(context: context),
    );
  }

  Widget buildBody({required BuildContext context}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: BlocConsumer<DiamondDataCubit, DiamondDataState>(
        listener: (context, state) {
          if (state is DiamondDataLoadedState &&
              state.filteredDiamondData.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResultPage()),
            );
          }
        },
        builder: (context, state) {
          if (state is DiamondDataBlocInitial) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is DiamondDataErrorState) {
            return Center(child: Text(state.error));
          }
          if (state is DiamondDataLoadedState) {
            return Stack(
              children: [
                dataList(state: state),
                Positioned(bottom: 0, child: buildActionButton(state: state)),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget dataList({required DiamondDataLoadedState state}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            buildCaratesWidget(data: state.carates, loadedState: state),
            buildFilterDataWidget(
              data: state.labs,
              title: "Labs",
              loadedState: state,
            ),
            buildFilterDataWidget(
              data: state.shapes,
              title: "Shaps",
              loadedState: state,
            ),
            buildFilterDataWidget(
              data: state.color,
              title: "Colors",
              loadedState: state,
            ),
            buildFilterDataWidget(
              data: state.clarity,
              title: "Clarity",
              loadedState: state,
            ),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  Widget buildCaratesWidget({
    required List<double> data,
    required DiamondDataLoadedState loadedState,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 0,
        children: [
          CommonWidgets().filterItemTitleText(
            context: context,
            title: "Carates",
            textColor: Colors.black,
            bgColor: const Color.fromARGB(31, 144, 142, 142),
            borderColor: Colors.black12,
          ),
          Center(
            child: buildCarateRangeWidget(data: data, loadedState: loadedState),
          ),
          Center(
            child: Text("OR", style: CommonWidgets().textStyle(fSize: 20)),
          ),
          Wrap(
            children: List.generate(data.length, (index) {
              String cData = data[index].toString();
              return GestureDetector(
                onTap: () {
                  diamondDataCubit.updateSelectedCarates(
                    loadedState: loadedState,
                    item: data[index],
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(3),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black12),
                    color:
                        diamondDataCubit.selectedCarates.contains(data[index])
                            ? Colors.green.shade100
                            : Colors.transparent,
                  ),
                  child: Text(cData, style: CommonWidgets().textStyle()),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildCarateRangeWidget({
    required List<double> data,
    required DiamondDataLoadedState loadedState,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CommonWidgets().commonTextFormField(
              loadedState: loadedState,
              diamondDataCubit: diamondDataCubit,
              title: "From",
              validationValue: data.first.toString(),
              controller: diamondDataCubit.fromCarateController,
              context: context,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: CommonWidgets().commonTextFormField(
              title: "To",
              validationValue: data.last.toString(),
              controller: diamondDataCubit.toCarateController,
              context: context,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFilterDataWidget({
    required List<String> data,
    required String title,
    required DiamondDataLoadedState loadedState,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 0,
        children: [
          CommonWidgets().filterItemTitleText(
            context: context,
            title: title,
            textColor: Colors.black,
            bgColor: const Color.fromARGB(31, 144, 142, 142),
            borderColor: Colors.black12,
          ),
          Wrap(
            children: List.generate(data.length, (index) {
              String cData = data[index].toString();
              return GestureDetector(
                onTap: () {
                  switch (title) {
                    case "Labs":
                      diamondDataCubit.updateSelectedLabs(
                        loadedState: loadedState,
                        item: cData,
                      );
                      break;
                    case "Shaps":
                      diamondDataCubit.updateSelectedShapes(
                        loadedState: loadedState,
                        item: cData,
                      );
                      break;
                    case "Colors":
                      diamondDataCubit.updateSelectedColors(
                        loadedState: loadedState,
                        item: cData,
                      );
                      break;
                    case "Clarity":
                      diamondDataCubit.updateSelectedClarities(
                        loadedState: loadedState,
                        item: cData,
                      );
                      break;
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black12),
                    color: getColor(title: title, item: cData),
                  ),
                  child: Text(cData, style: CommonWidgets().textStyle()),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildActionButton({required DiamondDataLoadedState state}) {
    return Container(
      color: Colors.white,
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildButton(title: "Reset", state: state),
          buildButton(title: "Search", state: state),
        ],
      ),
    );
  }

  Widget buildButton({
    required String title,
    required DiamondDataLoadedState state,
  }) {
    return GestureDetector(
      onTap: () {
        if (canFilter() && title == 'Search') {
          diamondDataCubit.filterData(loadedState: state);
        }
        if (title == 'Reset') {
          diamondDataCubit.resetFilterData(loadedState: state);
        }
      },
      child: CommonWidgets().commonButton(
        title: title,
        buttonColor:
            title == 'Reset'
                ? Colors.white
                : canFilter() == true
                ? Colors.green
                : const Color.fromARGB(255, 232, 228, 228),
        textColor:
            title == 'Reset'
                ? Colors.black
                : canFilter() == true
                ? Colors.white
                : Colors.black54,
      ),
    );
  }

  getColor({required String title, required String item}) {
    switch (title) {
      case "Labs":
        return diamondDataCubit.selectedLabs.contains(item)
            ? Colors.green.shade100
            : Colors.transparent;
      case "Shaps":
        return diamondDataCubit.selectedShapes.contains(item)
            ? Colors.green.shade100
            : Colors.transparent;
      case "Colors":
        return diamondDataCubit.selectedColors.contains(item)
            ? Colors.green.shade100
            : Colors.transparent;
      case "Clarity":
        return diamondDataCubit.selectedClarities.contains(item)
            ? Colors.green.shade100
            : Colors.transparent;
    }
  }

  bool canFilter() {
    if (diamondDataCubit.selectedCarates.isNotEmpty ||
        diamondDataCubit.selectedClarities.isNotEmpty ||
        diamondDataCubit.selectedColors.isNotEmpty ||
        diamondDataCubit.selectedLabs.isNotEmpty ||
        diamondDataCubit.selectedShapes.isNotEmpty ||
        diamondDataCubit.toCarateController.text.isNotEmpty ||
        diamondDataCubit.fromCarateController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
