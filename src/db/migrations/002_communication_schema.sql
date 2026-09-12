-- Schema
CREATE SCHEMA IF NOT EXISTS comms;

-- Custom Data Types
CREATE TYPE comms.channel_selection AS ENUM('text', 'voice');
CREATE TYPE comms.encryption AS ENUM('standard', 'E2E');

-- Tables
-- Table: channels
CREATE TABLE comms.channels (
  channel_id      VARCHAR PRIMARY KEY DEFAULT uuidv7(),
  channel_name    VARCHAR NOT NULL UNIQUE,
  channel_type    comms.channel_selection NOT NULL,
  channel_desc    VARCHAR,
  created_by      VARCHAR NOT NULL REFERENCES server_details.server_members(member_id),
  encryption_mode VARCHAR,
  created_at      timestamptz DEFAULT now()
);

-- Table: messages
CREATE TABLE comms.messages (
  message_id     VARCHAR PRIMARY KEY DEFAULT uuidv7(),
  member_id      VARCHAR NOT NULL REFERENCES server_details.server_members(member_id),
  channel_id     VARCHAR NOT NULL REFERENCES comms.channels(channel_id),
  content        VARCHAR NOT NULL,
  created_at     timestamptz DEFAULT now(),
  last_edited_at timestamptz,
  edit_count     INT
);

-- Table: rtc_history
CREATE TABLE comms.rtc_history (
  rtc_id      VARCHAR PRIMARY KEY DEFAULT uuidv7(),
  channel_id  VARCHAR NOT NULL REFERENCES comms.channels(channel_id),
  started_at  timestamptz DEFAULT now(),
  finished_at timestamptz,
  started_by  VARCHAR NOT NULL REFERENCES server_details.server_members(member_id)
);

-- Table: reactions
CREATE TABLE comms.reactions (
  reaction_id VARCHAR PRIMARY KEY DEFAULT uuidv7(),
  message_id  VARCHAR NOT NULL REFERENCES comms.messages(message_id),
  member_id   VARCHAR NOT NULL REFERENCES server_details.server_members(member_id),
  content     VARCHAR NOT NULL
);

-- Table: media
CREATE TABLE comms.media (
  media_id      VARCHAR PRIMARY KEY DEFAULT uuidv7(),
  message_id    VARCHAR NOT NULL REFERENCES comms.messages(message_id),
  uploaded_by   VARCHAR NOT NULL REFERENCES server_details.server_members(member_id),
  file_location VARCHAR NOT NULL,
  file_type     VARCHAR NOT NULL,
  file_size     INT NOT NULL,
  uploaded_at   timestamptz DEFAULT now()
);
