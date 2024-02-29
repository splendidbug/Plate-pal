FROM python:3.10-slim

RUN apt-get update && apt-get install -y gcc wget

COPY ./requirements.txt /tmp/requirements.txt

RUN pip install -U -r /tmp/requirements.txt

COPY ./src /app
COPY start.sh start.sh
RUN chmod +x /start.sh

ENV PYTHONPATH=/app:/usr/lib/python3/dist-packages
WORKDIR /app
CMD ["/start.sh"]