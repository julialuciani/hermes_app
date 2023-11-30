class ButtonState {
  final bool isEnabled;
  final bool isLoading;
  const ButtonState({
    required this.isEnabled,
    required this.isLoading,
  });

  ButtonState copyWith({
    bool? isEnabled,
    bool? isLoading,
  }) {
    return ButtonState(
      isEnabled: isEnabled ?? this.isEnabled,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
