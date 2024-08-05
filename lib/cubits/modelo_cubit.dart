// lib/cubits/modelo_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../repository/repository.dart';
import '../models/modelo.dart';

part 'modelo_state.dart';

class ModeloCubit extends Cubit<ModeloState> {
  final Repository repository;

  ModeloCubit(this.repository) : super(ModeloInitial());

  Future<void> fetchModelos() async {
    emit(ModeloLoading());
    try {
      final modelos = await repository.fetchModelos();
      emit(ModeloLoaded(modelos));
    } catch (e) {
      emit(ModeloError(e.toString()));
    }
  }

  Future<void> addModelo(Modelo modelo) async {
    emit(ModeloLoading());
    try {
      await repository.addModelo(modelo);
      fetchModelos(); // Refresh the list
    } catch (e) {
      emit(ModeloError(e.toString()));
    }
  }

  Future<void> updateModelo(Modelo modelo) async {
    emit(ModeloLoading());
    try {
      await repository.updateModelo(modelo);
      fetchModelos(); // Refresh the list
    } catch (e) {
      emit(ModeloError(e.toString()));
    }
  }

  Future<void> deleteModelo(int id) async {
    emit(ModeloLoading());
    try {
      await repository.deleteModelo(id);
      fetchModelos(); // Refresh the list
    } catch (e) {
      emit(ModeloError(e.toString()));
    }
  }
}
