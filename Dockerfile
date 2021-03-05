FROM node:15.11.0-alpine3.13 as build-stage
WORKDIR /srv
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:1.19.7-alpine as run-stage
COPY --from=build-stage /srv/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
