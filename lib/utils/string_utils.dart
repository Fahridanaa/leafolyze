String slugify(String text) {
  return text.toLowerCase().replaceAll(' ', '-');
}

String deslugify(String slug) {
  return slug
      .split('-')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');
}
