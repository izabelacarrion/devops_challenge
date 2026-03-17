FROM python:3.12-alpine

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

COPY app/app.py .

RUN chown -R appuser:appgroup /app

USER appuser

ENV APP_ENV=development

EXPOSE 8080

CMD ["python", "app.py"]