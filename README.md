# ldtR

[![R-CMD-check](https://github.com/luisgpaixao/ldtr/actions/workflows/R-CMD-check.yml/badge.svg)](https://github.com/luisgpaixao/ldtr/actions/workflows/R-CMD-check.yml)

ldtR is an R package that implements the Landscape Dynamic Typology (LDT) method developed by Machado et al. 2018. The main purpose is to assess land use / land cover (LUCL) changes between several moments, considering the composition and configuration of a binary landscape.


## Installation

You can install the last version of ldtR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("luisgpaixao/ldtr")
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
                5000, 10000, T, T, T, 'Output.shp')

writeLDT(obj)

```
This example computes the LDT method between two land cover moments, considering patches larger than 5000 square meters and using 10000 x 10000 meters quadrats as analytical units. It also calculates spatial shift, perforation and forecast.
Check the related bibliography for detailed information on the Types of Dynamics.

**Requirements and preliminary steps**

1. The study area shapefile's coordinate reference system (CRS) should be projected (not geographic) and the coordinates displayed in meters.
2. LDT uses binary landscapes and thus the input land cover shapefiles must contain only one category with the polygons of interest.

References:

Machado, R., Godinho, S., Pirnat, J., Neves, N., Santos, P., 2018. Assessment of landscape composition and configuration via spatial metrics combination: conceptual framework proposal and method improvement. Landsc. Res. 43, 652–664. https://doi.org/10.1080/01426397.2017.1336757

Related references:

Machado, R., Bayot, R., Godinho, S., Pirnat, J., Santos, P., & de Sousa-Neves, N. (2020). LDTtool: A toolbox to assess landscape dynamics. Environmental Modelling and Software, 133(August). https://doi.org/10.1016/j.envsoft.2020.104847

Paixão, L., & Machado, R. (2023). LDT4QGIS: An open-source tool to enhance landscape analysis. Ecological Informatics, 75, 102073. https://doi.org/10.1016/j.ecoinf.2023.102073


## Citation

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.16749262.svg)](https://doi.org/10.5281/zenodo.16749262)

If you use this software, please cite it as:

**Paixão, L. G.** (2025). *ldtr* (v2.0.0). Zenodo. https://doi.org/10.5281/zenodo.16749262
