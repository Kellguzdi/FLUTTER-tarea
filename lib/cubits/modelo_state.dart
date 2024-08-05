// lib/cubits/modelo_state.dart
part of 'modelo_cubit.dart';

abstract class ModeloState extends Equatable {
  @override
  List<Object> get props => [];
}

class ModeloInitial extends ModeloState {}

class ModeloLoading extends ModeloState {}

class ModeloLoaded extends ModeloState {
  final List<Modelo> modelos;

  ModeloLoaded(this.modelos);

  @override
  List<Object> get props => [modelos];
}

class ModeloError extends ModeloState {
  final String error;

  ModeloError(this.error);

  @override
  List<Object> get props => [error];
}
