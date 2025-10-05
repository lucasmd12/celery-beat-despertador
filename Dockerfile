# 1. Imagem base
FROM python:3.9-slim

# 2. Define o diretório de trabalho
WORKDIR /app

# 3. Copia e instala as dependências
COPY requirements.txt .
RUN pip install -r requirements.txt

# 4. Copia o código da aplicação
COPY . .

# 5. Comando para iniciar o Celery Beat
CMD ["celery", "-A", "beat_scheduler", "beat", "--loglevel=INFO"]
