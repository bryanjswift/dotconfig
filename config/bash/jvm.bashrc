# Environment Variables for JVM Development
if [ -f /usr/libexec/java_home ]; then
  export JAVA_HOME=$(/usr/libexec/java_home)
fi
export M2_REPOSITORY=$HOME/.m2/repository
