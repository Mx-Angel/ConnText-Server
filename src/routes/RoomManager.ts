import { FastifyInstance } from 'fastify';

export default async function pingRoutes(server: FastifyInstance): Promise<void> {
    server.route({
        url: '/ping',
        method: 'GET',
        handler: async (request, reply) => {
            reply.type('application/json');
            return JSON.stringify({
                message: 'pong',
                timestamp: new Date().toISOString(),
            }) + '\n';
        }
    });
}