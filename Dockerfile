FROM ubuntu:20.04 as app
LABEL Phuong Le <al35@sanger.ac.uk>
WORKDIR /opt

# install basic dependencies, cleanup apt garbage.
RUN apt-get update && apt-get install -y -qq \
        python3  \ 
        wget \
    && apt-get autoclean && rm -rf /var/lib/apt/lists/*

# install art 
RUN wget https://www.niehs.nih.gov/research/resources/assets/docs/artbinmountrainier2016.06.05linux64.tgz \
    && tar -zxvf artbinmountrainier2016.06.05linux64.tgz \
    && cd art_bin_MountRainier \
    && mv art_illumina /usr/local/bin \
    && cd .. \
    && rm artbinmountrainier2016.06.05linux64.tgz \
    && rm -r art_bin_MountRainier 

# testing that art_illumina is installed
# Run art_illumina --help 