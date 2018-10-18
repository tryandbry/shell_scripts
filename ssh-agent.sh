#!/bin/bash

SOCKET_DIR=$HOME/.ssh_sock
SOCKET_FILE=$HOME/.ssh_sock/ssh-agent-socket
if [[ ! -e $SOCKET_DIR ]]; then
  mkdir -p $SOCKET_DIR
fi

function start_ssh_agent {
  eval `ssh-agent -s -a $SOCKET_FILE`;
}

function cleanup {
  if [[ -e $SOCKET_FILE ]]; then
    rm $SOCKET_FILE;
  fi
  AGENT_PID=`ps -ef | awk '/ssh-agent.*ssh-agent-socket$/ {print $2}'`
  if [[ $AGENT_PID =~ [0-9]+ ]]; then
    kill -9 `ps -ef | awk '/ssh-agent.*ssh-agent-socket$/ {print $2}'`
  fi
}

# find existing PID, if any:
AGENT_PID=`ps -ef | awk '/ssh-agent.*ssh-agent-socket$/ {print $2}'`

if [[ $AGENT_PID =~ [0-9]+ && -e $SOCKET_FILE ]]; then
  SSH_AGENT_PID=$AGENT_PID; export SSH_AGENT_PID;
  SSH_AUTH_SOCK=$SOCKET_FILE; export SSH_AUTH_SOCK;
  echo "ssh agent PID ${SSH_AGENT_PID} found.  Attaching to existing process"
else
  echo 'cleaning up and starting new ssh agent'
  cleanup
  start_ssh_agent
fi
