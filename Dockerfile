FROM mhart/alpine-node:5.6.0

# Install required dependencies (Alpine Linux packages)
RUN apk update && \
 apk add --no-cache \
   g++ \
   gcc \
   git \
   libev-dev \
   libevent-dev \
   libuv-dev \
   make \
   openssl-dev \
   perl \
   python

# Switch to directory for external dependencies (installed from source)
WORKDIR /external

# Install (global) NPM packages/dependencies
RUN npm install -g \
 node-gyp \
 pm2

# Switch to directory with sources
WORKDIR /src

# Copy package json and install dependencies
COPY package.json .

# Install (local) NPM and Bower packages/dependencies
RUN npm install

# Copy required stuff
ADD . .

RUN npm run build # Build (using webpack) assets

# Expose SERVER ports
EXPOSE 3000
EXPOSE 55555

# Specify default CMD
CMD pm2 start --no-daemon npm --no-automation -- run $RUN_CMD
