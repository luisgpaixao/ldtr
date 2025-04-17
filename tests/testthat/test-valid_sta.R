test_that("error empty study area", {
  stda <- system.file("extdata", "emptysta.shp", package = "ldtr")
  
  expect_error(valid_studyarea(stda))
})

test_that("error study area not in meters or no crs", {
  stda <- system.file("extdata", "mun_portel_wgs.shp", package = "ldtr")
  
  expect_error(valid_studyarea(stda))
  
  stda <- system.file("extdata", "nocrs.shp", package = "ldtr")
  
  expect_error(valid_studyarea(stda))
})

test_that("error study area not polygon", {
  stda <- system.file("extdata", "line_sta.shp", package = "ldtr")
  
  expect_error(valid_studyarea(stda))
  
  stda <- system.file("extdata", "point_sta.shp", package = "ldtr")
  
  expect_error(valid_studyarea(stda))
})