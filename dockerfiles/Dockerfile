FROM debian:wheezy
RUN pwd
RUN cd ..
RUN pwd 
COPY /test-repo/test.sh .
CMD ["/bin/sh", "-x", "test.sh"]
