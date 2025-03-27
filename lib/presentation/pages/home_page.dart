import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk_diamond/data/models/data_model.dart';
import 'package:kgk_diamond/logic/data_logic/diamond_data_cubit.dart';
import 'package:kgk_diamond/logic/data_logic/diamond_data_state.dart';
import 'package:kgk_diamond/presentation/pages/filter_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Home"),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FilterPage()),
          );
        },
        child: Text("Filter"),
      ),
      body: BlocBuilder<DiamondDataCubit, DiamondDataState>(
        builder: (context, state) {
          if (state is DiamondDataBlocInitial) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is DiamondDataErrorState) {
            return Center(child: Text(state.error));
          }
          if (state is DiamondDataLoadedState) {
            return dataList(state);
          }
          return SizedBox();
        },
      ),
    );
  }

  Widget dataList(DiamondDataLoadedState state) {
    return ListView.builder(
      itemCount: state.diamondData.length,
      itemBuilder: (context, index) {
        DiamondData data = state.diamondData[index];
        return ListTile(title: Text(data.carat.toString()));
      },
    );
  }
}
