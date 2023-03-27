FROM ubuntu:20.04 as app
LABEL Phuong Le <al35@sanger.ac.uk>
WORKDIR /opt

# install basic dependencies, cleanup apt garbage.
RUN apt-get update && apt-get install -y -qq \
        python3  \ 
        wget \
    && apt-get autoclean && rm -rf /var/lib/apt/lists/*

# install art
WORKDIR /opt/art
RUN wget -O - --progress=dot:giga https://www.niehs.nih.gov/research/resources/assets/docs/artbinmountrainier2016.06.05linux64.tgz | \
    tar -zx --strip-components=2

ENV PATH="/opt/art:${PATH}"

# testing that art_illumina is installed
CMD art_illumina --help 