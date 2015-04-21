# Gulp-Google-Spreadsheets

Gulp plugin to load a Google Spreadsheet and emit each worksheet as a file in a Vinyl stream.

### Usage

    gulpSheets = require('gulp-google-spreadsheets')

    gulp.task('fetch-data', ->
        gulpSheets(spreadsheetId)
        .pipe(renderTemplates)
        .pipe(gulp.dest('./public/'))
    )
