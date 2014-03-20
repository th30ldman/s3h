s3h
===

AutoSSH and Tmux on steroids. 

This provides a set of scripts and configurations in conjunction with ssh,
autossh and tmux (or screen) to provide a persistent 'state' on remote hosts.

If you are in the position of doing lots of work on embedded systems or
cloud based infrastructure etc. The ability to drop connections, and
not have to go through a lenghty process to get back to where you were
this might be useful. 

Terse instructions:

On the host you ssh from:

- sshrc, place in ~/.ssh/rc
- config, customize and  merge in ~/.ssh/config
- s3h, place in ~/bin or anywhere else in your exec path
- place a suitable tmux.conf on the remote hosts. 
  (See included, and customize)
- mkdir .ssh/control-master

On the hosts that you ssh to:
- Include s3h.sh somewhere in your shell config (.bashrc, .profile)

- Make sure that remote hosts have proper authorized keys, and ssh
  agent is running. It works without, but you'll be typing passphrases
  or passwords a lot more.

The problem that this solves is that in order to have ssh-agent
forwarding work 'persistently' across multiple sessions requires that
in sshrc a link is created that points to the ssh-agent unix domain
socket and sets the SSH_AUTH_SOCK to point to that link. Otherwise on
subsequent tmux/screen sessions the SSH_AUTH_SOCK environment variable
would be point to a stale socket name. This in turn would fail any
attempt to use agent based authentication.

Note that this is a 'known' link to an otherwise marginally obscured
temporary name. The code in s3h.sh blows this link away in case you're
not using screen/tmux. It is fairly trivial to come up with a similar
temp name using mktemp, and use that. It however makes it slightly
harder to blow away stale links. The security gained is marginal. Note
also that the link is only 'hot' when you are logged in over ssh.

Lastly, it is best to configure ssh to use controlmaster connections,
that way any subsequent scp/ssh etc, will use the existing connection,
this cuts out the time it takes to authenticate. (The provided ssh
config does this.)





