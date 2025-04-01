# ldtR
ldtR is an R package that implements the Landscape Dynamic Typology (LDT) method developed by Machado et al. 2018. The main purpose is to assess land use / land cover (LUCL) changes between several moments, considering the composition and configuration of a binary landscape.


## Installation

You can install the last version of ldtR from
[GitLab](https://gitlab.com/) with:

``` r
# install.packages("devtools")
devtools::install_gitlab("lgplgp/ldtr")
```

## Usage

The code below exemplifies the loading and usage of the package.

``` r
library(ldtr)

setwd("path/to/dir")

# refer to function documentation for more details
obj <- createLDT(T, 2, 'StudyArea.shp',
                c('Moment1.shp',
                  'Moment1.shp'),
                5000, 10000, T, T, 'Output.shp')

writeLDT(obj)

```
This example performs the LDT method between 2 land cover moments, considering squares with a side of 10000 meters as analytical unit and patches bigger then 5000 square meters.
It also considers perforation and forecast.

**Requirements and preliminary steps**

1. The study area shapefile's coordinate reference system (CRS) should be projected (not geographic) and the coordinates displayed in meters.
2. LDT uses binary landscapes and thus the input land cover shapefiles must contain only one category with the polygons of interest.

References:

Forman, R.T.T., 1995. Land mosaics - The ecology of landscapes and regions. Cambridge University Press, Cambridge.

Machado, R., Godinho, S., Pirnat, J., Neves, N., Santos, P., 2018. Assessment of landscape composition and configuration via spatial metrics combination: conceptual framework proposal and method improvement. Landsc. Res. 43, 652–664. https://doi.org/10.1080/01426397.2017.1336757

Related references:
Machado, R., Bayot, R., Godinho, S., Pirnat, J., Santos, P., & de Sousa-Neves, N. (2020). LDTtool: A toolbox to assess landscape dynamics. Environmental Modelling and Software, 133(August). https://doi.org/10.1016/j.envsoft.2020.104847