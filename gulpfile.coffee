gulp = require('gulp')

gulpSheets = require('./index.coffee')

gulp.task('default', ['test'])
gulp.task('test', ->
    gulpSheets(process.env.GSS_ID)
    .pipe(gulp.dest('./public/'))
)
