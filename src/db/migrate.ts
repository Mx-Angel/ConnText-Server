import * as fs from 'fs';
import { connectionPool } from '@conntext/shared/database';

const client = await connectionPool.connect();

async function migrateDB(): Promise<void> {
  try {
    const connectionInfo = await client.query(`
      SELECT
      current_database() AS database,
      current_user AS user,
      current_schema() AS schema,
      inet_server_addr() AS host,
      inet_server_port() AS port;
    `);
    console.log(connectionInfo.rows[0]);
    const serverDetailsScript = fs.readFileSync(
      'src/db/migrations/001_server_details_schema.sql',
      'utf-8',
    );
    const communcationScript = fs.readFileSync(
      'src/db/migrations/002_communication_schema.sql',
      'utf-8',
    );
    const auditScript = fs.readFileSync('src/db/migrations/003_audit_schema.sql', 'utf-8');

    await client.query('BEGIN');
    await client.query(serverDetailsScript);
    await client.query(communcationScript);
    await client.query(auditScript);
    await client.query('COMMIT');

    console.log('Migration successful');
  } catch (error) {
    // Add logger
    await client.query('ROLLBACK');
    console.log(`An error occured whilst trying to read .sql files: ${error}`);
  } finally {
    client.release();
    await connectionPool.end();
  }
}

migrateDB();
