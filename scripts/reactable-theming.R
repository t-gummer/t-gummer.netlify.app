reactableTheme_dark <- function(primary_colour = "#00FF00") { # could try pink as an alternative
  reactable::reactableTheme(
    color = "white",
    backgroundColor = "#191918",
    borderColor = primary_colour,
    headerStyle = list(
      color = primary_colour,
      "background-color" = "black"
      )
    )
}

reactableTheme_light <- function(primary_colour = "#FF7415") { # could try maroon or blue as an alternative
  reactable::reactableTheme(
    color = "black",
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

# https://glin.github.io/reactable/articles/cookbook/cookbook.html#merge-cells
reactable_merged <- function(column) {
  JS(glue("function(rowInfo, column, state) {
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


