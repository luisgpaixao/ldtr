test_that("create LDT object ok", {

  stda <- system.file("extdata", "single_poly.shp", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.shp", package = "ldtr")
  m2 <- system.file("extdata", "Single_m2.shp", package = "ldtr")
  
  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=10, squares=10, 
                   analysis_squares=T, spatialshift=T, perforation=T, 
                   forecast=T)

  expect_type(obj, "S4")
  
  
  stda <- system.file("extdata", "single_poly.gpkg", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.gpkg", package = "ldtr")
  m2 <- system.file("extdata", "Single_m2.gpkg", package = "ldtr")
  
  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=10, squares=10, 
                   analysis_squares=T, spatialshift=T, perforation=T, 
                   forecast=T)
  
  expect_type(obj, "S4")

})

test_that("error moments less than 2", {

  stda <- system.file("extdata", "single_poly.shp", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.shp", package = "ldtr")
  m2 <- system.file("extdata", "Single_m2.shp", package = "ldtr")
  
  expect_error(createLDT(st_read(stda), list(st_read(m1)), patches=10, squares=10, 
                         analysis_squares=T, spatialshift=T, perforation=T, 
                         forecast=T))
  
  
  stda <- system.file("extdata", "single_poly.gpkg", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.gpkg", package = "ldtr")
  m2 <- system.file("extdata", "Single_m2.gpkg", package = "ldtr")
  
  expect_error(createLDT(st_read(stda), list(st_read(m1)), patches=10, squares=10, 
                         analysis_squares=T, spatialshift=T, perforation=T, 
                         forecast=T))

})
