FROM python:3.8-alpine
WORKDIR /data
COPY ./data ./
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories && \
    apk update && apk add --no-cache --virtual build-dependencies libffi-dev g++ tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
    pip install -U pip && \
    pip install --no-cache-dir -r requirements.txt && \
    apk del build-dependencies && \
    chmod +x docker-entrypoint.sh && \
    mkdir -p /www/server/panel && \
    rm -rf /var/cache/apk/* && \
    rm -rf /root/.cache && \
    rm -rf /tmp/*

ENTRYPOINT [ "./docker-entrypoint.sh" ]
