part of 'document_bloc.dart';

abstract class DocumentEvent extends Equatable {
  const DocumentEvent();
}

class LoadApiEvent extends DocumentEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NoInternetEvent extends DocumentEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
