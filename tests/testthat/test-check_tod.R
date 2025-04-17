test_that("tod no change", {
  
  stda <- system.file("extdata", "single_poly.shp", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.shp", package = "ldtr")
  m2 <- system.file("extdata", "Single_m2.shp", package = "ldtr")
  outp_dir <- system.file("extdata", package = "ldtr")
  outp_shp <- file.path(outp_dir, 'outExample.shp')
  
  obj <- createLDT(F, 2, stda, c(m1, m2), 0, 0, F, F, outp_shp)
  outp <- writeLDT(obj)
  
  expect_true(outp$ToD_12 == "A - No change")
  
  file.remove(list.files(outp_dir, pattern = 'outExample', full.names = T, recursive = F))
  
})

test_that("tod fragmentation", {
  
  stda <- system.file("extdata", "single_poly.shp", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.shp", package = "ldtr")
  m2 <- system.file("extdata", "Single_m2_frag.shp", package = "ldtr")
  outp_dir <- system.file("extdata", package = "ldtr")
  outp_shp <- file.path(outp_dir, 'outExample.shp')
  
  obj <- createLDT(F, 2, stda, c(m1, m2), 0, 0, F, F, outp_shp)
  outp <- writeLDT(obj)
  
  expect_true(outp$ToD_12 == "B - Fragmentation per se")
  
  file.remove(list.files(outp_dir, pattern = 'outExample', full.names = T, recursive = F))
  
})

test_that("tod aggregation", {
  
  stda <- system.file("extdata", "single_poly.shp", package = "ldtr")
  m1 <- system.file("extdata", "Single_m2_frag.shp", package = "ldtr")
  m2 <- system.file("extdata", "Single_m1.shp", package = "ldtr")
  outp_dir <- system.file("extdata", package = "ldtr")
  outp_shp <- file.path(outp_dir, 'outExample.shp')
  
  obj <- createLDT(F, 2, stda, c(m1, m2), 0, 0, F, F, outp_shp)
  outp <- writeLDT(obj)
  
  expect_true(outp$ToD_12 == "C - Aggregation per se")
  
  file.remove(list.files(outp_dir, pattern = 'outExample', full.names = T, recursive = F))
  
})
