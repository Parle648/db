# db

```mermaid
erDiagram
    USERS ||--o{ FILES : "has avatar"
    USERS ||--o{ FAVORITES : "has favorite"

    FAVORITES ||--|{ MOVIES : "references"

    FILES ||--o{ DIRECTORS : "profile picture"
    FILES ||--o{ PERSONS : "profile picture"
    FILES ||--o{ CHARACTERS : "image"
    FILES ||--o{ MOVIES : "poster"

    DIRECTORS ||--|{ MOVIES : "directs"

    MOVIES ||--o{ MOVIE_GENRES : "categorized by"
    MOVIES ||--o{ MOVIE_ACTORS : "includes"

    GENRES ||--o{ MOVIE_GENRES : "includes"

    PERSONS ||--o{ CHARACTERS : "portrayed by"
    PERSONS ||--o{ MOVIE_ACTORS : "appears in"

    CHARACTERS ||--|{ MOVIES : "appears in"
    CHARACTERS ||--o{ FILES : "has image"

    MOVIE_ACTORS ||--|{ MOVIES : "appears in"
    MOVIE_ACTORS ||--o{ PERSONS : "acts"

```
