# --- Build React Client ---
FROM node:18-alpine AS client-build
WORKDIR /app
COPY client/package*.json ./
RUN npm install
COPY client/ .
RUN npm run build

# --- Build Express Server ---
FROM node:18-alpine AS server-build
WORKDIR /app
COPY server/package*.json ./
RUN npm install
COPY server/ .

# Copy built React files into backend public folder
COPY --from=client-build /app/build ./public

EXPOSE 5000
CMD ["npm", "start"]

