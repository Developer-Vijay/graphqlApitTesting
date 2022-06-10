class QueryClass {
  String readQuery = """
 query getNews {
  News {
    title
    url
    publishedAt
    author
    content
    description
    h_id
    source
    urlToImage
  }
}
""";
}
