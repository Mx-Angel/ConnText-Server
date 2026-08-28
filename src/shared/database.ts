import { Pool } from 'pg';
import { DB_PASS, DB_USER, DB_PORT, DB_NAME, DB_HOST } from './constants.ts';

export const connectionPool: Pool = new Pool({
  host: DB_HOST,
  port: DB_PORT,
  user: DB_USER,
  password: DB_PASS,
  database: DB_NAME,
});
