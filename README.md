## Домашнее задание к занятию 15.4 "Кластеры. Ресурсы под управлением облачным провайдером".

Организация кластера EKS и базы данных MySQL в отказоустойчивой архитектуре.
Настроить с помощью terraform кластер EKS в 3 AZ региона, а также RDS на базе MySQL с поддержкой MultiAZ для репликации и создать 2 readreplica для работы.


### Задание 1. Создать кластер RDS на базе MySQL

Используя конфигурации, выполненные в рамках ДЗ на предыдущих занятиях создать в VPC кластер RDS.
В качестве БД выбрать MySQL. Разместить в Private subnet и обеспечить доступ из public-сети c помощью security-group.
Настроить backup в 7 дней и MultiAZ для обеспечения отказоустойчивости.
Настроить Read prelica в кол-ве 2 шт на 2 AZ.

---

### Задание 2. Создать кластер EKS на базе EC2

С помощью terraform установить кластер EKS на 3 EC2-инстансах в VPC в public-сети.
Обеспечить доступ до БД RDS в private-сети.
С помощью kubectl установить и запустить контейнер с phpmyadmin (образ взять из docker hub) и проверить подключение к БД RDS.


---
worknotes: </br> 
https://learn.hashicorp.com/tutorials/terraform/eks </br> 
https://cloud.yandex.ru/docs/managed-mysql/operations/cluster-create </br> 
