FROM python:alpine3.18
WORKDIR /app
ENV PYTHONPATH /app
ADD ./ /app
RUN mkdir -p /etc/slacker
RUN apk add --no-cache git && pip install -r requirements.txt
CMD ["aiosmtpd", "-n", "-l", "0.0.0.0:8025", "-c", "handler.MessageHandler"]
EXPOSE 8025
