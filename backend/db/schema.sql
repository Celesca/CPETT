-- Days
CREATE TABLE days (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);

-- Hours
CREATE TABLE hours (
    id SERIAL PRIMARY KEY,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);

-- Sections
CREATE TABLE sections (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL UNIQUE,
    num_students INT NOT NULL DEFAULT 40
);

-- Subjects
CREATE TABLE subjects (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    code VARCHAR(20) NOT NULL UNIQUE,
    duration INT NOT NULL,  -- Duration in periods
    is_central BOOLEAN NOT NULL DEFAULT FALSE  -- Indicates if it's a central course
);

-- Tags
CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Teachers
CREATE TABLE teachers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Student Years
CREATE TABLE student_years (
    id SERIAL PRIMARY KEY,
    year INT NOT NULL
);

-- Student Groups
CREATE TABLE student_groups (
    id SERIAL PRIMARY KEY,
    year_id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    FOREIGN KEY (year_id) REFERENCES student_years(id)
);

-- Student Subgroups
CREATE TABLE student_subgroups (
    id SERIAL PRIMARY KEY,
    group_id INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    FOREIGN KEY (group_id) REFERENCES student_groups(id)
);

-- Rooms
CREATE TABLE rooms (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    type VARCHAR(50) NOT NULL,  -- e.g., 'computer lab', 'electronic lab'
    is_central BOOLEAN NOT NULL DEFAULT FALSE  -- Indicates if it's a central room
);

-- Activities
CREATE TABLE activities (
    id SERIAL PRIMARY KEY,
    subject_id INT NOT NULL,
    teacher_id INT NOT NULL,
    room_id INT NOT NULL,
    duration INT NOT NULL,
    day_id INT NOT NULL,
    hour_ids INT[] NOT NULL,  -- Array of hour IDs
    min_days INT,
    weight DECIMAL(5,2) DEFAULT 100.00,
    consecutive BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (subject_id) REFERENCES subjects(id),
    FOREIGN KEY (teacher_id) REFERENCES teachers(id),
    FOREIGN KEY (room_id) REFERENCES rooms(id),
    FOREIGN KEY (day_id) REFERENCES days(id)
);

-- Activity Students
CREATE TABLE activity_students (
    activity_id INT NOT NULL,
    section_id INT NOT NULL,
    PRIMARY KEY (activity_id, section_id),
    FOREIGN KEY (activity_id) REFERENCES activities(id),
    FOREIGN KEY (section_id) REFERENCES sections(id)
);

-- Activity Tags
CREATE TABLE activity_tags (
    activity_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (activity_id, tag_id),
    FOREIGN KEY (activity_id) REFERENCES activities(id),
    FOREIGN KEY (tag_id) REFERENCES tags(id)
);