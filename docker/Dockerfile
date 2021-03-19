FROM johanngb/rep-int:2021v1
COPY --chown=rep:rep . /home/rep
RUN su - rep -c 'cd /home/rep/docker/build && make'
RUN su - rep -c 'cd /home/rep && make'
