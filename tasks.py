from celery import Celery
import os
import ssl

redis_url = os.getenv("REDIS_URL")
celery_app = Celery("despertador", broker=redis_url)

if redis_url.startswith("rediss://"):
    celery_app.conf.update(
        broker_use_ssl={'ssl_cert_reqs': ssl.CERT_NONE},
    )

@celery_app.task
def tarefa_despertador():
    print("BEEP BEEP! Acordando o worker principal...")
    return "Worker acordado."
