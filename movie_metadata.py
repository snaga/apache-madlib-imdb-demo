#!/usr/bni/env python2.7

import csv
import sys

reader = csv.reader(open('movie_metadata.csv', 'rb'), delimiter=',', quotechar='"')
# 'color', 'director_name', 'num_critic_for_reviews', 'duration', 'director_facebook_likes', 'actor_3_facebook_likes', 'actor_2_name', 'actor_1_facebook_likes', 'gross', 'genres', 'actor_1_name', 'movie_title', 'num_voted_users', 'cast_total_facebook_likes', 'actor_3_name', 'facenumber_in_poster', 'plot_keywords', 'movie_imdb_link', 'num_user_for_reviews', 'language', 'country', 'content_rating', 'budget', 'title_year', 'actor_2_facebook_likes', 'imdb_score', 'aspect_ratio', 'movie_facebook_likes'
header = None
print """
DROP TABLE movie_metadata;

CREATE TABLE movie_metadata (
  movie_id serial,
  movie_title text,
  director_name text,
  actors text[],
  genres text[],
  plot_keywords text[],
  country text,
  language text,
  movie_imdb_link text
);
"""

print "INSERT INTO movie_metadata (movie_title,director_name,actors,genres,plot_keywords,country,language,movie_imdb_link) VALUES "
count = 0
for l in reader:
    r = {}
    if header is None:
        header = l
        continue
    for (f,v) in zip(header,l):
        r[f] = v.replace("'", "")
#    print(r)
    print "  ",
    if count > 0:
        print ",",
    print "('%s','%s',ARRAY['%s','%s','%s'],ARRAY['%s'],ARRAY['%s'],'%s','%s','%s')" % (r['movie_title'].strip(), r['director_name'], r['actor_1_name'], r['actor_2_name'], r['actor_3_name'], "','".join(r['genres'].split('|')), "','".join(r['plot_keywords'].split('|')), r['country'], r['language'], r['movie_imdb_link'])

    count += 1
print ";",
