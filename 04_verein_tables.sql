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
