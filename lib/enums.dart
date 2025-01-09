enum PriceSort { lowToHigh, highToLow }

extension PriceSortExtension on PriceSort {
  String get value {
    switch (this) {
      case PriceSort.lowToHigh:
        return 'lowToHigh';
      case PriceSort.highToLow:
        return 'highToLow';
    }
  } String get name {
    switch (this) {
      case PriceSort.lowToHigh:
        return 'Lowest price first';
      case PriceSort.highToLow:
        return 'Highest price first';
    }
  }
}