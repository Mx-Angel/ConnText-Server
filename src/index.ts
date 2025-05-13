import fastify from 'fastify'
import pingRoutes from './routes/RoomManager';

const server = fastify();

server.register(pingRoutes, { prefix: '/api' });

server.listen({ port: 8080 }, (err, address) => {
  if (err) {
    console.error(err)
    process.exit(1)
  }
  console.log(`Server listening at ${address}`)
});