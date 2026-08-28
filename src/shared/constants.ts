import dotenv from 'dotenv';

dotenv.config();

export const DB_HOST = process.env.DB_HOST || '127.0.0.1';
export const DB_PORT = parseInt(process.env.DB_PORT || '5342', 10);
export const DB_NAME = process.env.DB_NAME;
export const DB_USER = process.env.DB_USER;
export const DB_PASS = process.env.DB_PASS;

if (!DB_NAME || !DB_USER || !DB_PASS) throw new Error('Missing database environment variables');
