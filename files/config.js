var api = {}
api['name'] = 'API 2'
api['host'] = process.env["SENSU_PORT_4567_TCP_ADDR"]
api['port'] = parseInt(process.env["SENSU_PORT_4567_TCP_PORT"])
api['ssl'] = false
api['user'] = process.env["SENSU_UCHIWA_USER"] || 'sensu'
api['pass'] = process.env["SENSU_UCHIWA_PASS"] || 'sensu'
api['path'] = process.env["SENSU_UCHIWA_PATH"] || ''
api['timeout'] = parseInt(process.env["SENSU_UCHIWA_TIMEOUT"]) || 5000
var allconf = {
  sensu: [api],
  uchiwa: {
    host: '0.0.0.0',
    port: 3000,
    user: process.env.UCHIWA_USER || '',
    pass: process.env.UCHIWA_PASS || '',
    stats: parseInt(process.env.UCHIWA_STATS) || 10,
    refresh: parseInt(process.env.UCHIWA_REFRESH) || 10000
  }
}
console.log(allconf)
module.exports = allconf
