-- Schema
CREATE SCHEMA IF NOT EXISTS audit;

-- Custom Data Types
CREATE TYPE audit.audit_event_type AS ENUM (
  -- Authentication and account
  'ACCOUNT_CREATED',
  'ACCOUNT_UPDATED',
  'ACCOUNT_DELETED',
  'LOGIN_SUCCESS',
  'LOGIN_FAILURE',
  'LOGOUT',
  'PASSWORD_RESET_REQUESTED',
  'PASSWORD_CHANGED',
  'MFA_ENABLED',
  'MFA_DISABLED',
  'SESSION_REVOKED',

  -- Key backups and personal data
  'KEY_BACKUP_CREATED',
  'KEY_BACKUP_RETRIEVED',
  'KEY_BACKUP_DELETED',
  'DATA_EXPORTED',
  'PERSONAL_DATA_DELETED',

  -- Servers and membership
  'SERVER_CREATED',
  'SERVER_UPDATED',
  'SERVER_DELETED',
  'SERVER_JOINED',
  'SERVER_LEFT',
  'MEMBER_INVITED',
  'MEMBER_REMOVED',

  -- Channels and messages
  'CHANNEL_CREATED',
  'CHANNEL_UPDATED',
  'CHANNEL_DELETED',
  'MESSAGE_CREATED',
  'MESSAGE_EDITED',
  'MESSAGE_DELETED',
  'MESSAGE_PINNED',
  'MESSAGE_UNPINNED',

  -- Moderation
  'USER_BANNED',
  'USER_UNBANNED',
  'USER_KICKED',
  'USER_TIMED_OUT',
  'USER_TIMEOUT_LIFTED',

  -- Permissions and roles
  'ROLE_CREATED',
  'ROLE_UPDATED',
  'ROLE_DELETED',
  'ROLE_ASSIGNED',
  'ROLE_REMOVED',
  'PERMISSIONS_UPDATED',

  -- Files and administration
  'FILE_UPLOADED',
  'FILE_DELETED',
  'BACKUP_CREATED',
  'BACKUP_RESTORED',
  'BACKUP_SETTINGS_UPDATED',
  'SERVER_SETTINGS_UPDATED',
  'PLUGIN_INSTALLED',
  'PLUGIN_REMOVED',
  'SOFTWARE_UPDATED'
);
CREATE TYPE audit.severity_level as ENUM('INFO', 'WARNING', 'ERROR', 'CRITICAL');

-- Tables
-- Table: audit
CREATE TABLE audit.audit (
  log_id       VARCHAR PRIMARY KEY DEFAULT uuidv7(),
  actor_id     VARCHAR NOT NULL REFERENCES server_details.users(user_id),
  service_name VARCHAR NOT NULL,
  event_type   audit.audit_event_type NOT NULL,
  severity     audit.severity_level NOT NULL,
  log_message  VARCHAR NOT NULL,
  timestamp    timestamptz
);
