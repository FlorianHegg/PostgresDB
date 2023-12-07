-- Create the database if not exists
CREATE DATABASE IF NOT EXISTS vereinuser;
-- Switch to the 'vereinuser' database
\c vereinuser;

--
-- --------------
-- table FUNKTION
-- --------------
--
CREATE TABLE IF NOT EXISTS Funktion (
    FunkID SERIAL PRIMARY KEY,
    Bezeichner VARCHAR(255) NOT NULL
);

INSERT INTO Funktion (Bezeichner) VALUES 
    ('Praesidium'),
    ('Vizepraesidium'),
    ('Kasse'),
    ('Beisitz'),
    ('PR');

--
-- -------------
-- table SPONSOR
-- -------------
--
CREATE TABLE IF NOT EXISTS Sponsor (
    SponID SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Strasse_Nr VARCHAR(255),
    PLZ VARCHAR(10),
    Ort VARCHAR(255),
    Spendentotal INT
);

INSERT INTO Sponsor (Name, Strasse_Nr, PLZ, Ort, Spendentotal) VALUES
    ('Hasler AG', 'Zelgweg 9', '2540', 'Grenchen', 1270),
    ('Pauker Druck', 'Solothurnstr. 19', '2544', 'Bettlach', 2750),
    ('Meyer Toni', 'Rothstr. 22', '4500', 'Solothurn', 750);

--
-- ------------
-- table STATUS
-- ------------
--
CREATE TABLE IF NOT EXISTS Status (
    StatID SERIAL PRIMARY KEY,
    Bezeichner VARCHAR(255) NOT NULL,
    Beitrag INT
);

INSERT INTO Status (Bezeichner, Beitrag) VALUES
    ('Junior', 0),
    ('Aktiv', 50),
    ('Ehemalig', null),
    ('Passiv', 30),
    ('Helfer', null),
    ('Extern', null);

--
-- ------------
-- table PERSON
-- ------------
--
CREATE TABLE IF NOT EXISTS Person (
    PersID SERIAL PRIMARY KEY,
    StatID INT REFERENCES Status(StatID),
    Name VARCHAR(255) NOT NULL,
    Vorname VARCHAR(255) NOT NULL,
    Strasse_Nr VARCHAR(255),
    PLZ VARCHAR(10),
    Ort VARCHAR(255),
    Bezahlt BOOLEAN,
    Bemerkungen TEXT,
    Eintritt DATE,
    Austritt DATE,
    MentorID INT REFERENCES Person(PersID)
);

INSERT INTO Person (StatID, Name, Vorname, Strasse_Nr, PLZ, Ort, Bezahlt, Bemerkungen, Eintritt, Austritt, MentorID) VALUES
    (3, 'Niiranen', 'Ulla', 'Nordstr. 113', '2500', 'Biel', '1', NULL, '2007-11-11', '2011-03-31', null),
    (3, 'Wendel', 'Otto', 'Sigriststr. 9', '4500', 'Solothurn', '1', NULL, '2011-01-01', '2014-11-30', null),
    (2, 'Meyer', 'Dominik', 'Rainstr. 13', '4528', 'Zuchwil', '1', NULL, '2011-01-01', null, null),
    (2, 'Meyer', 'Petra', 'Rainstr. 13', '4528', 'Zuchwil', '1', NULL, '2009-02-15', null, null),
    (2, 'Tamburino', 'Mario', 'Solothurnstr. 96', '2540', 'Grenchen', '0', NULL, '2014-09-30', null, 4),
    (2, 'Bregger', 'Beni', 'Sportstr. 2', '2540', 'Grenchen', '1', NULL, '2012-05-21', null, 4),
    (5, 'Luder', 'Kevin', 'Forstweg 14', '2545', 'Zuchwil', '1', 'Klaushock', NULL, null, null),
    (6, 'Frei', 'Barbara', 'Gartenstr.1', '2540', 'Grenchen', '1', NULL, NULL, null, null),
    (6, 'Huber', 'Felix', 'Eichmatt 7', '2545', 'Selzach', '1', NULL, NULL, null, null),
    (1, 'Cadola', 'Leo', 'Sportstr. 2', '4500', 'Solothurn', '1', NULL, '2013-10-01', null, null),
    (1, 'Bart', 'Sabine', 'Bernstr. 15', '2540', 'Grenchen', '1', NULL, '2014-07-12', null, 10),
    (2, 'Gruber', 'Romy', 'Gladbaechli 3', '2545', 'Selzach', '0', NULL, '2009-11-29', null, null);

--
-- ------------
-- table Anlass
-- ------------
--
CREATE TABLE IF NOT EXISTS Anlass (
    AnlaID SERIAL PRIMARY KEY,
    Bezeichner VARCHAR(255) NOT NULL,
    Ort VARCHAR(255),
    Datum DATE,
    Kosten INT,
    OrgID INT REFERENCES Funktion(FunkID)
);

INSERT INTO Anlass (Bezeichner, Ort, Datum, Kosten, OrgID) VALUES
    (1, 'GV', 'Solothurn', '2013-03-31', 200, 2),
    (2, 'Vorstandssitzung', 'Grenchen', '2014-01-17', null, 12),
    (3, 'GV', 'Bettlach', '2013-03-30', 200, 6),
    (4, 'Klaushock', 'Bettlach', '2014-12-06', 150, 7),
    (5, 'Vorstandssitzung', 'Grenchen', '2015-01-21', null, 12),
    (6, 'Turnier', 'Biel', '2014-02-28', 1020, 10),
    (7, 'GV', 'Grenchenberg', '2015-03-29', 250, 4),
    (8, 'Vorstandssitzung', 'Grenchen', '2015-01-19', null, 6);

--
-- ------------
-- table SPENDE
-- ------------
--
CREATE TABLE IF NOT EXISTS Spende (
    SponID INT REFERENCES Sponsor(SponID),
    SpenID SERIAL PRIMARY KEY,
    AnlaID INT REFERENCES Anlass(AnlaID),
    Bezeichner VARCHAR(255) NOT NULL,
    Datum DATE,
    Betrag INT
);

INSERT INTO Spende (SponID, AnlaID, Bezeichner, Datum, Betrag) VALUES
    (1, 5, 6, 'Apéro', '2015-02-02', 720),
    (1, 6, null, 'Defizittilgung', '2015-04-13', 550),
    (2, 3, 7, 'Getränke', '2015-03-05', 600),
    (2, 4, 6, 'Plakate', '2015-03-11', 300),
    (2, 5, null, 'Defizittilgung', '2015-04-13', 750),
    (3, 1, 4, 'Glühwein', '2014-11-29', 200),
    (3, 2, 7, 'Unterhaltungsmusik', '2015-02-23', 550);

--
-- ----------------
-- table TEILNEHMER
-- ----------------
--
CREATE TABLE IF NOT EXISTS Teilnehmer (
    PersID INT REFERENCES Person(PersID),
    AnlaID INT REFERENCES Anlass(AnlaID)
);

INSERT INTO Teilnehmer (PersID, AnlaID) VALUES
    (3, 1),
    (4, 1),
    (6, 1),
    (12, 1),
    (2, 2),
    (3, 2),
    (4, 2),
    (2, 3),
    (4, 3),
    (6, 3),
    (12, 3),
    (3, 5),
    (12, 5),
    (2, 7),
    (3, 7),
    (6, 7),
    (4, 8),
    (12, 8);

--
-- --------------------
-- table SPONSORENKONTAKT
-- --------------------
--
CREATE TABLE IF NOT EXISTS Sponsorenkontakt (
    PersID INT REFERENCES Person(PersID),
    SponID INT REFERENCES Sponsor(SponID)
);

INSERT INTO Sponsorenkontakt (PersID, SponID) VALUES
    (8, 1),
    (4, 2),
    (9, 2),
    (3, 3),
    (4, 3);

--
-- ------------------------
-- table FUNKTIONSBESETZUNG
-- ------------------------
--
CREATE TABLE IF NOT EXISTS Funktionsbesetzung (
    PersID INT REFERENCES Person(PersID),
    FunkID INT REFERENCES Funktion(FunkID),
    Antritt DATE,
    Ruecktritt DATE
);

INSERT INTO Funktionsbesetzung (PersID, FunkID, Antritt, Ruecktritt) VALUES
    (1, 1, '2007-11-11', '2010-03-31'),
    (4, 2, '2009-04-01', '2011-03-31'),
    (12, 1, '2010-04-01', '2011-03-31'),
    (4, 1, '2011-04-01', '2013-03-31'),
    (12, 2, '2011-04-01', '2012-03-31'),
    (2, 3, '2011-04-01', '2013-03-31'),
    (3, 2, '2012-04-01', '2013-03-31'),
    (12, 1, '2012-04-01', null),
    (6, 3, '2013-04-01', '2014-03-31'),
    (3, 4, '2013-04-01', '2015-03-31'),
    (4, 5, '2013-04-01', '2014-03-31'),
    (6, 2, '2014-04-01', '2029-04-30'),
    (4, 4, '2014-04-01', null),
    (2, 5, '2014-04-01', '2028-11-30'),
    (3, 3, '2014-08-01', null);

-- Commit the changes
COMMIT;
