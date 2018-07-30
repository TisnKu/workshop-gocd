#!/usr/bin/env bash

PIPELINE_GROUP=workshop
PIPELINE_GIT=https://github.com/tw-ms-training/mst-pipelines


CONTENT="<config-repos>
    <config-repo pluginId=\"yaml.config.plugin\" id=\"$PIPELINE_GROUP\">
      <git url=\"$PIPELINE_GIT\" />
    </config-repo>
  </config-repos>"

C=$(echo $CONTENT | sed 's/\//\\\//g')
sed -i '' "7i\\
$C\\
" GoServerData/config/cruise-config.xml
