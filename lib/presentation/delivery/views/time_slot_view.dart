import 'package:flutter/widgets.dart';
import 'package:sendx/data/models/manage_pick_up_request_meta/time_slot.dart';

class TimeSlotsWidget extends StatelessWidget {
  const TimeSlotsWidget({super.key, required this.slots});
  final List<TimeSlot> slots;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        slots.length,
        (index) {
          final slot = slots[index];
          return switch (slot.availableCount > 0) {
            true => SizedBox(),
            false => SizedBox(),
          };
        },
      ),
    );
  }
}

class _EnableWidget extends StatelessWidget {
  const _EnableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _DisableWidget extends StatelessWidget {
  const _DisableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _SelectedWidget extends StatelessWidget {
  const _SelectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
