import 'package:cinema_flutter/model/data_models/room.dart';
import 'package:cinema_flutter/shared/utils/get_price_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinema_flutter/shared/enums/seat_type.dart';
import 'package:cinema_flutter/view_model/admin/cinemas/bloc/admin_room_bloc.dart';
import 'package:cinema_flutter/view_model/admin/cinemas/seat_layout_item.dart';

class AdminRoomsForm extends StatefulWidget {
  final String? cinemaId;
  final String? roomName;
  final Room? room;

  const AdminRoomsForm({super.key, this.cinemaId, this.roomName, this.room})
    : assert(
        room != null || (cinemaId != null && roomName != null),
        'If room is null, cinemaId and roomName must not be null',
      );

  @override
  State<AdminRoomsForm> createState() => _AdminRoomsFormState();
}

class _AdminRoomsFormState extends State<AdminRoomsForm> {
  late AdminRoomBloc _adminRoomBloc;
  final TextEditingController _roomNameController = TextEditingController();
  final TextEditingController _totalSeatsController = TextEditingController();
  final TextEditingController _vipPriceController = TextEditingController();
  final TextEditingController _couplePriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _adminRoomBloc = context.read<AdminRoomBloc>();
    _roomNameController.text = widget.roomName ?? widget.room?.name ?? '';
    if (widget.room != null) {
      final priceMap = GetPriceMap.getPriceMap(widget.room!);
      _vipPriceController.text = priceMap['vipPrice']?.toString() ?? '';
      _couplePriceController.text = priceMap['couplePrice']?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _roomNameController.dispose();
    _totalSeatsController.dispose();
    _vipPriceController.dispose();
    _couplePriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Room'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: BlocProvider.value(
        value: _adminRoomBloc,
        child: BlocConsumer<AdminRoomBloc, AdminRoomState>(
          listener: (context, state) {
            if (state.successMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.successMessage!),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context, state.roomSaved);
            }
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRoomInfoSection(state),
                  const SizedBox(height: 24),
                  _buildGridConfigurationSection(state),
                  const SizedBox(height: 24),
                  _buildSeatTypeSelectionSection(state),
                  const SizedBox(height: 24),
                  _buildSeatGridSection(state),
                  const SizedBox(height: 24),
                  _buildSaveButton(state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRoomInfoSection(AdminRoomState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Room Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _roomNameController,
              decoration: const InputDecoration(
                labelText: 'Room Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _totalSeatsController,
              decoration: const InputDecoration(
                labelText: 'Total Seats',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _vipPriceController,
                    decoration: const InputDecoration(
                      labelText: 'VIP Price',
                      border: OutlineInputBorder(),
                      prefixText: '\$',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _couplePriceController,
                    decoration: const InputDecoration(
                      labelText: 'Couple Price',
                      border: OutlineInputBorder(),
                      prefixText: '\$',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridConfigurationSection(AdminRoomState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Grid Configuration',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: state.highestRow,
                    decoration: const InputDecoration(
                      labelText: 'Highest Row',
                      border: OutlineInputBorder(),
                    ),
                    items: _generateRowOptions(),
                    onChanged: (value) {
                      if (value != null) {
                        _adminRoomBloc.add(
                          AdminRoomSelectHighestRow(row: value),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    initialValue: state.highestColumn,
                    decoration: const InputDecoration(
                      labelText: 'Highest Column',
                      border: OutlineInputBorder(),
                    ),
                    items: _generateColumnOptions(),
                    onChanged: (value) {
                      if (value != null) {
                        _adminRoomBloc.add(
                          AdminRoomSelectHighestColumn(column: value),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Grid Size: ${state.highestRow} × ${state.highestColumn}',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeatTypeSelectionSection(AdminRoomState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Seat Type',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: SeatType.values.map((seatType) {
                final isSelected = state.selectedSeatType == seatType;
                return ChoiceChip(
                  label: Text(seatType.name),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      _adminRoomBloc.add(
                        AdminRoomSelectSeatType(seatType: seatType),
                      );
                    }
                  },
                  backgroundColor: _getSeatTypeColor(seatType).withOpacity(0.2),
                  selectedColor: _getSeatTypeColor(seatType),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeatGridSection(AdminRoomState state) {
    final rows = _generateRows(state.highestRow);
    final columns = state.highestColumn;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Seat Layout', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // Screen indicator
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      'SCREEN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                  // Seat grid
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: rows.map((row) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(columns, (colIndex) {
                            final col = colIndex + 1;
                            final seat = _findSeat(state.seatLayout, row, col);
                            final seatType = seat?.type ?? SeatType.EMPTY;

                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: GestureDetector(
                                onTap: () => _onSeatTap(
                                  row,
                                  col,
                                  state.selectedSeatType,
                                ),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: _getSeatTypeColor(seatType),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.grey[400]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$row$col',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                        color: seatType == SeatType.EMPTY
                                            ? Colors.grey[600]
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildSeatTypeLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildSeatTypeLegend() {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: SeatType.values.map((seatType) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: _getSeatTypeColor(seatType),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 4),
            Text(seatType.name, style: Theme.of(context).textTheme.bodySmall),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildSaveButton(AdminRoomState state) {
    final totalSeats = int.tryParse(_totalSeatsController.text) ?? 0;
    final configuredSeats = state.seatLayout.length;
    final isValid = _roomNameController.text.isNotEmpty && totalSeats > 0;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: state.isSaving || !isValid ? null : _onSaveRoom,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: state.isSaving
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                'Save Room ($configuredSeats/$totalSeats seats configured)',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _generateRowOptions() {
    return List.generate(26, (index) {
      final row = String.fromCharCode(65 + index); // A, B, C, ...
      return DropdownMenuItem(value: row, child: Text('Row $row'));
    });
  }

  List<DropdownMenuItem<int>> _generateColumnOptions() {
    return List.generate(20, (index) {
      final column = index + 1;
      return DropdownMenuItem(value: column, child: Text('Column $column'));
    });
  }

  List<String> _generateRows(String highestRow) {
    final highestRowIndex = highestRow.codeUnitAt(0) - 65; // A = 0, B = 1, ...
    return List.generate(highestRowIndex + 1, (index) {
      return String.fromCharCode(65 + index);
    });
  }

  SeatLayoutItem? _findSeat(
    List<SeatLayoutItem> seatLayout,
    String row,
    int col,
  ) {
    try {
      return seatLayout.firstWhere(
        (seat) => seat.row == row && seat.col == col,
      );
    } catch (e) {
      return null;
    }
  }

  void _onSeatTap(String row, int col, SeatType selectedType) {
    final existingSeat = _findSeat(_adminRoomBloc.state.seatLayout, row, col);

    if (existingSeat != null) {
      // Remove existing seat
      _adminRoomBloc.add(AdminRoomRemoveSeat(seat: existingSeat));
    }

    if (selectedType != SeatType.EMPTY) {
      // Add new seat
      final newSeat = SeatLayoutItem(row: row, col: col, type: selectedType);
      _adminRoomBloc.add(AdminRoomAddSeat(seat: newSeat));
    }
  }

  void _onSaveRoom() {
    final roomData = {
      'name': _roomNameController.text,
      'cinemaId': widget.cinemaId,
      // 'totalSeats': int.tryParse(_totalSeatsController.text) ?? 0,
      'vipPrice': double.tryParse(_vipPriceController.text) ?? 75000,
      'couplePrice': double.tryParse(_couplePriceController.text) ?? 80000,
      'seatLayout': _adminRoomBloc.state.seatLayout
          .map((seat) => seat.toJson())
          .toList(),
    };

    _adminRoomBloc.add(AdminRoomCreateRoom(roomData: roomData));
  }

  Color _getSeatTypeColor(SeatType seatType) {
    switch (seatType) {
      case SeatType.NORMAL:
        return Colors.blue;
      case SeatType.VIP:
        return Colors.amber;
      case SeatType.COUPLE:
        return Colors.pink;
      case SeatType.EMPTY:
        return Colors.grey[300]!;
    }
  }
}
