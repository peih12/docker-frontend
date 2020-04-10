#build for PROD environment
#base image 1
FROM node:alpine as builder

#specify the working directory. ./ in the copy command refers now to /usr/app/
workdir /app

#Install dependencies
#have to install npm/nodejs first
#copy files from our project into container, before running npm install
#granulate has an impact on bulding time using cache. Many things could be optimized here
copy ./package.json ./
RUN npm install

copy ./ ./

RUN npm run build

#Run phase
#base image 2
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html