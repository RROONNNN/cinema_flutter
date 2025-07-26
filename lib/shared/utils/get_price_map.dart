import 'package:cinema_flutter/model/data_models/room.dart';
import 'package:cinema_flutter/shared/enums/seat_type.dart';

class GetPriceMap {
  static Map<String, double> getPriceMap(Room room) {
    final priceMap = <String, double>{};
    for (var seat in room.seats) {
      if (seat.seatType == SeatType.VIP && !priceMap.containsKey('vipPrice')) {
        priceMap['vipPrice'] = seat.extraPrice;
      } else if (seat.seatType == SeatType.COUPLE &&
          !priceMap.containsKey('couplePrice')) {
        priceMap['couplePrice'] = seat.extraPrice;
      }
    }
    return priceMap;
  }
}
