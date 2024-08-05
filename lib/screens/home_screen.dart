import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/modelo_cubit.dart';
import '../models/modelo.dart';
import '../repository/repository.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ModeloCubit(Repository())..fetchModelos(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Modelos CRUD'),
        ),
        body: BlocConsumer<ModeloCubit, ModeloState>(
          listener: (context, state) {
            if (state is ModeloError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }
          },
          builder: (context, state) {
            if (state is ModeloLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ModeloLoaded) {
              final modelos = state.modelos;
              return ListView.builder(
                itemCount: modelos.length,
                itemBuilder: (context, index) {
                  final modelo = modelos[index];
                  return ListTile(
                    title: Text(modelo.nombre),
                    subtitle: Text('${modelo.fabricante} - ${modelo.autonomia} km'),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddOrUpdateScreen(modelo: modelo),
                        ),
                      );
                      if (result == true) {
                        context.read<ModeloCubit>().fetchModelos();
                      }
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        context.read<ModeloCubit>().deleteModelo(modelo.id);
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddOrUpdateScreen()),
            );
            if (result == true) {
              context.read<ModeloCubit>().fetchModelos(); // Refresh the list if the result is true
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class AddOrUpdateScreen extends StatelessWidget {
  final Modelo? modelo;

  AddOrUpdateScreen({this.modelo});

  @override
  Widget build(BuildContext context) {
    final nombreController = TextEditingController(text: modelo?.nombre ?? '');
    final fabricanteController = TextEditingController(text: modelo?.fabricante ?? '');
    final autonomiaController = TextEditingController(text: modelo?.autonomia.toString() ?? '');
    final velocidadMaximaController = TextEditingController(text: modelo?.velocidadMaxima.toString() ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(modelo == null ? 'Add New Modelo' : 'Update Modelo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: fabricanteController,
              decoration: InputDecoration(labelText: 'Fabricante'),
            ),
            TextField(
              controller: autonomiaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Autonomía'),
            ),
            TextField(
              controller: velocidadMaximaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Velocidad Máxima'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newModelo = Modelo(
                  id: modelo?.id ?? 0,
                  nombre: nombreController.text,
                  fabricante: fabricanteController.text,
                  autonomia: double.parse(autonomiaController.text),
                  velocidadMaxima: double.parse(velocidadMaximaController.text),
                );

                if (modelo == null) {
                  context.read<ModeloCubit>().addModelo(newModelo);
                } else {
                  context.read<ModeloCubit>().updateModelo(newModelo);
                }

                //reload the list
                Navigator.pop(context, true);
              },
              child: Text(modelo == null ? 'Add' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}