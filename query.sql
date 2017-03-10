\set movie_id 1

SELECT
  b.movie_id,
  madlib.cosine_similarity(a.vec::float8[], b.vec::float8[])
FROM
  movie_metadata_vec a,
  movie_metadata_vec b
WHERE
  a.movie_id = :movie_id
AND
  a.movie_id <> b.movie_id
ORDER BY
  cosine_similarity desc
LIMIT 10;

\x

WITH temp AS (
SELECT
  b.movie_id,
  madlib.cosine_similarity(a.vec::float8[], b.vec::float8[])
FROM
  movie_metadata_vec a,
  movie_metadata_vec b
WHERE
  a.movie_id = :movie_id
AND
  a.movie_id <> b.movie_id
)
SELECT
  *
FROM
  movie_metadata m,
  temp t
WHERE
  m.movie_id = t.movie_id
ORDER BY
  t.cosine_similarity DESC
LIMIT 10;
