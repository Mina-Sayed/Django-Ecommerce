# Use an official Python runtime as a parent image
FROM python:3.7-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Copy the requirements.txt to the container
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Explicitly install the required versions to avoid conflicts
RUN pip install Django==2.2.4
RUN python -m pip install django-allauth==0.40.0
RUN pip install django-crispy-forms==1.7.2
RUN pip install django-countries==5.5
RUN pip install stripe==2.37.1
RUN pip install Pillow

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Expose the port Django runs on
EXPOSE 8000

# Run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
