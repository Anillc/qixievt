const request = require('superagent')

module.exports = async (req, res) => {
    const url = req.query.url
    if (!url) {
        res.status(403)
        res.send('url is required')
        return
    }
    try {
        const result = await request(url).responseType('blob')
        res.setHeader('Content-Type', result.type)
        res.send(result.body)
    } catch(e) {
        res.status(500)
        res.send(e.toString())
    }
}