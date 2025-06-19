-- Users table
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  phone VARCHAR(20),
  avatar_url TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Bands table
CREATE TABLE IF NOT EXISTS bands (
  id UUID PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  logo_url TEXT,
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Band members table
CREATE TABLE IF NOT EXISTS band_members (
  id UUID PRIMARY KEY,
  band_id UUID REFERENCES bands(id),
  user_id UUID REFERENCES users(id),
  role VARCHAR(50) NOT NULL,
  instrument VARCHAR(100),
  joined_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(band_id, user_id)
);

-- Venues table
CREATE TABLE IF NOT EXISTS venues (
  id UUID PRIMARY KEY,
  band_id UUID REFERENCES bands(id),
  name VARCHAR(255) NOT NULL,
  address TEXT,
  notes TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Rehearsals table
CREATE TABLE IF NOT EXISTS rehearsals (
  id UUID PRIMARY KEY,
  band_id UUID REFERENCES bands(id),
  venue_id UUID REFERENCES venues(id),
  title VARCHAR(255) NOT NULL,
  description TEXT,
  start_time TIMESTAMP NOT NULL,
  end_time TIMESTAMP NOT NULL,
  is_recurring BOOLEAN DEFAULT FALSE,
  recurring_pattern JSONB,
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Attendance table
CREATE TABLE IF NOT EXISTS attendance (
  id UUID PRIMARY KEY,
  rehearsal_id UUID REFERENCES rehearsals(id),
  user_id UUID REFERENCES users(id),
  status VARCHAR(20) NOT NULL,
  notes TEXT,
  response_time TIMESTAMP DEFAULT NOW(),
  check_in_time TIMESTAMP,
  UNIQUE(rehearsal_id, user_id)
);
