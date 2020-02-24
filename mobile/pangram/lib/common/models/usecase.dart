import 'package:equatable/equatable.dart';

abstract class UseCaseStream<State, Payload>{
  Stream<State> call(Payload payload);
}

abstract class UseCase<Type, Payload> {
  Future<Type> call(Payload payload);
}

class NoPayload extends Equatable{
  const NoPayload();

  List<Object> get props => [];
}