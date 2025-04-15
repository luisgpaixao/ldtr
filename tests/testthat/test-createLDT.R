test_that("create LDT object ok", {

  obj <- createLDT(T, 2, 'sta.shp', c('m1.shp', 'm2.shp'), 10, 10, T, T, 'out.shp')

  expect_type(obj, "S4")

})

test_that("error moments less than 2", {

  expect_error(createLDT(T, 1, 'sta.shp', c('m1.shp', 'm2.shp'), 10, 10, T, T, 'out.shp'))
  expect_error(createLDT(T, 2, 'sta.shp', c('m1.shp'), 10, 10, T, T, 'out.shp'))

})

test_that("error not matching numbers", {

  testthat::expect_error(createLDT(T, 2, 'sta.shp', c('m1.shp', 'm2.shp', 'm3.shp'), 10, 10, T, T, 'out.shp'))
  testthat::expect_error(createLDT(T, 3, 'sta.shp', c('m1.shp', 'm2.shp'), 10, 10, T, T, 'out.shp'))

})
