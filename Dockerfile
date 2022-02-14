FROM node:14-alpine

WORKDIR /usr/app

COPY package.json yarn.lock .nvmrc ./
RUN yarn

COPY packages .
RUN yarn

COPY . .
RUN yarn bootstrap
RUN yarn build

EXPOSE 8080

CMD ["yarn", "develop"]