# db

```mermaid
  erDiagram
    USERS }|..|{ FILES : has
    USERS ||--o{ FAVORITES : has
    USERS ||--o{ MOVIES : "watches"
    USERS ||--o{ DIRECTORS : "employs"
    FILES ||--o{ DIRECTORS : "depicts"
    FILES ||--o{ PERSONS : "depicts"
    FILES ||--o{ MOVIES : "provides poster for"
    MOVIES ||--o{ MOVIE_GENRES : "categorized by"
    GENRES ||--|{ MOVIE_GENRES : includes
    DIRECTORS ||--|{ MOVIES : directs
    PERSONS ||--o{ CHARACTERS : "portrays"
    CHARACTERS ||--|{ MOVIES : "appears in"
    MOVIES ||--o{ MOVIE_ACTORS : "features"
    PERSONS ||--o{ MOVIE_ACTORS : "acts in"
    MOVIES ||--o{ MOVIE_GENRES : "has genre"
```
