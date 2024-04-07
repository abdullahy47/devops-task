FROM mcr.microsoft.com/mssql/server:latest
    
ENV ACCEPT_EULA=Y

ENV SA_PASSWORD="Un!q@to2023"



# codes below may be useful in other different projects and tasks -- just an information
## 

#USER root
#ENV MSSQL_PID=Developer
#ENV MSSQL_TCP_PORT=1433

#WORKDIR /

#COPY data1.sql ./data1.sql 

#RUN (/opt/mssql/bin/sqlservr --accept-eula & ) | grep -q "Service Broker manager has started" && \
#/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P Un!q@to2023 -i data1.sql