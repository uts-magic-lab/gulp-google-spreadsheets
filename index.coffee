debug = require('debug')('gulp-spreadsheets')
es = require('event-stream')
File = require('vinyl')
GoogleSpreadsheet = require('google-spreadsheet')

dashify = (title)->
    title.replace(/\W+/g, '-').toLowerCase()

module.exports = (spreadsheetId)->
    stream = new es.Stream()

    spreadsheet = new GoogleSpreadsheet(spreadsheetId)
    spreadsheet.getInfo((err, info={})->
        debug('loaded info for spreadsheet %s', spreadsheetId)
        if err then return stream.emit('error', err)

        for worksheet in info.worksheets or []
            file = new File({
                path: dashify(worksheet.title) + '.json'
                contents: new Buffer('')
            })
            file.worksheet = worksheet
            stream.emit('data', file)
        stream.emit('end')
    )

    fetchRows = (file, callback)->
        spreadsheet.getRows(file.worksheet.id, (err, rows=[])->
            debug('loaded worksheet "%s": %d rows', file.worksheet.title, rows.length)
            if err then return callback(err)

            file.worksheet.rows = rows
            file.contents = new Buffer(JSON.stringify(file.worksheet, null, '  '))
            callback(null, file)
        )

    return stream.pipe(es.map(fetchRows))
