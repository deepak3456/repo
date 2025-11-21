# Use slim Python base
FROM python:3.10-slim

# Create a non-root user for security
RUN useradd -m appuser

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt gunicorn

# Copy only necessary files
COPY app.py iris_model.pkl /app/

# Switch to non-root user
USER appuser

# Expose Flask port
EXPOSE 5000

# Run with Gunicorn (production WSGI server)
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]
