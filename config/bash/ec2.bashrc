# Environment Variables for EC2
if [ -d $HOME/.ec2 ]; then
  export EC2_HOME=$HOME/.ec2
  export EC2_PRIVATE_KEY="$(/bin/ls "$EC2_HOME"/pk-*.pem | /usr/bin/head -1)"
  export EC2_CERT="$(/bin/ls "$EC2_HOME"/cert-*.pem | /usr/bin/head -1)"
  export EC2_AMITOOL_HOME="/usr/local/Library/LinkedKegs/ec2-ami-tools/jars"
  export EC2_ACCESS=`cat $EC2_HOME/access.key`
  export EC2_SECRET=`cat $EC2_HOME/secret.key`
fi
