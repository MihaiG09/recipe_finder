class RecipeExceptions implements Exception {
  final String message;
  final int? statusCode;
  final String? description;
  final Map<String, dynamic>? errors;
  final RecipeExceptionsType type;

  RecipeExceptions({
    required this.message,
    required this.type,
    this.statusCode,
    this.description,
    this.errors,
  });

  @override
  String toString() {
    return 'AuthUserException {message: $message, description: $description,'
        ' statusCode: $statusCode, errors:$errors, type: $type}';
  }
}

enum RecipeExceptionsType {
  unauthorizedRequest,
  emptyResult,
  unknown,
  invalidRequest,
}
