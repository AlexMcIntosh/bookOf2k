FROM node:10.15.1 AS builder

WORKDIR /app
COPY package.json .
RUN npm install

COPY . .
RUN npm run build --prod

FROM nginx:alpine

COPY --from=builder /app/dist/bookOf2k /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf