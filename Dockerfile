FROM ubuntu:17.04

WORKDIR /home

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y r-base && \
	apt-get install -y vim && \
	apt-get install -y aptitude libcurl4-openssl-dev libxml2-dev

RUN Rscript -e 'install.packages("RCurl", repos = "http://cran.rstudio.com/")'
RUN Rscript -e 'source("https://bioconductor.org/biocLite.R"); biocLite("BSgenome"); biocLite("BSgenome.Hsapiens.UCSC.hg19"); biocLite("GenomeInfoDb")'
RUN Rscript -e 'install.packages("reshape2", repos = "http://cran.rstudio.com/")'
RUN Rscript -e 'install.packages("optparse", repos = "http://cran.rstudio.com/")'
RUN Rscript -e 'install.packages("deconstructSigs", repos = "http://cran.rstudio.com/")'

COPY . /home/
