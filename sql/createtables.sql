CREATE TABLE IF NOT EXISTS Games (
    gameId INTEGER primary key autoincrement not null,
    gameName TEXT,
    gameDate INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS Events (
    eventId INTEGER primary key autoincrement not null,
    gameId INTEGER NOT NULL,
    eventText TEXT,
    eventDate INTEGER NOT NULL,
    eventTime INTEGER NOT NULL,
    CONSTRAINT FK_Events_GameId FOREIGN KEY (gameId) REFERENCES Games (gameId)
);
