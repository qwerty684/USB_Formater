enum FormattingStage {
  starting,
  preparingDevice,
  erasingPartitions,
  creatingFileSystem,
  finishingProcess,
  completed,
}

class FormattingProgress {
  const FormattingProgress({required this.progress, required this.stage});

  final double progress;
  final FormattingStage stage;
}
