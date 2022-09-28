import * as express from 'express';
import 'express-async-errors';

const app = express();
const client = require('prom-client');
const defaultLabels = { appName: 'urban' };
client.register.setDefaultLabels(defaultLabels);

const collectDefaultMetrics = client.collectDefaultMetrics;
collectDefaultMetrics();

// Create a counter metric
const counter = new client.Counter({
  name: 'responses_count',
  help: 'Application responses 2xx count',
  labelNames: ['code'],
});

app.get('/', (req: express.Request, res: express.Response) => {
  counter.inc({ code: 200 }); // Increment by 1
  const response = {
    hostname: req.hostname,
    uptime: process.uptime(),
    podname: process.env.HOSTNAME,
  };

  res.status(200).send(response);
});

app.get('/metrics', async function (req, res) {
  res.set('Content-Type', client.register.contentType);
  const metrics = await client.register.metrics();
  res.end(metrics);
});

app.listen(3000, () => {
  console.log('listening on 3000');
});