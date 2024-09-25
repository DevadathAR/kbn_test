class PaginationController {
  int currentPage = 1;
  int totalPages = 1;
  final Function(int) onPageChanged;

  PaginationController({required this.onPageChanged});

  // Navigate to the next page
  void nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
      onPageChanged(currentPage);
    }
  }

  // Navigate to the previous page
  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      onPageChanged(currentPage);
    }
  }

  // Set total number of pages
  void setTotalPages(int pages) {
    totalPages = pages;
  }

  // Reset pagination
  void reset() {
    currentPage = 1;
  }
}
