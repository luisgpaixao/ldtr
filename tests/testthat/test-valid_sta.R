test_that("error empty study area", {
  stda <- st_read(system.file("extdata", "emptysta.shp", package = "ldtr"))
  
  expect_error(valid_studyarea(stda))
  
  
  stda <- st_read(system.file("extdata", "emptysta.gpkg", package = "ldtr"))
  
  expect_error(valid_studyarea(stda))
})

test_that("error study area not in meters or no crs", {
  stda <- st_read(system.file("extdata", "mun_portel_wgs.shp", package = "ldtr"))
  
  expect_error(valid_studyarea(stda))
  
  stda <- st_read(system.file("extdata", "nocrs.shp", package = "ldtr"))
  
  expect_error(valid_studyarea(stda))
  
  
  stda <- st_read(system.file("extdata", "mun_portel_wgs.gpkg", package = "ldtr"))
  
  expect_error(valid_studyarea(stda))
  
  stda <- st_read(system.file("extdata", "nocrs.gpkg", package = "ldtr"))
  
  expect_error(valid_studyarea(stda))
})

test_that("error study area not polygon", {
  stda <- st_read(system.file("extdata", "line_sta.shp", package = "ldtr"))
  
  expect_error(valid_studyarea(stda))
  
  stda <- st_read(system.file("extdata", "point_sta.shp", package = "ldtr"))
  
  expect_error(valid_studyarea(stda))
  
  
  stda <- st_read(system.file("extdata", "line_sta.gpkg", package = "ldtr"))
  
  expect_error(valid_studyarea(stda))
  
  stda <- st_read(system.file("extdata", "point_sta.gpkg", package = "ldtr"))
  
  expect_error(valid_studyarea(stda))
})