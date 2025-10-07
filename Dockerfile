# ==============================================================================
# Dockerfile para rodar o Worker do Celery
# ==============================================================================

FROM python:3.9-slim

# Instalação de Dependências do Sistema
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    libgl1 \
    libglib2.0-0 \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /code

# Instalar dependências Python
# Copia APENAS o requirements.txt primeiro para aproveitar o cache do Docker
COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Copiar todo o código do projeto para o WORKDIR
# Isso inclui tasks.py, celery_config.py e a pasta src/
COPY . /code/

# Adicionar a pasta 'src' ao PYTHONPATH para que as importações dentro de 'tasks.py' funcionem
# Ex: from services.document_processor import DocumentProcessor
ENV PYTHONPATH="${PYTHONPATH}:/code/src"

# --- CORREÇÃO PRINCIPAL AQUI ---
# Iniciar o worker apontando para a variável 'celery' dentro do módulo 'tasks'.
# O formato é: celery -A <nome_do_módulo>.<nome_da_variável_celery> worker
CMD ["celery", "-A", "tasks.celery", "worker", "--loglevel=info"]
