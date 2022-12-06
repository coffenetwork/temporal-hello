CREATE TABLE ContentType(
	ContentTypeID SERIAL NOT NULL,
	ContentTypeName VARCHAR(255),
	PRIMARY KEY (ContentTypeID)
);
CREATE TABLE Schedule(
    ScheduleID SERIAL NOT NULL,
    ContentID int,
    StartTime timestamp,
    EndTime timestamp,
    PRIMARY KEY (ScheduleID),
    FOREIGN KEY (ContentID) REFERENCES ContentType(ContentTypeID) ON UPDATE CASCADE
);


SELECT * FROM Schedule AS S
INNER JOIN ContentType
ON S.ContentID = ContentType.ContentTypeId;

CREATE PROCEDURE AddSchedule(s_ID INOUT INT, c_ID INT ,  s_StartTime TimeStamp,  s_EndTime TimeStamp)
LANGUAGE plpgsql AS

$$ BEGIN
INSERT INTO Schedule(ContentID, StartTime, EndTime)
VALUES(c_ID, s_StartTime, s_EndTime) RETURNING ScheduleID INTO s_ID;
END $$;

CALL AddSchedule(NULL, 1, '2001-01-10 08:00:00', '2002-10-10 09:00:00');


CREATE PROCEDURE UpdateSchedule(s_ID INT, c_ID int, s_StartTime timestamp, s_EndTime timestamp)
LANGUAGE plpgsql AS

$$ BEGIN

UPDATE Schedule SET
ContentID = c_ID,
StartTime = s_StartTime,
EndTime = s_EndTime
WHERE ScheduleID = s_ID;

END $$


CALL UpdateSchedule(1, 1, '2022-10-11 10:00:00', '2022-10-23 10:00:00');

CREATE PROCEDURE DeleteSchedule(s_ID int)

LANGUAGE plpgsql AS $$ 
BEGIN

DELETE FROM Schedule WHERE ScheduleID = s_ID;

END $$


CREATE OR REPLACE FUNCTION GetAllSchedulesFunc() RETURNS TABLE(ScheduleID int, ContentID int, StartTime timestamp,
														 EndTime timestamp)
language plpgsql
as $$
begin
RETURN QUERY SELECT * FROM Schedule;

end;$$




