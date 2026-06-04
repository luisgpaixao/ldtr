test_that("write LDT", {

  stda <- system.file("extdata", "mun_portel_etrs.shp", package = "ldtr")
  m1 <- system.file("extdata", "for_2000.shp", package = "ldtr")
  m2 <- system.file("extdata", "for_2018.shp", package = "ldtr")
  outp_dir <- tempdir()
  out_layername <- 'outExample'
  outp_shp <- file.path(outp_dir, paste0(out_layername, '.gpkg'))

  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=3000, squares=3000, 
            analysis_squares=T, spatialshift=T, perforation=F, 
            forecast=F)
  outp <- writeLDT(obj, saveoutput = T, layername = out_layername, outfolder = outp_dir)

  expect_type(st_read(outp_shp), "list")

  file.remove(list.files(outp_dir, pattern = 'outExample', full.names = T, recursive = F))
  
  
  stda <- system.file("extdata", "mun_portel_etrs.gpkg", package = "ldtr")
  m1 <- system.file("extdata", "for_2000.gpkg", package = "ldtr")
  m2 <- system.file("extdata", "for_2018.gpkg", package = "ldtr")
  outp_dir <- tempdir()
  out_layername <- 'outExample'
  outp_shp <- file.path(outp_dir, paste0(out_layername, '.gpkg'))
  
  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=3000, squares=3000, 
                   analysis_squares=T, spatialshift=T, perforation=F, 
                   forecast=F)
  outp <- writeLDT(obj, saveoutput = T, layername = out_layername, outfolder = outp_dir)
  
  expect_type(st_read(outp_shp), "list")
  
  file.remove(list.files(outp_dir, pattern = 'outExample', full.names = T, recursive = F))

})

test_that("create moments different crs", {

  stda <- st_read(system.file("extdata", "mun_portel_etrs.shp", package = "ldtr"))
  m1 <- system.file("extdata", "for_2000.shp", package = "ldtr")
  m2 <- system.file("extdata", "for_2018.shp", package = "ldtr")

  expect_message(create_moments(list(st_read(m1), st_read(m2)), stda))
  
  
  stda <- st_read(system.file("extdata", "mun_portel_etrs.gpkg", package = "ldtr"))
  m1 <- system.file("extdata", "for_2000.gpkg", package = "ldtr")
  m2 <- system.file("extdata", "for_2018.gpkg", package = "ldtr")
  
  expect_message(create_moments(list(st_read(m1), st_read(m2)), stda))

})

test_that("check all empty moments", {

  stda <- system.file("extdata", "mun_portel_etrs.shp", package = "ldtr")
  m1 <- system.file("extdata", "emptysta.shp", package = "ldtr")
  m2 <- system.file("extdata", "emptysta.shp", package = "ldtr")
  outp_dir <- tempdir()
  out_layername <- 'outExample'
  outp_shp <- file.path(outp_dir, paste0(out_layername, '.gpkg'))

  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=3000, squares=3000, 
                   analysis_squares=T, spatialshift=T, perforation=F, 
                   forecast=F)
  
  outp <- writeLDT(obj, saveoutput = T, layername = out_layername, outfolder = outp_dir)

  expect_type(st_read(outp_shp), "list")

  file.remove(list.files(outp_dir, pattern = 'outExample', full.names = T, recursive = F))
  
  
  stda <- system.file("extdata", "mun_portel_etrs.gpkg", package = "ldtr")
  m1 <- system.file("extdata", "emptysta.gpkg", package = "ldtr")
  m2 <- system.file("extdata", "emptysta.gpkg", package = "ldtr")
  outp_dir <- tempdir()
  out_layername <- 'outExample'
  outp_shp <- file.path(outp_dir, paste0(out_layername, '.gpkg'))
  
  obj <- createLDT(st_read(stda), list(st_read(m1), st_read(m2)), patches=3000, squares=3000, 
                   analysis_squares=T, spatialshift=T, perforation=F, 
                   forecast=F)
  
  outp <- writeLDT(obj, saveoutput = T, layername = out_layername, outfolder = outp_dir)
  
  expect_type(st_read(outp_shp), "list")
  
  file.remove(list.files(outp_dir, pattern = 'outExample', full.names = T, recursive = F))

})
