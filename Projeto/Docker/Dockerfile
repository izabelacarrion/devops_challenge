FROM python:3.12-alpine3.23

RUN apk update && apk upgrade --no-cache

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /App

COPY App/app.py .

RUN chown -R appuser:appgroup /App

USER appuser

ENV APP_ENV=development

EXPOSE 8080

CMD ["python", "app.py"]