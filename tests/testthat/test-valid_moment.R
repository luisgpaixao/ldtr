test_that("error moment no crs", {
  stda <- st_read(system.file("extdata", "nocrs.shp", package = "ldtr"))
  
  expect_error(valid_moment(stda, 1))
  
  
  stda <- st_read(system.file("extdata", "nocrs.gpkg", package = "ldtr"))
  
  expect_error(valid_moment(stda, 1))
})

test_that("error moment not polygon", {
  stda <- st_read(system.file("extdata", "line_moment.shp", package = "ldtr"))
  
  expect_error(valid_moment(stda, 1))
  
  stda <- st_read(system.file("extdata", "point_moment.shp", package = "ldtr"))
  
  expect_error(valid_moment(stda, 1))
  
  
  stda <- st_read(system.file("extdata", "line_moment.gpkg", package = "ldtr"))
  
  expect_error(valid_moment(stda, 1))
  
  stda <- st_read(system.file("extdata", "point_moment.gpkg", package = "ldtr"))
  
  expect_error(valid_moment(stda, 1))
})