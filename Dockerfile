# Étape de build
FROM node:18 as build-stage
WORKDIR /app
RUN echo "Build Docker en cours..." && ls -la
COPY . .
RUN npm install
RUN npm run build

# Étape de prod
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
