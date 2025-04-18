test_that("tod A no change and A1 shift", {
  
  stda <- system.file("extdata", "single_poly.shp", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.shp", package = "ldtr")
  m2 <- system.file("extdata", "Single_m2.shp", package = "ldtr")
  outp_dir <- system.file("extdata", package = "ldtr")
  outp_shp <- file.path(outp_dir, 'outExample.shp')
  
  obj <- createLDT(F, 2, stda, c(m1, m2), 0, 0, F, F, outp_shp)
  outp <- writeLDT(obj)
  
  expect_true(outp$ToD_12 == "A - No change")
  
  file.remove(list.files(outp_dir, pattern = 'outExample', full.names = T, recursive = F))
  
  m2 <- system.file("extdata", "Single_m1_shift.shp", package = "ldtr")
  outp_dir <- system.file("extdata", package = "ldtr")
  outp_shp <- file.path(outp_dir, 'outExample.shp')
  
  obj <- createLDT(F, 2, stda, c(m1, m2), 0, 0, F, F, outp_shp)
  outp <- writeLDT(obj)
  
  expect_true(outp$ToD_12 == "A1 - Spatial shift")
  
  file.remove(list.files(outp_dir, pattern = 'outExample', full.names = T, recursive = F))
  
})

test_that("tod B fragmentation", {
  
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

test_that("tod C aggregation", {
  
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

test_that("tod D gain", {
  
  stda <- system.file("extdata", "single_poly.shp", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.shp", package = "ldtr")
  m2 <- system.file("extdata", "Single_m1_gain.shp", package = "ldtr")
  outp_dir <- system.file("extdata", package = "ldtr")
  outp_shp <- file.path(outp_dir, 'outExample.shp')
  
  obj <- createLDT(F, 2, stda, c(m1, m2), 0, 0, F, F, outp_shp)
  outp <- writeLDT(obj)
  
  expect_true(outp$ToD_12 == "D - Gain")
  
  file.remove(list.files(outp_dir, pattern = 'outExample', full.names = T, recursive = F))
  
})

test_that("tod E loss", {
  
  stda <- system.file("extdata", "single_poly.shp", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.shp", package = "ldtr")
  m2 <- system.file("extdata", "Single_m1_loss.shp", package = "ldtr")
  outp_dir <- system.file("extdata", package = "ldtr")
  outp_shp <- file.path(outp_dir, 'outExample.shp')
  
  obj <- createLDT(F, 2, stda, c(m1, m2), 0, 0, F, F, outp_shp)
  outp <- writeLDT(obj)
  
  expect_true(outp$ToD_12 == "E - Loss")
  
  file.remove(list.files(outp_dir, pattern = 'outExample', full.names = T, recursive = F))
  
})

test_that("tod E1 perf", {
  
  stda <- system.file("extdata", "single_poly.shp", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.shp", package = "ldtr")
  m2 <- system.file("extdata", "Single_m1_perf.shp", package = "ldtr")
  outp_dir <- system.file("extdata", package = "ldtr")
  outp_shp <- file.path(outp_dir, 'outExample.shp')
  
  obj <- createLDT(F, 2, stda, c(m1, m2), 0, 0, T, F, outp_shp)
  outp <- writeLDT(obj)
  
  expect_true(outp$ToD_12 == "E1 - Perforation")
  
  file.remove(list.files(outp_dir, pattern = 'outExample', full.names = T, recursive = F))
  
})

test_that("tod F increment and H decrement", {
  
  stda <- system.file("extdata", "single_poly.shp", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1.shp", package = "ldtr")
  m2 <- system.file("extdata", "Single_m1_inc.shp", package = "ldtr")
  outp_dir <- system.file("extdata", package = "ldtr")
  outp_shp <- file.path(outp_dir, 'outExample.shp')
  
  obj <- createLDT(F, 2, stda, c(m1, m2), 0, 0, F, F, outp_shp)
  outp <- writeLDT(obj)
  
  expect_true(outp$ToD_12 == "F - NP increment by gain")
  
  file.remove(list.files(outp_dir, pattern = 'outExample', full.names = T, recursive = F))
  
  
  obj <- createLDT(F, 2, stda, c(m2, m1), 0, 0, F, F, outp_shp)
  outp <- writeLDT(obj)
  
  expect_true(outp$ToD_12 == "H - NP decrement by loss")
  
  file.remove(list.files(outp_dir, pattern = 'outExample', full.names = T, recursive = F))
  
})

test_that("tod G aggreg and I frag", {
  
  stda <- system.file("extdata", "single_poly.shp", package = "ldtr")
  m1 <- system.file("extdata", "Single_m1_inc.shp", package = "ldtr")
  m2 <- system.file("extdata", "Single_m1_agg.shp", package = "ldtr")
  outp_dir <- system.file("extdata", package = "ldtr")
  outp_shp <- file.path(outp_dir, 'outExample.shp')
  
  obj <- createLDT(F, 2, stda, c(m1, m2), 0, 0, F, F, outp_shp)
  outp <- writeLDT(obj)
  
  expect_true(outp$ToD_12 == "G - Aggregation by gain")
  
  file.remove(list.files(outp_dir, pattern = 'outExample', full.names = T, recursive = F))
  
  
  obj <- createLDT(F, 2, stda, c(m2, m1), 0, 0, F, F, outp_shp)
  outp <- writeLDT(obj)
  
  expect_true(outp$ToD_12 == "I - Fragmentation by loss")
  
  file.remove(list.files(outp_dir, pattern = 'outExample', full.names = T, recursive = F))
  
})