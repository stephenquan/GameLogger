import QtQuick 2.7
import ArcGIS.AppFramework 1.0
import ArcGIS.AppFramework.Sql 1.0

Item {
    property alias db: db
    property alias gamesModel: gamesModel
    property alias eventsModel: eventsModel

    FileFolder {
        id: dataFolder

        path: "~/ArcGIS/Data/sql"
    }

    FileFolder {
        id: sqlFolder

        url: "sql"
    }

    SqlDatabase {
        id: db

        databaseName: dataFolder.filePath("gamelogger.sqlite");
    }

    ListModel {
        id: gamesModel

        ListElement {
            gameId: 1
            gameName: "Sample Game"
            gameDate: 14141414
        }

        function refresh() {
            var query = db.query("SELECT * FROM Games");

            if (query.error) {
                throwQueryError(query);
                return;
            }

            clear();

            var ok = query.first();
            while (ok) {
                append(query.values);
                ok = query.next();
            }
        }
    }

    ListModel {
        id: eventsModel

        ListElement {
            eventId: 1
            gameId: 1
            eventText: "Sample Text"
            eventDate: 14141414
            eventTime: 2
        }

        function refresh() {
            var sql = "SELECT * FROM Events WHERE gameId = :gameId";

            var query = db.query(
                sql,
                { gameId: currentGameId } );

            if (query.error) {
                console.log("Query Sql: ", sql, currentGameId);
                throwQueryError(query);
                return;
            }

            clear();

            var ok = query.first();
            while (ok) {
                append(query.values);
                ok = query.next();
            }

            append( {
                       eventId: -1,
                       gameId: currentGameId,
                       eventText: "",
                       eventDate: -1,
                       eventTime: -1
                   } );
        }
    }

    Component.onCompleted: {
        openDatabase();

        gamesModel.refresh();
    }

    function openDatabase() {
        dataFolder.makeFolder();
        db.open();
        //execSQLFile("droptables.sql");
        execSQLFile("createtables.sql");
        //execSQLFile("insertdemodata.sql");
    }

    function resetDatabase() {
        execSQL("DELETE FROM Events");
        execSQL("DELETE FROM Games");

        //db.close();
        //db.open();

        execSQLFile("droptables.sql");
        execSQLFile("createtables.sql");
        //execSQLFile("insertdemodata.sql");

        gamesModel.refresh();
    }

    function sampleDatabase() {
        execSQL("DELETE FROM Events");
        execSQL("DELETE FROM Games");

        //db.close();
        //db.open();

        execSQLFile("droptables.sql");
        execSQLFile("createtables.sql");
        execSQLFile("insertdemodata.sql");

        gamesModel.refresh();
    }

    function throwQueryError(query) {
        console.log("Query Error: ", query.error.toString());
        throw new Error(query.error.toString());
    }

    function execSQLFile(sqlfile) {
        var text = sqlFolder.readTextFile(sqlfile);
        execSQL(text);
    }

    function execSQL(text) {
        var sqlCommands = text.split(";").reduce( function(p, c) {
            c = c.replace(/(^\s+|\s+$)/g, "");
            c = c.replace(/^--.*/, "");
            p.push(c);
            return p;
        }, [ ] );

        sqlCommands.forEach(function (sql) {
            if (!sql.length) {
                return;
            }

            var query = db.query(sql);

            if (query.error) {
                console.log("Command sql: ", sql);
                throwQueryError(query);
            }

        } );
    }

    function countAllGames() {
        var query = db.query("SELECT COUNT(*) as count FROM Games");

        if (query.error) {
            console.log("Query error: ", query.error.toString());
            return 0;
        }

        var ok = query.first();
        var result = ok ? query.values.count : 0;
        query.next();
        query.finish();

        return result;
    }

    function insertGame(gameRecord) {
        var query = db.query(
            "INSERT INTO Games (gameName, gameDate) VALUES (:gameName, :gameDate)",
            { gameName: gameRecord.gameName, gameDate: gameRecord.gameDate } );

        if (query.error) {
            console.log("Query error: ", query.error.toString());
            return -1;
        }

        gameRecord.gameId = query.insertId;
        query.finish();

        currentGameId = gameRecord.gameId;
        currentGameName = gameRecord.gameName;

        gamesModel.append(gameRecord);

        currentGameIndex = gamesModel.count - 1;

        return gameRecord.gameId;
    }

    function updateGameName(gameId, gameName) {
        var query = db.query(
            "UPDATE Games SET gameName = :gameName WHERE gameId = :gameId",
            {
                gameId: gameId,
                gameName: gameName
            } );

        if (query.error) {
            console.log("Query error: ", query.error.toString());
            return -1;
        }

        query.finish();

        gamesModel.get(currentGameIndex).gameName = gameName;
    }

    function deleteGame(gameId) {
        var query = db.query(
            "DELETE FROM Events WHERE gameId = :gameId",
            { gameId: gameId } );

        if (query.error) {
            console.log("Query error: ", query.error.toString());
            return -1;
        }

        query = db.query(
            "DELETE FROM Games WHERE gameId = :gameId",
            { gameId: gameId } );

        if (query.error) {
            console.log("Query error: ", query.error.toString());
            return -1;
        }

        query.finish();

        var index = 0;
        while (index < gamesModel.count) {
            if (gamesModel.get(index).gameId === gameId) {
                gamesModel.remove(index);
            } else {
                index++;
            }
        }
    }

    function countAllEvents() {
        var query = db.query("SELECT COUNT(*) as count FROM Events");

        if (query.error) {
            console.log("Query error: ", query.error.toString());
            return 0;
        }

        var ok = query.first();
        var result = ok ? query.values.count : 0;
        query.next();
        query.finish();

        return result;
    }

    function countGameEvents(gameId) {
        var query = db.query(
            "SELECT COUNT(*) as count FROM Events WHERE gameId = :gameId",
            { gameId: gameId } );

        if (query.error) {
            console.log("Query error: ", query.error.toString());
            return 0;
        }

        var ok = query.first();
        var result = ok ? query.values.count : 0;
        query.next();
        query.finish();

        return result;
    }

    function insertEvent(eventRecord, eventIndex) {
        var query = db.query(
            "INSERT INTO Events (gameId, eventText, eventDate, eventTime) VALUES (:gameId, :eventText, :eventDate, :eventTime)",
            {
                gameId: eventRecord.gameId,
                eventText: eventRecord.eventText,
                eventDate: eventRecord.eventDate,
                eventTime: eventRecord.eventTime
            } );

        if (query.error) {
            console.log("Query error: ", query.error.toString());
            return -1;
        }

        eventRecord.eventId = query.insertId;

        query.finish();

        eventsModel.set(eventIndex, eventRecord);

        eventsModel.append( {
            eventId: -1,
            gameId: currentGameId,
            eventText: "",
            eventDate: -1,
            eventTime: -1
        } );

        return eventRecord.eventId;
    }

    function updateEventText(eventId, eventText, eventIndex) {
        var query = db.query(
            "UPDATE Events SET eventText = :eventText WHERE eventId = :eventId",
            {
                eventId: eventId,
                eventText: eventText
            } );

        if (query.error) {
            console.log("Query error: ", query.error.toString());
            return -1;
        }

        query.finish();

        eventsModel.get(eventIndex).eventText = eventText;
    }

    function deleteLastEvent(eventId, eventIndex) {
        var query = db.query(
            "DELETE FROM Events WHERE eventId = :eventId",
            {
                eventId: eventId,
            } );

        if (query.error) {
            console.log("Query error: ", query.error.toString());
            return -1;
        }

        query.finish();

        eventsModel.remove(eventIndex + 1);

        eventsModel.set(eventIndex, {
            eventId: -1,
            gameId: currentGameId,
            eventText: "",
            eventDate: -1,
            eventTime: -1
        } );

    }

}
