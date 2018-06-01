FROM node:9.11.1-alpine as builder
RUN mkdir /src
WORKDIR /src
RUN npm update
FROM nginx:1.13-alpine
COPY --from=builder /src/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
