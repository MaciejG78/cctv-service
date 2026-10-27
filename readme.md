


## Lab 2
* Integrate Swagger UI and OpenAPI documentation.
* Run PostgreSQL in a Docker container.
* Design the database schema, entities, relationships, and indexes.
* Configure Spring Data JPA and database connectivity.
* Integrate Liquibase into the project.
* Create Liquibase changelogs for tables, relationships and initial data where needed.
* Verify that the database schema can be recreated from scratch.

### Swagger url:
http://localhost:8080/swagger-ui.html

### Liquibase documentation:
https://docs.liquibase.com/secure/set-up-secure-automation-6-0/structure-your-changelog/organize-changes-by-release
https://www.liquibase.org/

### Actuator
http://localhost:8080/actuator/health


### Profiles
java -jar myapp.jar --spring.profiles.active=dev
https://www.geeksforgeeks.org/advance-java/spring-boot-managing-application-properties-with-profiles/