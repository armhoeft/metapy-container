FROM python:3.9

LABEL title="metapy-container" \
      description="MeTA + metapy runtime environment in a neat package" \
      authors="Andrew Hoeft (arhoeft2@illinois.edu)" \
      license="MIT" \
      version="0.2.13" \
      revision="1" \
      created="2020-12-13T21:00:00-04:00"

# Install dependencies
RUN apt-get update
RUN apt-get install -y g++-7 gcc-7 cmake libicu-dev git libjemalloc-dev zlib1g-dev doxygen python-dev
RUN rm /usr/bin/g++ && ln -s /usr/bin/g++-7 /usr/bin/g++
RUN rm /usr/bin/gcc && ln -s /usr/bin/gcc-7 /usr/bin/gcc

# Download repository and submodules
# Modify error in CMakeLists file becase resource relocated on web
RUN git clone https://github.com/meta-toolkit/metapy.git && \
    cd metapy && \
    git submodule update --init --recursive && \
    sed -i 's/http:\/\/download.icu-project.org\/files\/icu4c\/61.1\/icu4c-61_1-src.tgz/https:\/\/github.com\/unicode-org\/icu\/releases\/download\/release-61-1\/icu4c-61_1-src.tgz/g' /metapy/deps/meta/CMakeLists.txt

# Build and install metapy
RUN cd metapy && python setup.py install

# Cleanup
RUN rm -rf /metapy
RUN apt-get remove -y g++-7 gcc-7 cmake libicu-dev git libjemalloc-dev zlib1g-dev doxygen python-dev
RUN rm /usr/bin/g++ && ln -s /usr/bin/g++-8 /usr/bin/g++
RUN rm /usr/bin/gcc && ln -s /usr/bin/gcc-8 /usr/bin/gcc
RUN rm -rf /var/lib/apt/lists/

# Configure runtime environment
RUN echo "export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2" >> /root/.bashrc
ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2

# Set default start command
CMD python
