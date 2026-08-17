import express, { type Request, type Response } from 'express';

const router = express.Router();

router.post('/register', (req: Request, res: Response) => {
  res.send('Register endpoint');
});

router.post('/login', (req: Request, res: Response) => {
  res.send('Login endpoint');
});

router.post('/token/refresh', (req: Request, res: Response) => {
  res.send('Token refresh endpoint');
});

router.get('/token/validate', (req: Request, res: Response) => {
  res.send('Token validation endpoint');
});

router.post('/logout', (req: Request, res: Response) => {
  res.send('Logout endpoint');
});

router.put('/backup', (req: Request, res: Response) => {
  res.send('Store backup');
});

router.get('/backup', (req: Request, res: Response) => {
  res.send('Get backup');
});

router.delete('/backup', (req: Request, res: Response) => {
  res.send('Delete backup');
});

export default router;
