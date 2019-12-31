# If JAVA_HOME is not set then include Java things
if [ -z ${JAVA_HOME+x} ]; then
  # JAVA_HOME unset
  export JAVA_HOME=$(
    java -XshowSettings:properties -version 2>&1 \
      | grep "java\.home" \
      | cut -d "=" -f 2 \
      | tr -d ' '
  )
fi
