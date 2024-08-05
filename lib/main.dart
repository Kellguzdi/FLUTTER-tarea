import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/modelo_cubit.dart';
import 'repository/repository.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ModeloCubit(Repository())..fetchModelos()),
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
