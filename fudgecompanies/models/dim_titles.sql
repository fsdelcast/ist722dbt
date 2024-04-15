WITH dim_titles_cte AS (
    SELECT 
        -- Assuming title_id is unique, using it as the key; 
            -- replace this with your own surrogate key generation method if needed.
            {{ dbt_utils.generate_surrogate_key(['t.title_id']) }} AS title_key,
            t.title_name,
            t.title_release_year,
            t.title_rating,
            t.title_bluray_available,
            t.title_type,
            --g.genre_name AS title_genre_name
        FROM 
            -- Replace these with the actual database and table names.
            --fudgeflix_v3.dbo.ff_titles t
            {{ source('FUDGEFLIX_V3', 'titles') }} t
            --JOIN
            --fudgeflix_v3.dbo.ff_genres g ON t.title_id = g.genre_name
            --{{ source('FUDGEFLIX_V3', 'genres') }} g
    )
SELECT *
FROM dim_titles_cte
