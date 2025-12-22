import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoiceTile extends StatelessWidget {
  final String choice;
  final dynamic value;
  final dynamic groupValue;
  final Function(dynamic)? onChanged;

  const ChoiceTile(
      {super.key,
      required this.choice,
      required this.value,
      required this.groupValue,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    bool isSelected = value == groupValue;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onChanged?.call(value),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? context.theme.colorScheme.primary
                    : context.theme.colorScheme.outline.withOpacity(0.2),
                width: isSelected ? 2 : 1,
              ),
              color: isSelected
                  ? context.theme.colorScheme.primary.withOpacity(0.05)
                  : context.theme.colorScheme.surface,
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? context.theme.colorScheme.primary
                          : context.theme.colorScheme.outline.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.theme.colorScheme.primary,
                            ),
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    choice,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: isSelected
                          ? context.theme.colorScheme.primary
                          : context.theme.colorScheme.onSurface,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
