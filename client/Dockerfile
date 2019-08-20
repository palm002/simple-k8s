FROM node:alpine as builder
WORKDIR '/app'
COPY ./package.json .
RUN npm install
COPY . .
RUN npm run build
# npm run build will output /app/build folder

FROM nginx
EXPOSE 3000
# copy over my config file, overwrite the one in nginx container
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
# copy build output to html folder as per nginx docs on docker hub
COPY --from=builder /app/build /usr/share/nginx/html