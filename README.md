前提条件
--------

* Apache MADlib 1.10.0以降がインストールされていること

データセット
------------

* IMDB 5000 Movie Dataset | Kaggle https://www.kaggle.com/deepmatrix/imdb-5000-movie-dataset

データ準備手順
--------------

* データセットをダウンロード
* zip `imdb-5000-movie-dataset.zip` を展開、csvファイル `movie_metadata.csv` を取得
* `movie_metadata.py` を実行してSQLファイルを生成
* SQLファイルを実行してテーブル `movie_metadata` を作成
* `vectorize.sql` を実行してテーブル `movie_metadata_vec` を作成

検索
----

* `query.sql` を実行

以上。
