import 'package:dartz/dartz.dart';
import 'package:movies_app/core/exceptions/Failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
