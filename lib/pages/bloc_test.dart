import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docscan/bloc/document/document_bloc.dart';
import 'package:docscan/service/document_service.dart';
import 'package:docscan/service/connectivity_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DocumentBloc(
        RepositoryProvider.of<DocumentService>(context),
        RepositoryProvider.of<ConnectivityService>(context),
      )..add(LoadApiEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Activities for bored people'),
        ),
        body: BlocBuilder<DocumentBloc, DocumentState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeLoadedState) {
              return Column(
                children: [
                  Text(state.id.toString()),
                  Text(state.idUser.toString()),
                  Text(state.nama),
                  Text(state.nama),
                  Text(state.description),
                  Text(state.image),
                  ElevatedButton(
                    onPressed: () => BlocProvider.of<DocumentBloc>(context)
                        .add(LoadApiEvent()),
                    child: const Text('LOAD NEXT'),
                  )
                ],
              );
            }
            if (state is HomeNoInternetState) {
              return const Text('no internet :(');
            }
            return Container();
          },
        ),
      ),
    );
  }
}
