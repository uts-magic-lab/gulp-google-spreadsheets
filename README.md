# Gulp-Google-Spreadsheets

Gulp plugin to load a Google Spreadsheet and emit each worksheet as a file in a Vinyl stream.

## Installation

    npm install gulp-google-spreadsheets

### Usage

Publish a spreadsheet to the web, then use its id as input to this module, the way you would use a directory as input to `gulp.src()`. It emits a json file for each worksheet, which you can pipe into a page renderer:

    gulpSheets = require('gulp-google-spreadsheets')

    gulp.task('fetch-data', ->
        gulpSheets(spreadsheetId)
        .pipe(renderTemplates)
        .pipe(gulp.dest('./public/'))
    )

Or, if you want to archive the data, pipe it to files:

    gulp.task('fetch-data', ->
        gulpSheets(spreadsheetId)
        .pipe(gulp.dest('./data'))
    )

    gulp.task('content', ['fetch-data', 'compile-templates'], ->
        gulp.src('./data')
        .pipe(renderTemplates)
        .pipe(gulp.dest('./public/'))
    )

### TO DO

- Subscribe to a feed and emit changes in the same style as `gulp.watch()`
