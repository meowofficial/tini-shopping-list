class UnexpectedStateError extends StateError {
  UnexpectedStateError([super.message = 'Unexpected state']);
}

Never throwStateError([String message = 'Unexpected state']) => throw UnexpectedStateError(message);
