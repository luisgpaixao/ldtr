% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/update_sta_symm.R
\name{update_sta_symm}
\alias{update_sta_symm}
\title{Update symmetrical difference fields}
\usage{
update_sta_symm(sta, symdif_perf)
}
\arguments{
\item{sta}{an sf Simple feature collection representing the study area for analysis.}

\item{symdif_perf}{a list of sf Simple feature collections representing the symmetrical differences between all moments for analysis.}
}
\value{
an sf Simple feature collection representing the study area for analysis, updated with symmetrical difference fields.
}
\description{
Updates symmetrical differences fields on study area's Simple feature collection.
}
