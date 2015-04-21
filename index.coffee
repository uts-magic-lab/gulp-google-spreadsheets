debug = require('debug')('gulp-spreadsheet')
es = require('event-stream')
File = require('vinyl')
GoogleSpreadsheet = require("google-spreadsheet")

dashify = (title)->
    title.replace(/\W+/g, '-').toLowerCase()

module.exports = (spreadsheetId)->
    stream = new es.Stream()

    spreadsheet = new GoogleSpreadsheet(spreadsheetId)
    debug('getting info for spreadsheet %s', spreadsheetId)
    spreadsheet.getInfo((err, info)->
        if err then return stream.emit('error', err)

        for worksheet in info.worksheets or []
            file = new File({
                path: dashify(worksheet.title) + '.html'
                contents: new Buffer('')
            })
            file.worksheet = worksheet
            stream.emit('data', file)
        stream.emit('end')
    )

    fetchRows = (file, callback)->
        debug('getting rows for worksheet %s', file.worksheet.id)
        spreadsheet.getRows(file.worksheet.id, (err, rows)->
            if err then return callback(err)

            file.rows = rows
            callback(null, file)
        )

    return stream.pipe(es.map(fetchRows))
