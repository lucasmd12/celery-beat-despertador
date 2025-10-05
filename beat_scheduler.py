from tasks import celery_app

celery_app.conf.beat_schedule = {
    'acordar-worker-a-cada-15-minutos': {
        'task': 'tasks.tarefa_despertador',
        'schedule': 900.0,  # 900 segundos = 15 minutos
    },
}
