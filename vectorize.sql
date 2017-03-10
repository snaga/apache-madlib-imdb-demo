drop table "movie_metadata_unnest";

create table movie_metadata_unnest as
select
  movie_id,
  movie_title,
  director_name,
  unnest(actors) actor,
  unnest(genres) genre,
  unnest(plot_keywords) plot_keyword,
  country,
  language,
  movie_imdb_link
from
  movie_metadata
--where
--  movie_id <= 100
;

drop table movie_metadata_enc;
drop table movie_metadata_enc_dictionary;

select madlib.encode_categorical_variables (
        'movie_metadata_unnest', -- source_table,
        'movie_metadata_enc', -- output_table,
        'director_name,actor,genre,plot_keyword,country,language', -- categorical_cols
        null, -- categorical_cols_to_exclude,    -- Optional
        'movie_id', -- row_id,                         -- Optional
        null, -- top,                            -- Optional
        null, -- value_to_drop,                  -- Optional
        null, -- encode_null,                    -- Optional
        'svec'-- output_type,                   -- Optional
);

drop table movie_metadata_vec;

create table movie_metadata_vec as
select
  movie_id,
  max(__encoded_variables__::float8[])::madlib.svec vec
from
  movie_metadata_enc
group by
  movie_id;
