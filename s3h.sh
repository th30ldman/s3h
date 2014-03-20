# append/insert/fudge into your .profile or .bashrc. (source)
#
# SSH agent stuff, only to be done for screen.
# See .ssh/rc where the creation of the link is done.
if [ -n $SSH_AUTH_SOCK ] && [ "$TERM" = "screen" ] ; then
    SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
    export SSH_AUTH_SOCK
else
    # blow link, opens up a convenient door to the agent.
    rm -f ~/.ssh/ssh_auth_sock
fi
