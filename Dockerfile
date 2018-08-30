FROM nginx:latest
RUN mkdir /src
WORKDIR /src
RUN npm update
FROM nginx:1.13-alpine
COPY --from=builder /src /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
