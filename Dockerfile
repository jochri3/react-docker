#Multi step process
# 1 -  Build phase
FROM node:16-alpine as builder

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

# 2 - Run phase

FROM nginx

#This is for prod : Elastic beanstalk => port that receives incoming trafic
EXPOSE 80 
COPY --from=builder /app/build /usr/share/nginx/html




# /app/build <- Production build
