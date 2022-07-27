if ( "$INFLUXDB_VERSION" -eq "latest" ) {
  $INFLUXDB_VERSION = Invoke-WebRequest "https://api.github.com/repos/influxdata/influxdb/releases" | Select-Object -Expand Content | jq -r '. | sort_by(.tag_name) | reverse[] | .tag_name' | sed -e 's/v//g' | head -n 1
  $INFLUXDB_DOWNLOAD_PATH = "https://dl.influxdata.com/influxdb/releases"
} elseif ( "$INFLUXDB_VERSION" -eq "nightly" ) {
  $INFLUXDB_DOWNLOAD_PATH = "https://dl.influxdata.com/platform/nightlies"
} else {
  $INFLUXDB_DOWNLOAD_PATH = "https://dl.influxdata.com/influxdb/releases"
}

Write-Output $INFLUXDB_VERSION
Write-Output $INFLUXDB_DOWNLOAD_PATH

Invoke-WebRequest $INFLUXDB_DOWNLOAD_PATH/influxdb2-$INFLUXDB_VERSION-windows-amd64.zip
Expand-Archive -Path influxdb2-$INFLUXDB_VERSION-windows-amd64.zip
Copy-Item -Path influxdb2-$INFLUXDB_VERSION-windows-amd64\influxd -Destination "C:\Program Files\Influx\"
Remove-Item -Path influxdb2-$INFLUXDB_VERSION-windows-amd64 -Recurse

Invoke-WebRequest $INFLUXDB_DOWNLOAD_PATH/influxdb2-client-$INFLUXDB_VERSION-windows-amd64.zip
Expand-Archive -Path influxdb2-client-$INFLUXDB_VERSION-windows-amd64.zip
Copy-Item -Path influxdb2-client-$INFLUXDB_VERSION-windows-amd64\influx -Destination "C:\Program Files\Influx\"
Remove-Item -Path influxdb2-client-$INFLUXDB_VERSION-windows-amd64 -Recurse
