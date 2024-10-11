# Pull the base image
FROM ghcr.io/danny-avila/librechat-dev:latest

# FROM ghcr.io/danny-avila/librechat-dev:0a1d38e3189a4f905d021be41ac2c8b5bd03d8b7


# Set environment variables
ENV HOST=0.0.0.0
ENV PORT=7860
ENV SESSION_EXPIRY=900000
ENV REFRESH_TOKEN_EXPIRY=604800000
ENV SEARCH=true
ENV MEILI_NO_ANALYTICS=true
ENV MEILI_HOST=https://librechat-meilisearch.hf.space

# Create necessary directories
RUN mkdir -p /app/uploads/temp
RUN mkdir -p /app/client/public/images/temp
RUN mkdir -p /app/api/logs/
RUN mkdir -p /app/data

# Give write permission to the directory
RUN chmod -R 777 /app/uploads/temp
RUN chmod -R 777 /app/client/public/images
RUN chmod -R 777 /app/api/logs/
RUN chmod -R 777 /app/data


# Copy Custom Endpoints Config
RUN curl -o /app/librechat.yaml https://raw.githubusercontent.com/ivanvmr/LibreChat/refs/heads/main/librechat-hf.yaml
# COPY librechat.yaml /app/librechat.yaml # Uncomment this and comment out the previous line to use the local librechat.yaml

# Install dependencies
RUN cd /app/api && npm install

# Command to run on container start
CMD ["npm", "run", "backend"]
