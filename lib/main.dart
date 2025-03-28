import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:kgk_diamond/common/constants.dart';
import 'package:kgk_diamond/data/entity/diamond_entity.dart';
import 'package:kgk_diamond/logic/data_logic/diamond_data_cubit.dart';
import 'package:kgk_diamond/logic/filterResult/filter_result_cubit.dart';
import 'package:kgk_diamond/logic/myCart/my_cart_cubit.dart';
import 'package:kgk_diamond/presentation/globals.dart';
import 'package:kgk_diamond/presentation/pages/filter_page.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive
    ..init(appDocumentDirectory.path)
    ..registerAdapter(DiamondEntityAdapter());
  await Hive.openBox(HiveConstants.DIAMOND_BOX);
  diamondBox = Hive.box(HiveConstants.DIAMOND_BOX);
  hiveCardData = List<DiamondEntity>.from(
    await diamondBox.get(HiveConstants.MY_CART_ITEM) ?? [],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DiamondDataCubit()),
        BlocProvider(create: (context) => FilterResultCubit()),
        BlocProvider(create: (context) => MyCartCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.red,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            color: const Color.fromARGB(255, 15, 0, 55),
          ),
        ),
        home: const FilterPage(),
      ),
    );
  }
}
