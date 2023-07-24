reactableTheme_dark <- function(primary_colour = "#0F0") { # could try pink as an alternative
  reactable::reactableTheme(
    color = "white",
    backgroundColor = "#191918",
    borderColor = primary_colour,
    headerStyle = list(
      color = primary_colour,
      "background-color" = "#060708"
      )
    )
}

reactableTheme_light <- function(primary_colour = "#FF7415") { # could try maroon or blue as an alternative
  reactable::reactableTheme(
    color = "#060708",
    backgroundColor = "white",
    borderColor = primary_colour,
    headerStyle = list(
      color = "white",
      "background-color" = primary_colour
      )
    )
}

reactable_themed <- function(data, ..., light_theme = reactableTheme_light(), dark_theme = reactableTheme_dark(), additional_classes = character(0)) {
  
  htmltools::tagList(
    reactable::reactable(data, ..., theme = light_theme, class = c("light-mode", additional_classes)),
    reactable::reactable(data, ..., theme = dark_theme, class = c("dark-mode", additional_classes))
  )

}

JS_return_last_value <- reactable::JS("
    function(values) {
      return values[values.length - 1]
    }
  ")

JS_return_first_value <- reactable::JS("
    function(values) {
      return values[0]
    }
  ")

JS_aggregate_other_value <- function(other_column_name) {
  reactable::JS(
  glue::glue("function(values, rows) { 
  return rows[0]['<<other_column_name>>']
             }", .open = "<<", .close = ">>"
             ))
  
}




# https://glin.github.io/reactable/articles/cookbook/cookbook.html#merge-cells
reactable_style_merged <- function(column) {
  reactable::JS(glue::glue("function(rowInfo, column, state) {
          const firstSorted = state.sorted[0]
          // Merge cells if unsorted or sorting by <<column>>
          if (!firstSorted || firstSorted.id === '<<column>>') {
            const prevRow = state.pageRows[rowInfo.viewIndex - 1]
            if (prevRow && rowInfo.values['<<column>>'] === prevRow['<<column>>']) {
              return { visibility: 'hidden' }
            }
          }
        }", .open = "<<", .close = ">>"))
  
}

# Use this to prevent the annoying American default data forma
colFormat_aus <- function(...) {
  reactable::colFormat(..., locales = c("en-AU", 	"en-GB"))
}
