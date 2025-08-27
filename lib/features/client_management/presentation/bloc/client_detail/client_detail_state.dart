part of 'client_detail_bloc.dart';

abstract class ClientDetailState extends Equatable {
  const ClientDetailState();
  @override
  List<Object> get props => [];
}

class ClientDetailInitial extends ClientDetailState {}
class ClientDetailLoading extends ClientDetailState {}
class ClientDetailDeleteSuccess extends ClientDetailState {}
class ClientDetailFailure extends ClientDetailState {
  final String message;
  const ClientDetailFailure(this.message);
  @override
  List<Object> get props => [message];
}