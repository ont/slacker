FROM python:3-onbuild
ENV PYTHONPATH ./
RUN mkdir -p /etc/slacker
CMD ["smtpd", "-n", "-l", "0.0.0.0:8025", "-c", "handler.MessageHandler"]
EXPOSE 8025
