enum PriceSort { lowToHigh, highToLow }

extension PriceSortExtension on PriceSort {
  String get name {
    switch (this) {
      case PriceSort.lowToHigh:
        return 'Lowest price first';
      case PriceSort.highToLow:
        return 'Highest price first';
    }
  }
}