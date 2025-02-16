# Use a slim Python base image
FROM python:3.12-slim-bookworm

# Install dependencies (curl and ca-certificates) and clean up apt cache to reduce image size
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download and install uv using curl
RUN curl -fsSL https://astral.sh/uv/install.sh | sh

# Ensure the installed binary is on the PATH
ENV PATH="/root/.local/bin:$PATH"

# Set up the application directory
WORKDIR /app

# Copy application files into the container
COPY app.py /app
COPY tasksA.py /app
COPY tasksB.py /app

# Install FastAPI and Uvicorn for the app
RUN pip install fastapi uvicorn

# Expose the port the app will run on
EXPOSE 8000

# Run the application using uv
CMD ["uv", "run", "app.py"]