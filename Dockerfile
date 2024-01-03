FROM python:3.11-slim-bullseye

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_DEFAULT_TIMEOUT=120 

WORKDIR /app
# Change the permissions of the /app directory
RUN chmod 777 /app
# Copy the .deb file
COPY pdf2htmlEX-0.18.8.rc1-master-20200630-Ubuntu-bionic-x86_64.deb /app/pdf2htmlEX-0.18.8.rc1-master-20200630-Ubuntu-bionic-x86_64.deb
# Install the .deb file using dpkg
RUN dpkg -i pdf2htmlEX-0.18.8.rc1-master-20200630-Ubuntu-bionic-x86_64.deb
RUN apt install -f 

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir --upgrade -r requirements.txt

EXPOSE 8501

HEALTHCHECK --interval=1m --timeout=10s \
    CMD curl --fail http://localhost:8501/_stcore/health

COPY app.py /app/app.py

CMD ["streamlit", "run", "/app/app.py"]