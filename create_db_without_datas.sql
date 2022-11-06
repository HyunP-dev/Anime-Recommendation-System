create table anime
(
    MAL_ID          INTEGER,
    Name            TEXT,
    Score           REAL,
    Genres          TEXT,
    "English name"  TEXT,
    "Japanese name" TEXT,
    Type            TEXT,
    Episodes        TEXT,
    Aired           TEXT,
    Premiered       TEXT,
    Producers       TEXT,
    Licensors       TEXT,
    Studios         TEXT,
    Source          TEXT,
    Duration        TEXT,
    Rating          TEXT,
    Ranked          REAL,
    Popularity      INTEGER,
    Members         INTEGER,
    Favorites       INTEGER,
    Watching        INTEGER,
    Completed       INTEGER,
    "On-Hold"       INTEGER,
    Dropped         INTEGER,
    "Plan to Watch" INTEGER,
    "Score-10"      REAL,
    "Score-9"       REAL,
    "Score-8"       REAL,
    "Score-7"       REAL,
    "Score-6"       REAL,
    "Score-5"       REAL,
    "Score-4"       REAL,
    "Score-3"       REAL,
    "Score-2"       REAL,
    "Score-1"       REAL
);

create table anime_with_synopsis
(
    MAL_ID    INTEGER,
    Name      TEXT,
    Score     REAL,
    Genres    TEXT,
    sypnopsis TEXT
);

create table animelist
(
    user_id          INTEGER,
    anime_id         INTEGER,
    rating           INTEGER,
    watching_status  INTEGER,
    watched_episodes INTEGER
);

create index animelist_all_index
    on animelist (user_id, anime_id, rating, watching_status, watched_episodes);

create table rating_complete
(
    user_id  INTEGER,
    anime_id INTEGER,
    rating   INTEGER
);

create unique index rating_complete_user_id_anime_id_uindex
    on rating_complete (user_id, anime_id);

create table sqlite_master
(
    type     TEXT,
    name     TEXT,
    tbl_name TEXT,
    rootpage INT,
    sql      TEXT
);

create table watching_status
(
    status      INTEGER,
    description TEXT
);


