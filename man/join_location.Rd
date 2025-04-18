% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/join_location.R
\name{join_location}
\alias{join_location}
\title{Update symmetrical difference or perforation values}
\usage{
join_location(in_layer, join_layer, join_field)
}
\arguments{
\item{in_layer}{an sf Simple feature collection, representing the study area features.}

\item{join_layer}{an sf Simple feature collection, representing symmetrical difference or perforation features.}

\item{join_field}{a character representing the field to be updated in the study area sf Simple feature collection.}
}
\value{
an sf Simple feature collection, representing the study area features.
}
\description{
Updates symmetrical difference or perforation values in the study area features.
}
