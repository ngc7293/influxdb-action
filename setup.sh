
if [ "$INFLUXDB_START" = "true" ]
then
    influxd --http-bind-address :8086 --reporting-disabled > /dev/null 2>&1 &
    until curl -s --max-time 2 http://localhost:8086/health; do sleep 1; done
    influx setup --host http://localhost:8086 -f \
        -o $INFLUXDB_ORG \
        -u $INFLUXDB_USER \
        -p $INFLUXDB_PASSWORD \
        -b $INFLUXDB_BUCKET \
        -t $INFLUXDB_TOKEN
fi