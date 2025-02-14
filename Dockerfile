### STAGE 1: Build service comme alias ###
FROM node:16-alpine AS build
WORKDIR /usr/src/app

# Copier les fichiers de dépendances
COPY package.json package-lock.json ./
RUN npm install

# Copier le contenu du projet dans le container
COPY . ./

# Compiler le projet
RUN npm run build

### STAGE 2: Run ###

FROM nginx:1.17.1-alpine

# Copier la configuration Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Copier les fichiers compilés du dossier dist
COPY --from=build /usr/src/app/dist /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# Démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
