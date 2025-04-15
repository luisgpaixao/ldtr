---
title: 'LDTR – An R package for landscape dynamics assessment'
tags:
  - R
  - landscape
  - dynamics
authors:
  - name: Luís Paixão
    orcid: 0000-0002-3070-9577
    affiliation: 1
  - name: Rui Machado
    orcid: 0000-0002-4345-6636
    affiliation: 2
affiliations:
 - name: Agroinsider Lda., PITE, R. Circular Norte, NERE, Sala 18, 7005-841 Évora, Portugal
   index: 1
 - name: MED – Mediterranean Institute for Agriculture, Environment and Development & CHANGE –Global Change and Sustainability Institute, Institute for Advanced Studies and Research, Universidade de Évora, Pólo da Mitra, Évora 7006-554, Portugal
   index: 2
date: 10 April 2025
bibliography: paper.bib

# Summary

LDTR is a R package that provides relevant functions for landscape dynamics analysis, using land cover ESRI shapefiles (*.shp), a widely used vector data format, which stores the location, shape and attributes of geographic features. LDTR differs from most software dedicated to landscape metrics calculation by using combination of metrics to identify land transformation processes. LDTR is based on the Landscape Dynamics Typology method, which has been implemented in several studies via other tools for ArcGIS and QGIS, and becomes now available in R, the sophisticated and versatile open-source computing environment, frequently used for geostatistical analysis.

Its user-friendliness is a strength, together with the straightforward and simple to interpret outputs, that can represent a final product or feed further analytical processes, depending on the study context. The applications are manifold including natural resources management, regional planning, urban expansion, biodiversity conservation, ecosystems services assessment, or other topics in which land cover changes and patterns are relevant.

# Statement of need

Landscapes result from the dynamic interplay of natural variables and anthropic activities. Due to their ecosystemic dimension, landscapes are often regarded as proper planning and management units, and are vastly studied for conservation purposes. Landscape patterns influence ecological processes [@turner1989; @uuemaa2013] and therefore it is essential to describe and quantify landscape characteristics in order to understand ecosystem services’ sustainability, and for the overall landscape environmental assessment [@lausch2015].

Landscape Dynamics Typology (LDT) [@machado2018] is an expedite method that uses combinations of landscape metrics to define types of dynamics (ToD), which are then used to classify analytical units (\autoref{fig:ldt_types}). LDT adds value to assessments related to LULC changes in topics, such as ecosystem services, biodiversity conservation, ecological restoration, invasive species control, etc. (see the “applications” section).

Up until this moment, there were two tools to automate the procedure: LDTtool [@machado2020], an ArcGIS [@esri2016] toolbox, and LDT4QGIS [@paixao2023], a solution for QGIS [@qgis2022] users. This paper introduces the new LDTR, a package to implement LDT in R [@r2022], which represents exposure to a wider audience of users not only able to increase the number of use-cases but also to adapt the source-code to fit their needs, develop functions and improve the overall performance of the package.
![Landscape Dynamic Types. ∆A – area variation; ∆NP – number of patches variation.\label{fig:ldt_types}](ldt_types.png)
