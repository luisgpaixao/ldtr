test_that("error moment no crs", {
  stda <- system.file("extdata", "nocrs.shp", package = "ldtr")
  
  expect_error(valid_moment(stda))
})

test_that("error moment not polygon", {
  stda <- system.file("extdata", "line_moment.shp", package = "ldtr")
  
  expect_error(valid_moment(stda))
  
  stda <- system.file("extdata", "point_moment.shp", package = "ldtr")
  
  expect_error(valid_moment(stda))
})