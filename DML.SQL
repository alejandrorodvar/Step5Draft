-- Group 135: Team Dog Lovers
-- Team Members: Tsz To Chan, Alejandro Rodriguez Varona
-- Project Title: A all rounded online degree consulting system


-- Insert entries individually
-- Insert a new student
INSERT INTO Students (email, fullName, registrationDate, country, interestedProgram)
VALUES (:emailInput, :fullNameInput, :registrationDateInput, :countryInput, :interestedProgramInput);

-- Insert a new alumni
INSERT INTO Alumni (fullName, email, graduationYear, degree, schoolsProgramsID)
VALUES (:fullNameInput, :emailInput, :graduationYearInput, :degreeInput, :schoolsProgramsIDInput);

-- Insert a new school
INSERT INTO Schools (schoolName, location, contactInfo)
VALUES (:schoolNameInput, :locationInput, :contactInfoInput);

-- Insert a new program
INSERT INTO Programs (programName, Description, degreeLevel)
VALUES (:programNameInput, :descriptionInput, :degreeLevelInput);

-- Insert a new consultation
INSERT INTO Consultations (studentID, alumniID, consultationDate, notes, schoolsProgramsID)
VALUES (:studentIDInput, :alumniIDInput, :consultationDateInput, :notesInput, :schoolsProgramsIDInput);

-- Populate drop-down
SELECT SchoolsPrograms.schoolsProgramsID, CONCAT(Schools.schoolName, " ", Programs.programName) AS schoolProgramName FROM SchoolsPrograms
JOIN Schools ON SchoolsPrograms.schoolID = Schools.schoolID
JOIN Programs ON SchoolsPrograms.programID = Programs.programID;

-- Add new value to SchoolsPrograms
INSERT INTO SchoolsPrograms (schoolID, programID)
VALUES (:schoolProgramIDDropdown, :programIDDropdown);


-- SELECT queries to display contents of each table
-- Display the Students table using join
SELECT 
    Students.studentID, 
    Students.email, 
    Students.fullName, 
    Students.registrationDate, 
    Students.country, 
    Students.interestedProgram,
    SchoolsPrograms.schoolsProgramsID, 
    CONCAT(Schools.schoolName, " ", Programs.programName) AS schoolProgramName
FROM Students
JOIN SchoolsPrograms ON Students.schoolsProgramsID = SchoolsPrograms.schoolsProgramsID
JOIN Schools ON SchoolsPrograms.schoolID = Schools.schoolID
JOIN Programs ON SchoolsPrograms.programID = Programs.programID;

-- Display the Alumni table using join
SELECT 
    Alumni.alumniID, 
    Alumni.fullName, 
    Alumni.email, 
    Alumni.graduationYear, 
    Alumni.degree, 
    Alumni.schoolsProgramsID,
    CONCAT(Schools.schoolName, " ", Programs.programName) AS schoolProgramName
FROM Alumni
JOIN SchoolsPrograms ON Alumni.schoolsProgramsID = SchoolsPrograms.schoolsProgramsID
JOIN Schools ON SchoolsPrograms.schoolID = Schools.schoolID
JOIN Programs ON SchoolsPrograms.programID = Programs.programID;

-- Display the Schools table
SELECT * FROM Schools;

-- Display the Consultations table using join
SELECT 
    Consultations.consultationID, 
    Consultations.studentID, 
    Consultations.alumniID, 
    Consultations.consultationDate, 
    Consultations.notes, 
    Consultations.schoolsProgramsID, 
    Students.fullName AS studentName, 
    Alumni.fullName AS alumniName
FROM Consultations
JOIN Students ON Consultations.studentID = Students.studentID
JOIN Alumni ON Consultations.alumniID = Alumni.alumniID;

-- Display the Programs table
SELECT * FROM Programs;

-- Display the SchoolsPrograms table using join
SELECT 
    SchoolsPrograms.schoolsProgramsID, 
    SchoolsPrograms.schoolID, 
    SchoolsPrograms.programID, 
    Schools.schoolName, 
    Programs.programName
FROM SchoolsPrograms
JOIN Schools ON SchoolsPrograms.schoolID = Schools.schoolID
JOIN Programs ON SchoolsPrograms.programID = Programs.programID;


-- UPDATE queries 
-- Update Students
UPDATE Students
SET email = :emailInput, fullName = :fullNameInput, registrationDate = :registrationDateInput, country = :countryInput, interestedProgram = :interestedProgramInput
WHERE studentID = :studentIDInput;

-- Update Alumni
UPDATE Alumni
SET fullName = :fullNameInput, email = :emailInput, graduationYear = :graduationYearInput, degree = :degreeInput, schoolsProgramsID = :schoolsProgramsIDInput
WHERE alumniID = :alumniIDInput;

-- Update Schools
UPDATE Schools
SET schoolName = :schoolNameInput, location = :locationInput, contactInfo = :contactInfoInput
WHERE schoolID = :schoolIDInput;

-- Update Programs
UPDATE Programs
SET programName = :programNameInput, Description = :descriptionInput, degreeLevel = :degreeLevelInput
WHERE programID = :programIDInput;

-- Update Consultations
UPDATE Consultations
SET studentID = :studentIDInput, alumniID = :alumniIDInput, consultationDate = :consultationDateInput, notes = :notesInput, schoolsProgramsID = :schoolsProgramsIDInput
WHERE consultationID = :consultationIDInput;

-- DELETE queries
-- Delete a student
DELETE FROM Students 
WHERE studentID = :studentIDInput;

-- Delete an alumni
DELETE FROM Alumni 
WHERE alumniID = :alumniIDInput;

-- Delete a school
DELETE FROM Schools 
WHERE schoolID = :schoolIDInput;

-- Delete a program
DELETE FROM Programs 
WHERE programID = :programIDInput;

-- Delete a consultation
DELETE FROM Consultations 
WHERE consultationID = :consultationIDInput;


-- Search Queries
-- Dynamic drop=down for Alumni
SELECT alumniID, fullName FROM Alumni; 