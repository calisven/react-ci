
# Build phase alias - purpose is to build the application
# and install dependencies
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build 

# Once you do the next "FROM" command, the previous build will not 
# be included in the final build output, we just copy the build and
# everything is is dropped

FROM nginx
# Copy the output of the previous build step into the Nginx container
# to serve
# The /usr/share/nginx/html location is where Nginx serves static content
COPY --from=builder /app/build /usr/share/nginx/html

