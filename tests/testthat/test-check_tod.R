test_that("tod A no change and A1 shift", {
  
  stda <- system.file("extdata", "single_poly.shp", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.shp", package = "ldtr")
  m2 <- system.file("extdata", "Single_m2.shp", package = "ldtr")
  
  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=0, squares=0, 
                        analysis_squares=F, spatialshift=T, perforation=F, 
                        forecast=F)
  outp <- writeLDT(obj)
  
  expect_true(outp$ldt_output$ToD_12 == "A - No change")
  
  
  m2 <- system.file("extdata", "Single_m1_shift.shp", package = "ldtr")
  
  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=0, squares=0, 
                   analysis_squares=F, spatialshift=T, perforation=F, 
                   forecast=F)
  
  outp <- writeLDT(obj)
  
  expect_true(outp$ldt_output$ToD_12 == "A1 - Spatial shift")
  
  
  stda <- system.file("extdata", "single_poly.gpkg", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.gpkg", package = "ldtr")
  m2 <- system.file("extdata", "Single_m2.gpkg", package = "ldtr")
  
  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=0, squares=0, 
                   analysis_squares=F, spatialshift=T, perforation=F, 
                   forecast=F)
  outp <- writeLDT(obj)
  
  expect_true(outp$ldt_output$ToD_12 == "A - No change")
  
  
  m2 <- system.file("extdata", "Single_m1_shift.gpkg", package = "ldtr")
  
  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=0, squares=0, 
                   analysis_squares=F, spatialshift=T, perforation=F, 
                   forecast=F)
  
  outp <- writeLDT(obj)
  
  expect_true(outp$ldt_output$ToD_12 == "A1 - Spatial shift")
})

test_that("tod B fragmentation", {
  
  stda <- system.file("extdata", "single_poly.shp", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.shp", package = "ldtr")
  m2 <- system.file("extdata", "Single_m2_frag.shp", package = "ldtr")
  
  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=0, squares=0, 
                   analysis_squares=F, spatialshift=T, perforation=F, 
                   forecast=F)
  outp <- writeLDT(obj)
  
  expect_true(outp$ldt_output$ToD_12 == "B - Fragmentation per se")
  
  
  stda <- system.file("extdata", "single_poly.gpkg", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.gpkg", package = "ldtr")
  m2 <- system.file("extdata", "Single_m2_frag.gpkg", package = "ldtr")
  
  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=0, squares=0, 
                   analysis_squares=F, spatialshift=T, perforation=F, 
                   forecast=F)
  outp <- writeLDT(obj)
  
  expect_true(outp$ldt_output$ToD_12 == "B - Fragmentation per se")
  
})

test_that("tod C aggregation", {
  
  stda <- system.file("extdata", "single_poly.shp", package = "ldtr")
  m1 <- system.file("extdata", "Single_m2_frag.shp", package = "ldtr")
  m2 <- system.file("extdata", "Single_m1.shp", package = "ldtr")
  
  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=0, squares=0, 
                   analysis_squares=F, spatialshift=T, perforation=F, 
                   forecast=F)
  
  outp <- writeLDT(obj)
  
  expect_true(outp$ldt_output$ToD_12 == "C - Aggregation per se")

  
  stda <- system.file("extdata", "single_poly.gpkg", package = "ldtr")
  m1 <- system.file("extdata", "Single_m2_frag.gpkg", package = "ldtr")
  m2 <- system.file("extdata", "Single_m1.gpkg", package = "ldtr")
  
  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=0, squares=0, 
                   analysis_squares=F, spatialshift=T, perforation=F, 
                   forecast=F)
  
  outp <- writeLDT(obj)
  
  expect_true(outp$ldt_output$ToD_12 == "C - Aggregation per se")
  
})

test_that("tod D gain", {
  
  stda <- system.file("extdata", "single_poly.shp", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.shp", package = "ldtr")
  m2 <- system.file("extdata", "Single_m1_gain.shp", package = "ldtr")
  
  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=0, squares=0, 
                   analysis_squares=F, spatialshift=T, perforation=F, 
                   forecast=F)
  outp <- writeLDT(obj)
  
  expect_true(outp$ldt_output$ToD_12 == "D - Gain")
  
  
  stda <- system.file("extdata", "single_poly.gpkg", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.gpkg", package = "ldtr")
  m2 <- system.file("extdata", "Single_m1_gain.gpkg", package = "ldtr")
  
  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=0, squares=0, 
                   analysis_squares=F, spatialshift=T, perforation=F, 
                   forecast=F)
  outp <- writeLDT(obj)
  
  expect_true(outp$ldt_output$ToD_12 == "D - Gain")

  
})

test_that("tod E loss", {
  
  stda <- system.file("extdata", "single_poly.shp", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.shp", package = "ldtr")
  m2 <- system.file("extdata", "Single_m1_loss.shp", package = "ldtr")
  
  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=0, squares=0, 
                   analysis_squares=F, spatialshift=T, perforation=F, 
                   forecast=F)
  outp <- writeLDT(obj)
  
  expect_true(outp$ldt_output$ToD_12 == "E - Loss")

  
  stda <- system.file("extdata", "single_poly.gpkg", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.gpkg", package = "ldtr")
  m2 <- system.file("extdata", "Single_m1_loss.gpkg", package = "ldtr")
  
  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=0, squares=0, 
                   analysis_squares=F, spatialshift=T, perforation=F, 
                   forecast=F)
  outp <- writeLDT(obj)
  
  expect_true(outp$ldt_output$ToD_12 == "E - Loss")
  
})

test_that("tod E1 perf", {
  
  stda <- system.file("extdata", "single_poly.shp", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.shp", package = "ldtr")
  m2 <- system.file("extdata", "Single_m1_perf.shp", package = "ldtr")
  
  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=0, squares=0, 
                   analysis_squares=F, spatialshift=T, perforation=T, 
                   forecast=F)
  outp <- writeLDT(obj)
  
  expect_true(outp$ldt_output$ToD_12 == "E1 - Perforation")
  
  
  stda <- system.file("extdata", "single_poly.gpkg", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.gpkg", package = "ldtr")
  m2 <- system.file("extdata", "Single_m1_perf.gpkg", package = "ldtr")
  
  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=0, squares=0, 
                   analysis_squares=F, spatialshift=T, perforation=T, 
                   forecast=F)
  outp <- writeLDT(obj)
  
  expect_true(outp$ldt_output$ToD_12 == "E1 - Perforation")
  
})

test_that("tod F increment and H decrement", {
  
  stda <- system.file("extdata", "single_poly.shp", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.shp", package = "ldtr")
  m2 <- system.file("extdata", "Single_m1_inc.shp", package = "ldtr")

  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=0, squares=0, 
                   analysis_squares=F, spatialshift=T, perforation=F, 
                   forecast=F)
  outp <- writeLDT(obj)
  
  expect_true(outp$ldt_output$ToD_12 == "F - NP increment by gain")
  
  
  obj <- createLDT(st_read(stda), list(st_read(m2), st_read(m1)), patches=0, squares=0, 
                   analysis_squares=F, spatialshift=T, perforation=F, 
                   forecast=F)
  outp <- writeLDT(obj)
  
  expect_true(outp$ldt_output$ToD_12 == "H - NP decrement by loss")
  
  
  stda <- system.file("extdata", "single_poly.gpkg", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.gpkg", package = "ldtr")
  m2 <- system.file("extdata", "Single_m1_inc.gpkg", package = "ldtr")
  
  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=0, squares=0, 
                   analysis_squares=F, spatialshift=T, perforation=F, 
                   forecast=F)
  outp <- writeLDT(obj)
  
  expect_true(outp$ldt_output$ToD_12 == "F - NP increment by gain")
  

  obj <- createLDT(st_read(stda), list(st_read(m2), st_read(m1)), patches=0, squares=0, 
                   analysis_squares=F, spatialshift=T, perforation=F, 
                   forecast=F)
  outp <- writeLDT(obj)
  
  expect_true(outp$ldt_output$ToD_12 == "H - NP decrement by loss")

  
})

test_that("tod G aggreg and I frag", {
  
  stda <- system.file("extdata", "single_poly.shp", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1_inc.shp", package = "ldtr")
  m2 <- system.file("extdata", "Single_m1_agg.shp", package = "ldtr")

  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=0, squares=0, 
                   analysis_squares=F, spatialshift=T, perforation=F, 
                   forecast=F)
  outp <- writeLDT(obj)
  
  expect_true(outp$ldt_output$ToD_12 == "G - Aggregation by gain")


  obj <- createLDT(st_read(stda), list(st_read(m2), st_read(m1)), patches=0, squares=0, 
                   analysis_squares=F, spatialshift=T, perforation=F, 
                   forecast=F)
  outp <- writeLDT(obj)
  
  expect_true(outp$ldt_output$ToD_12 == "I - Fragmentation by loss")

  
})