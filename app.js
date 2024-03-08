const express = require('express');
const mysql = require('mysql2');
const path = require('path');

const app = express();
const port = 9988;

const pool = mysql.createPool({
    connectionLimit : 10,
    host            : 'classmysql.engr.oregonstate.edu',
    user            : 'cs340_chantsz',
    password        : '8640',
    database        : 'cs340_chantsz'
});

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));

})

app.get('/students-page', (req, res) => {
    res.sendFile(path.join(__dirname, 'students.html'));
});

app.get('/alumni', (req, res) => {
    res.sendFile(path.join(__dirname, 'alumni.html'));
});

app.get('/programs', (req, res) => {
    res.sendFile(path.join(__dirname, 'programs.html'));
});

app.get('/schools', (req, res) => {
    res.sendFile(path.join(__dirname, 'schools.html'));
});

app.get('/consultations', (req, res) => {
    res.sendFile(path.join(__dirname, 'consultations.html'));
});

app.get('/school-programs', (req, res) => {
    res.sendFile(path.join(__dirname, 'school_programs.html'));
});

// create students table
const createStudentsTable = () => {
    const sql = `
    CREATE TABLE IF NOT EXISTS Students (
        studentID INT AUTO_INCREMENT NOT NULL,
        email VARCHAR(255),
        fullName VARCHAR(255) NOT NULL,
        registrationDate DATE NOT NULL,
        country VARCHAR(255),
        interestedProgram VARCHAR(255),
        PRIMARY KEY (studentID)
    )
    `;
    pool.query(sql, (error, result) => {
        if (error) throw error;
        console.log("Table 'students created or already exists.");
    });
};

createStudentsTable();

// select all students
app.get('/students', (req, res) => {
    pool.query('SELECT * FROM Students', (error, results) => {
        if (error) throw error;
        res.json(results);
    })
})

// create new students
app.post('/students', (req, res) => {
    const { email, fullName, registrationDate, country, interestedProgram } = req.body;
    pool.query('INSERT INTO Students (email, fullName, registrationDate, country, interestedProgram) VALUES (?, ?, ?, ?, ?)',
        [email, fullName, registrationDate, country, interestedProgram],
        (error, results) => {
            if (error) throw error;
            res.status(201).json({ message: `Student added with ID: ${results.insertId}` });
        }
    );
});

// Update a student
app.put('/students/:id', (req, res) => {
    const { email, fullName, registrationDate, country, interestedProgram } = req.body;
    pool.query('UPDATE Students SET email = ?, fullName = ?, registrationDate = ?, country = ?, interestedProgram = ? WHERE studentID = ?',
        [email, fullName, registrationDate, country, interestedProgram, req.params.id],
        (error, results) => {
            if (error) throw error;
            res.send(`Student with ID: ${req.params.id} was updated.`);
        }
    );
});

// Delete a student
app.delete('/students/:id', (req, res) => {
    pool.query('DELETE FROM Students WHERE studentID = ?', [req.params.id], (error, results) => {
        if (error) throw error;
        res.send(`Student with ID: ${req.params.id} was deleted.`);
    });
});

// Create alumni table
const createAlumniTable = () => {
    const sql = `
    CREATE TABLE IF NOT EXISTS Alumni (
        alumniID INT AUTO_INCREMENT NOT NULL,
        fullName VARCHAR(255) NOT NULL,
        email VARCHAR(255),
        graduationYear YEAR NOT NULL,
        degree VARCHAR(255) NOT NULL,
        schoolsProgramsID INT,
        PRIMARY KEY (alumniID),
        FOREIGN KEY (schoolsProgramsID) REFERENCES SchoolsPrograms(schoolsProgramsID)
    )
    `;
    pool.query(sql, (error, result) => {
        if (error) throw error;
        console.log("Table 'alumni' created or already exists.");
    });
};

createAlumniTable();

// Select all alumni
app.get('/alumni', (req, res) => {
    pool.query('SELECT * FROM Alumni', (error, results) => {
        if (error) throw error;
        res.json(results);
    });
});

// Create new alumni
app.post('/alumni', (req, res) => {
    const { fullName, email, graduationYear, degree, schoolsProgramsID } = req.body;
    pool.query('INSERT INTO Alumni (fullName, email, graduationYear, degree, schoolsProgramsID) VALUES (?, ?, ?, ?, ?)',
        [fullName, email, graduationYear, degree, schoolsProgramsID],
        (error, results) => {
            if (error) throw error;
            res.status(201).json({ message: `Alumni added with ID: ${results.insertId}` });
        }
    );
});

// Update an alumni
app.put('/alumni/:id', (req, res) => {
    const { fullName, email, graduationYear, degree, schoolsProgramsID } = req.body;
    pool.query('UPDATE Alumni SET fullName = ?, email = ?, graduationYear = ?, degree = ?, schoolsProgramsID = ? WHERE alumniID = ?',
        [fullName, email, graduationYear, degree, schoolsProgramsID, req.params.id],
        (error, results) => {
            if (error) throw error;
            res.send(`Alumni with ID: ${req.params.id} was updated.`);
        }
    );
});

// Delete an alumni
app.delete('/alumni/:id', (req, res) => {
    pool.query('DELETE FROM Alumni WHERE alumniID = ?', [req.params.id], (error, results) => {
        if (error) throw error;
        res.send(`Alumni with ID: ${req.params.id} was deleted.`);
    });
});


// Create schools table
const createSchoolsTable = () => {
    const sql = `
    CREATE TABLE IF NOT EXISTS Schools (
        schoolID INT AUTO_INCREMENT NOT NULL,
        schoolName VARCHAR(255) NOT NULL,
        location VARCHAR(255) NOT NULL,
        contactInfo VARCHAR(255) NOT NULL,
        PRIMARY KEY (schoolID)
    )
    `;
    pool.query(sql, (error, result) => {
        if (error) throw error;
        console.log("Table 'schools' created or already exists.");
    });
};

createSchoolsTable();

// Select all schools
app.get('/schools', (req, res) => {
    pool.query('SELECT * FROM Schools', (error, results) => {
        if (error) throw error;
        res.json(results);
    });
});

// Create new school
app.post('/schools', (req, res) => {
    const { schoolName, location, contactInfo } = req.body;
    pool.query('INSERT INTO Schools (schoolName, location, contactInfo) VALUES (?, ?, ?)',
        [schoolName, location, contactInfo],
        (error, results) => {
            if (error) throw error;
            res.status(201).json({ message: `School added with ID: ${results.insertId}` });
        }
    );
});

// Update a school
app.put('/schools/:id', (req, res) => {
    const { schoolName, location, contactInfo } = req.body;
    pool.query('UPDATE Schools SET schoolName = ?, location = ?, contactInfo = ? WHERE schoolID = ?',
        [schoolName, location, contactInfo, req.params.id],
        (error, results) => {
            if (error) throw error;
            res.send(`School with ID: ${req.params.id} was updated.`);
        }
    );
});

// Delete a school
app.delete('/schools/:id', (req, res) => {
    pool.query('DELETE FROM Schools WHERE schoolID = ?', [req.params.id], (error, results) => {
        if (error) throw error;
        res.send(`School with ID: ${req.params.id} was deleted.`);
    });
});

app.listen(port, () => {
    console.log(`Server running on port ${port}`);  
})