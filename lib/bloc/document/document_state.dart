part of 'document_bloc.dart';

abstract class DocumentState extends Equatable {
  const DocumentState();
}

class HomeLoadingState extends DocumentState {
  @override
  List<Object> get props => [];
}

class HomeLoadedState extends DocumentState {
  final int id;
  final int idUser;
  final String nama;
  final String description;
  final String image;

  HomeLoadedState(
      this.id, this.idUser, this.nama, this.description, this.image);
  @override
  // TODO: implement props
  List<Object?> get props => [id, idUser, nama, description, image];
}

class HomeNoInternetState extends DocumentState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
