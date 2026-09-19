-- Schema
CREATE SCHEMA IF NOT EXISTS server_details;

-- Custom Data Types
CREATE TYPE server_details.account_status AS ENUM('online', 'idle', 'do_not_disturb', 'offline');
CREATE TYPE server_details.request_status AS ENUM('sent', 'received', 'rejected', 'accepted');

-- Tables
-- Table: users
CREATE TABLE server_details.users (
  user_id         VARCHAR PRIMARY KEY DEFAULT uuidv7(),
  username        VARCHAR(255) NOT NULL UNIQUE,
  email           VARCHAR(255) NOT NULL,
  password_hash   VARCHAR NOT NULL,
  two_factor_auth BOOL DEFAULT FALSE,
  profile_picture VARCHAR,
  user_status     server_details.account_status NOT NULL DEFAULT 'offline',
  profile_desc    VARCHAR,
  created_at      timestamptz DEFAULT now(),
  last_active     timestamptz
);

-- Table: server_members
CREATE TABLE server_details.server_members (
  member_id                   VARCHAR PRIMARY KEY DEFAULT uuidv7(),
  user_id                     VARCHAR NOT NULL REFERENCES server_details.users(user_id),
  server_user_nickname        VARCHAR UNIQUE,
  server_user_profile_picture VARCHAR,
  joined_at                   timestamptz DEFAULT now()
);

-- TABLE: roles
CREATE TABLE server_details.roles (
  role_id   VARCHAR PRIMARY KEY DEFAULT uuidv7(),
  colour    VARCHAR(7) DEFAULT '#ffffff',
  role_desc VARCHAR
);

-- TABLE: permissions
CREATE TABLE server_details.permissions (
  permission_id   VARCHAR PRIMARY KEY DEFAULT uuidv7(),
  permission_name VARCHAR,
  permission_desc VARCHAR
);

-- Table: key_backup
CREATE TABLE server_details.key_backup (
  backup_id         VARCHAR PRIMARY KEY DEFAULT uuidv7(),
  user_id           VARCHAR NOT NULL REFERENCES server_details.users(user_id),
  encrypted_content bytea NOT NULL,
  last_modified     timestamptz NOT NULL
);

-- Table: friend_request
CREATE TABLE server_details.friend_request (
  request_id   VARCHAR PRIMARY KEY DEFAULT uuidv7(),
  requester_id VARCHAR NOT NULL REFERENCES server_details.users(user_id),
  recipient_id VARCHAR NOT NULL REFERENCES server_details.users(user_id),
  status       server_details.request_status NOT NULL DEFAULT 'sent',
  created_at   timestamptz DEFAULT now()
);

-- Table: blocked
CREATE TABLE server_details.blocked (
  block_id   VARCHAR PRIMARY KEY DEFAULT uuidv7(),
  blocker_id VARCHAR NOT NULL REFERENCES server_details.users(user_id),
  blocked_id VARCHAR NOT NULL REFERENCES server_details.users(user_id),
  created_at timestamptz DEFAULT now()
);

-- Table: sessions
CREATE TABLE server_details.sessions (
  session_token VARCHAR PRIMARY KEY DEFAULT uuidv7(),
  user_id       VARCHAR NOT NULL REFERENCES server_details.users(user_id),
  created_at    timestamptz NOT NULL,
  expires_at    timestamptz NOT NULL
);

-- Table: server_details
CREATE TABLE server_details.server_details (
  server_id      VARCHAR PRIMARY KEY DEFAULT uuidv7(),
  server_name    VARCHAR NOT NULL,
  server_picture VARCHAR,
  server_desc    VARCHAR,
  owned_by       VARCHAR NOT NULL REFERENCES server_details.server_members(member_id),
  created_at     timestamptz DEFAULT now()
);

-- TABLE: member_roles
CREATE TABLE server_details.member_roles (
  member_id VARCHAR NOT NULL REFERENCES server_details.server_members(member_id),
  role_id   VARCHAR NOT NULL REFERENCES server_details.roles(role_id)
);

-- TABLE: role_permission
CREATE TABLE server_details.role_permission (
  role_id       VARCHAR NOT NULL REFERENCES server_details.roles(role_id),
  permission_id VARCHAR NOT NULL REFERENCES server_details.permissions(permission_id)
);
