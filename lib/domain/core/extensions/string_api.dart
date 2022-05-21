extension StringCase on String {
  // returns capitalized string, i.e. 'a String' -> 'A string'
  String capitalize() {
    return isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
  }

  // returns string in title case, i.e. 'a string' -> 'A String'
  String toTitleCase() {
    if (length <= 1) {
      return toUpperCase();
    }

    // Split string into multiple words
    final words = split(' ');

    // Capitalize first letter of each words
    final capitalizedWords = words.map((word) {
      if (word.trim().isNotEmpty) {
        return word.toLowerCase().capitalize();
      }

      return '';
    });

    // Join/Merge all words back to one String
    return capitalizedWords.join(' ');
  }
}
