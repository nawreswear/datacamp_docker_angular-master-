### STAGE 1: Build service comme alias ###
FROM node:16-alpine AS build
WORKDIR /usr/src/app

# Copier les fichiers de dépendances
COPY package.json package-lock.json ./
RUN npm install

# Copier tout le projet dans le conteneur
COPY . ./

# Compiler le projet (les fichiers compilés doivent se retrouver dans le dossier dist)
RUN npm run build --configuration=production

### STAGE 2: Run ###

FROM nginx:1.17.1-alpine

# Copier la configuration Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Copier les fichiers compilés du dossier dist dans le répertoire Nginx
COPY --from=build /usr/src/app/dist/aston-villa-app/ /usr/share/nginx/html


# Exposer le port 80
EXPOSE 80

# Démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
