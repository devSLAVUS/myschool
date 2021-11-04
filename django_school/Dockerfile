FROM python:3.8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
RUN mkdir /school
WORKDIR /school
COPY requirements.txt /school/
RUN pip install -r requirements.txt
COPY . /school/
EXPOSE 80
CMD ["python", "manage.py", "runserver", "0.0.0.0:80"]
