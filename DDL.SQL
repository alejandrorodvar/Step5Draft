-- Group 135: Team Dog Lovers
-- Team Members: Tsz To Chan, Alejandro Rodriguez Varona
-- Project Title: A all rounded online degree consulting system

SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

-- Create or replace Schools table
-- These are the Schools in the systen
CREATE OR REPLACE TABLE Schools (
    schoolID INT AUTO_INCREMENT NOT NULL,
    schoolName VARCHAR(255) NOT NULL,
    location VARCHAR(255) NOT NULL,
    contactInfo VARCHAR(255),
    PRIMARY KEY (schoolID)
);

-- Create or replace Programs table
-- These are the registered degree Programs for enlisted schools
CREATE OR REPLACE TABLE Programs (
    programID INT AUTO_INCREMENT NOT NULL,
    programName VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    degreeLevel VARCHAR(50),
    PRIMARY KEY (programID)
);

-- Create or replace SchoolsPrograms intersection table (Schools and Programs)
CREATE OR REPLACE TABLE SchoolsPrograms (
    schoolsProgramsID INT AUTO_INCREMENT NOT NULL,
    schoolID INT, 
    programID INT,
    PRIMARY KEY (schoolsProgramsID),
    FOREIGN KEY (schoolID) REFERENCES Schools(schoolID),
    FOREIGN KEY (programID) REFERENCES Programs(programID)
);

-- Create or replace Students table
-- Represents the Students in the program
CREATE OR REPLACE TABLE Students (
    studentID INT AUTO_INCREMENT NOT NULL,
    email VARCHAR(255),
    fullName VARCHAR(255) NOT NULL,
    registrationDate DATE NOT NULL,
    country VARCHAR(255),
    interestedProgram VARCHAR(255),
    PRIMARY KEY (studentID)
);

-- Create or replace Alumni table
-- Represents the Alumni in the system
CREATE OR REPLACE TABLE Alumni (
    alumniID INT AUTO_INCREMENT NOT NULL,
    fullName VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    graduationYear YEAR NOT NULL,
    degree VARCHAR(255) NOT NULL,
    schoolsProgramsID INT,
    PRIMARY KEY (alumniID),
    FOREIGN KEY (schoolsProgramsID) REFERENCES SchoolsPrograms(schoolsProgramsID)
);

-- Create or replace Consultations table
-- Represents the Consultations that take place between Schools and Programs
CREATE OR REPLACE TABLE Consultations (
    consultationID INT AUTO_INCREMENT NOT NULL,
    studentID INT,
    alumniID INT,
    consultationDate DATETIME NOT NULL,
    notes VARCHAR(255) NOT NULL,
    schoolsProgramsID INT,
    PRIMARY KEY (consultationID),
    FOREIGN KEY (studentID) REFERENCES Students(studentID),
    FOREIGN KEY (alumniID) REFERENCES Alumni(alumniID),
    FOREIGN KEY (schoolsProgramsID) REFERENCES SchoolsPrograms(schoolsProgramsID)
);


-- Insert sample data into Schools table
INSERT INTO Schools (
    schoolID, 
    schoolName, 
    location, 
    contactInfo
)
VALUES
    (1, 'University of Washington', 'United States', 'help@uwashington.edu'),
    (2, 'Boston College', 'United States', 'help@bostoncollege.edu'),
    (3, 'University of Buenos Aires', 'Argentina', 'help@ubuenosaires.edu'),
    (4, 'The University of Hong Kong', 'Hong Kong', 'help@uhongkong.edu'),
    (5, 'University of Sydney', 'Australia', 'help@usydney.edu');

-- Insert sample data into Programs table
INSERT INTO Programs (
    programID, 
    programName,
    description, 
    degreeLevel
)
VALUES
    (1, 'Boston College M.S. in Data Science', 'Online Master for Data Science', 'Master'),
    (2, 'Seton Hall Master of Science in Accounting', 'Online Master for Accounting', 'Master'),
    (3, 'Stockholm University Business Analytics and Data Science', 'Online BS for Business Analytics and Data Science', 'Bachelor of Science'),
    (4, 'Barcelona School of Arts and Design Master in Graphic Design', 'Online Master in Graphic Design', 'Master'),
    (5, 'IFA Paris Bachelor in Fashion Design and Technology', 'Online BS in Fashion Design and Technology', 'Bachelor of Arts');

-- Insert sample data into SchoolsPrograms table
INSERT INTO SchoolsPrograms (
    schoolsProgramsID,
    schoolID,
    programID
)
VALUES
    (1, 2, 5),
    (2, 5, 2),
    (3, 1, 1),
    (4, 1, 1),
    (5, 1, 1);

-- Insert sample data into Students table
INSERT INTO Students (
    studentID, 
    email, 
    fullName, 
    registrationDate, 
    country, 
    interestedProgram
)
VALUES
    (1, 'jsmith@gmail.com', 'John Smith', '2025-03-19', 'United States', 'Chemical Engineering'),
    (2, 'pete.j@hotmail.com', 'Peter Jones', '2025-01-21', 'Canada', 'Law'),
    (3, 'sam.c@gmail.com', 'Sara Lopez', '2025-02-04', 'Mexico', 'Medicine'),
    (4, 'm.allen@hotmail.com', 'Mary Allen', '2025-01-15', 'Australia', 'Business'),
    (5, 'john.cena@gmail.com', 'John Cena', '2025-03-01', 'Puerto Rico', 'Philosophy');

-- Insert sample data into Alumni table
INSERT INTO Alumni (
    alumniID, 
    fullName,
    email, 
    graduationYear, 
    degree, 
    schoolsProgramsID
)
VALUES
    (1, 'Arjun Patel', 'a.patel@gmail.com', 2022, 'Mechanical Engineering', 1),
    (2, 'Jane Crawford', 'j.crawford@gmail.com', 2012, 'Education', 1),
    (3, 'Julio Gomez', 'julio.g@hotmail.com', 2023, 'Psychology', 3),
    (4, 'Qin Xi Hiu', 'qinxi.h@hotmail.com', 2017, 'Electrical Engineering', 5),
    (5, 'Nuri Gjoka', 'n.gjoka@gmail.com', 2024, 'Pharmacy', 3);

-- Insert sample data into Consultations table
INSERT INTO Consultations (
    consultationID, 
    studentID, 
    alumniID, 
    consultationDate, 
    notes,
    schoolsProgramsID
)
VALUES
    (1, 3, 1, '2024-05-01', 'Student was helped with transferring programs.', 1), 
    (2, 5, 3, '2024-06-21', 'Student helped with finding alternate class resources.', 5),
    (3, 4, 2, '2024-05-05', 'Student helped with networking.', 5),
    (4, 2, 5, '2024-04-02', 'Student given a private resume workshop.', 5),
    (5, 3, 5, '2024-06-06', 'Student helped with applying for a graduate program.', 2);



SET FOREIGN_KEY_CHECKS=1;
COMMIT;