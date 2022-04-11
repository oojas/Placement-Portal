import 'package:flutter/material.dart';
import 'package:placementcracker/modals/articles.dart';

class ArticleProvider extends ChangeNotifier {
  bool _isArticlePageProcessing = true;
  int _currentPage = 1;
  List<Articles> _articlesList = [];
  bool _shouldRefresh = true;

  bool get shouldRefresh => _shouldRefresh;

  setShouldRefresh(bool value) => _shouldRefresh = value;



  bool get isArticlePageProcessing => _isArticlePageProcessing;

  setIsArticlePageProcessing(bool value) {
    _isArticlePageProcessing = value;
    notifyListeners();
  }

  List<Articles> get articlesList => _articlesList;

  setArticlesList(List<Articles> list, {bool notify = true}) {
    _articlesList = list;
    if (notify) notifyListeners();
  }

  mergeArticlesList(List<Articles> list, {bool notify = true}) {
    _articlesList.addAll(list);
    if (notify) notifyListeners();
  }

  addArticle(Articles articles, {bool notify = true}) {
    _articlesList.add(articles);
    if (notify) notifyListeners();
  }

  Articles getArticleByIndex(int index) => _articlesList[index];

  int get articlesListLength => _articlesList.length;
}