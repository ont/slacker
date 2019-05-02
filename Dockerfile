FROM python:3.6-onbuild
ENV PYTHONPATH ./
RUN mkdir -p /etc/slacker
CMD ["aiosmtpd", "-n", "-l", "0.0.0.0:8025", "-c", "handler.MessageHandler"]
EXPOSE 8025
