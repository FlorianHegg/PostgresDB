-- Create database scott
CREATE DATABASE scott;

-- Connect to the scott database
-- \c scott;

-- Create user and grant permissions
CREATE USER scott WITH PASSWORD 'tiger22$';
GRANT CONNECT ON DATABASE scott TO scott;
GRANT USAGE ON SCHEMA public TO scott;
ALTER DEFAULT PRIVILEGES FOR USER scott IN SCHEMA public GRANT ALL ON TABLES TO scott;
ALTER DEFAULT PRIVILEGES FOR USER scott IN SCHEMA public GRANT ALL ON SEQUENCES TO scott;
ALTER DEFAULT PRIVILEGES FOR USER scott IN SCHEMA public GRANT ALL ON FUNCTIONS TO scott;
ALTER DEFAULT PRIVILEGES FOR USER scott IN SCHEMA public GRANT ALL ON TYPES TO scott;

-- Grant data reader and data writer roles
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO scott;

-- Grant create view permission
GRANT CREATE ON SCHEMA public TO scott;

-- Create user and grant permissions
CREATE USER vereinuser WITH PASSWORD 'tiger22$';
GRANT CONNECT ON DATABASE vereinuser TO vereinuser;
GRANT USAGE ON SCHEMA public TO vereinuser;
ALTER DEFAULT PRIVILEGES FOR USER vereinuser IN SCHEMA public GRANT ALL ON TABLES TO vereinuser;
ALTER DEFAULT PRIVILEGES FOR USER vereinuser IN SCHEMA public GRANT ALL ON SEQUENCES TO vereinuser;
ALTER DEFAULT PRIVILEGES FOR USER vereinuser IN SCHEMA public GRANT ALL ON FUNCTIONS TO vereinuser;
ALTER DEFAULT PRIVILEGES FOR USER vereinuser IN SCHEMA public GRANT ALL ON TYPES TO vereinuser;

-- Grant data reader and data writer roles
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO vereinuser;

-- Grant create view permission
GRANT CREATE ON SCHEMA public TO vereinuser;

-- Create schema scott if not exists
CREATE SCHEMA IF NOT EXISTS scott;

-- Switch to the scott schema
SET search_path TO scott;

-- Create table DEPT
CREATE TABLE dept (
    deptno INT NOT NULL,
    dname VARCHAR(14) NOT NULL,
    loc VARCHAR(13) NOT NULL,
    CONSTRAINT pk_dept PRIMARY KEY (deptno)
);

-- Create table EMP
CREATE TABLE emp (
    empno INT NOT NULL,
    ename VARCHAR(10) NOT NULL,
    job VARCHAR(9) NOT NULL,
    mgr INT,
    hiredate DATE NOT NULL,
    sal DECIMAL(7,2) NOT NULL,
    comm DECIMAL(7,2),
    deptno INT NOT NULL,
    CONSTRAINT pk_emp PRIMARY KEY (empno),
    CONSTRAINT fk_emp_relation__dept FOREIGN KEY (deptno) REFERENCES dept (deptno),
    CONSTRAINT fk_emp_relation__emp FOREIGN KEY (mgr) REFERENCES emp (empno)
);

-- Create index RELATION_3_FK
CREATE INDEX relation_3_fk ON emp (deptno);

-- Create index RELATION_16_FK
CREATE INDEX relation_16_fk ON emp (mgr);

-- Switch to the scott schema
SET search_path TO scott;

-- Insert data into DEPT table
INSERT INTO dept (deptno, dname, loc) VALUES 
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');

-- Insert data into EMP table
INSERT INTO emp (empno, ename, job, hiredate, sal, comm, deptno) VALUES 
(7369, 'SMITH', 'CLERK', '1980-12-17', 800, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', '1981-02-20', 1600, 300, 30),
(7521, 'WARD', 'SALESMAN', '1981-02-22', 1250, 500, 30),
(7566, 'JONES', 'MANAGER', '1981-04-02', 2975, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', '1981-09-28', 1250, 1400, 30),
(7698, 'BLAKE', 'MANAGER', '1981-05-01', 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', '1981-06-09', 2450, NULL, 10),
(7788, 'SCOTT', 'ANALYST', '1982-12-09', 3000, NULL, 20),
(7839, 'KING', 'PRESIDENT', '1981-11-17', 5000, NULL, 10),
(7844, 'TURNER', 'SALESMAN', '1981-09-08', 1500, 0, 30),
(7876, 'ADAMS', 'CLERK', '1983-01-12', 1100, NULL, 20),
(7900, 'JAMES', 'CLERK', '1981-12-03', 950, NULL, 30),
(7902, 'FORD', 'ANALYST', '1981-12-03', 3000, NULL, 20),
(7934, 'MILLER', 'CLERK', '1982-01-23', 1300, NULL, 10);

-- Update statements
UPDATE emp SET mgr = 7902 WHERE empno = 7369;
UPDATE emp SET mgr = 7698 WHERE empno = 7499;
UPDATE emp SET mgr = 7698 WHERE empno = 7521;
UPDATE emp SET mgr = 7839 WHERE empno = 7566;
UPDATE emp SET mgr = 7698 WHERE empno = 7654;
UPDATE emp SET mgr = 7839 WHERE empno = 7698;
UPDATE emp SET mgr = 7839 WHERE empno = 7782;
UPDATE emp SET mgr = 7566 WHERE empno = 7788;
UPDATE emp SET mgr = 7698 WHERE empno = 7844;
UPDATE emp SET mgr = 7788 WHERE empno = 7876;
UPDATE emp SET mgr = 7698 WHERE empno = 7900;
UPDATE emp SET mgr = 7566 WHERE empno = 7902;
UPDATE emp SET mgr = 7782 WHERE empno = 7934;

-- Switch to the vereinuser schema
SET search_path TO vereinuser;

-- Create table Anlass
CREATE TABLE Anlass
(
    AnlaID     SERIAL PRIMARY KEY,
    Bezeichner VARCHAR(20) NOT NULL,
    Ort        VARCHAR(20),
    Datum      DATE NOT NULL,
    Kosten     DECIMAL(8,2),
    OrgID      INT NOT NULL,
    CONSTRAINT chk_kosten CHECK (Kosten IS NULL OR Kosten >= 0)
);

-- Create table Funktion
CREATE TABLE Funktion
(
    FunkID     SERIAL PRIMARY KEY,
    Bezeichner VARCHAR(20) NOT NULL
);

-- Create table Funktionsbesetzung
CREATE TABLE Funktionsbesetzung
(
    Antritt    DATE NOT NULL,
    Ruecktritt DATE,
    FunkID     INT NOT NULL,
    PersID     INT NOT NULL,
    CONSTRAINT chk_ruecktritt CHECK (Antritt <= Ruecktritt OR Ruecktritt IS NULL),
    CONSTRAINT Funktionsbesetzung_PK PRIMARY KEY (FunkID, PersID, Antritt)
);

-- Create table Person
CREATE TABLE Person
(
    PersID      SERIAL PRIMARY KEY,
    Name        VARCHAR(20) NOT NULL,
    Vorname     VARCHAR(15) NOT NULL,
    Strasse_Nr  VARCHAR(20) NOT NULL,
    PLZ         CHAR(4) NOT NULL,
    Ort         VARCHAR(20) NOT NULL,
    bezahlt     CHAR(1) NOT NULL,
    Bemerkungen VARCHAR(25),
    Eintritt    DATE,
    Austritt    DATE,
    StatID      INT NOT NULL,
    MentorID    INT,
    CONSTRAINT chk_austritt CHECK ((Eintritt <= Austritt OR Austritt IS NULL) OR (Eintritt IS NULL AND Austritt IS NULL)),
);

-- Create table Spende
CREATE TABLE Spende
(
    SpenID     SERIAL PRIMARY KEY,
    Bezeichner VARCHAR(20),
    Datum      DATE DEFAULT CURRENT_DATE NOT NULL,
    Betrag     DECIMAL(8,2) NOT NULL,
    SponID     INT NOT NULL,
    AnlaID     INT,
    CONSTRAINT Spende_PK PRIMARY KEY (SpenID, SponID)
);

-- Create table Sponsor
CREATE TABLE Sponsor
(
    SponID       SERIAL PRIMARY KEY,
    Name         VARCHAR(20) NOT NULL,
    Strasse_Nr   VARCHAR(20) NOT NULL,
    PLZ          CHAR(4) NOT NULL,
    Ort          VARCHAR(20) NOT NULL,
    Spendentotal DECIMAL(8,2) NOT NULL
);

-- Create table Sponsorenkontakt
CREATE TABLE Sponsorenkontakt
(
    PersID INT NOT NULL,
    SponID INT NOT NULL,
    CONSTRAINT Sponsorenkontakt_PK PRIMARY KEY (PersID, SponID)
);

-- Create table Status
CREATE TABLE Status
(
    StatID     SERIAL PRIMARY KEY,
    Bezeichner VARCHAR(20) NOT NULL,
    Beitrag    DECIMAL(5,2),
    CONSTRAINT chk_beitrag_status CHECK (Beitrag IS NULL OR Beitrag >= 0)
);

-- Create table Teilnehmer
CREATE TABLE Teilnehmer
(
    PersID INT NOT NULL,
    AnlaID INT NOT NULL,
    CONSTRAINT Teilnehmer_PK PRIMARY KEY (PersID, AnlaID)
);

-- Foreign keys for table Anlass
ALTER TABLE Anlass
ADD CONSTRAINT Anlass_Person_FK FOREIGN KEY (OrgID)
REFERENCES Person(PersID);

-- Foreign keys for table Sponsorenkontakt
ALTER TABLE Sponsorenkontakt
ADD CONSTRAINT FK_SPONK_PERSON FOREIGN KEY (PersID)
REFERENCES Person(PersID);

ALTER TABLE Sponsorenkontakt
ADD CONSTRAINT FK_SPONK_SPONSOR FOREIGN KEY (SponID)
REFERENCES Sponsor(SponID);

-- Foreign keys for table Teilnehmer
ALTER TABLE Teilnehmer
ADD CONSTRAINT FK_TEILN_ANLASS FOREIGN KEY (AnlaID)
REFERENCES Anlass(AnlaID);

ALTER TABLE Teilnehmer
ADD CONSTRAINT FK_TEILN_PERSON FOREIGN KEY (PersID)
REFERENCES Person(PersID);

-- Foreign keys for table Funktionsbesetzung
ALTER TABLE Funktionsbesetzung
ADD CONSTRAINT Funktionsbesetzung_Funktion_FK FOREIGN KEY (FunkID)
REFERENCES Funktion(FunkID);

ALTER TABLE Funktionsbesetzung
ADD CONSTRAINT Funktionsbesetzung_Person_FK FOREIGN KEY (PersID)
REFERENCES Person(PersID);

-- Foreign keys for table Person
ALTER TABLE Person
ADD CONSTRAINT Person_Person_FK FOREIGN KEY (MentorID)
REFERENCES Person(PersID);

ALTER TABLE Person
ADD CONSTRAINT Person_Status_FK FOREIGN KEY (StatID)
REFERENCES Status(StatID);

-- Foreign keys for table Spende
ALTER TABLE Spende
ADD CONSTRAINT Spende_Anlass_FK FOREIGN KEY (AnlaID)
REFERENCES Anlass(AnlaID);

ALTER TABLE Spende
ADD CONSTRAINT Spende_Sponsor_FK FOREIGN KEY (SponID)
REFERENCES Sponsor(SponID);


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

