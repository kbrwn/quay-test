FROM quay.io/kbrwn/ubuntu
MAINTAINER Jessica Frazelle <jess@docker.com>

RUN apt-get update && apt-get install -y \
	stress \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/* && echo "hello"

ENTRYPOINT [ "stress" ]
