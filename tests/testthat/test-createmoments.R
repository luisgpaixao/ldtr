test_that("write LDT", {

  stda <- system.file("extdata", "mun_portel_etrs.shp", package = "ldtr")
  m1 <- system.file("extdata", "for_2000.shp", package = "ldtr")
  m2 <- system.file("extdata", "for_2018.shp", package = "ldtr")
  outp_dir <- system.file("extdata", package = "ldtr")
  outp_shp <- file.path(outp_dir, 'outExample.shp')

  obj <- createLDT(T, 2, stda, c(m1, m2), 3000, 3000, F, F, outp_shp)
  outp <- writeLDT(obj)

  expect_type(st_read(outp_shp), "list")

  file.remove(list.files(outp_dir, pattern = 'outExample', full.names = T, recursive = F))

})

test_that("create moments different crs", {

  stda <- st_read(system.file("extdata", "mun_portel_etrs.shp", package = "ldtr"))
  m1 <- system.file("extdata", "for_2000.shp", package = "ldtr")
  m2 <- system.file("extdata", "for_2018.shp", package = "ldtr")

  expect_message(create_moments(c(m1, m2), stda))

})
