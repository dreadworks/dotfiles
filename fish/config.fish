
function __config_custom
  ulimit -n 1024

  set -l fish_dir ~/.config/fish

  # not under version control for machine specific configuration
  set -l local_conf $fish_dir/config.local.fish
  if [ -f $local_conf ]
    . $local_conf
  end


  # includes
  . $fish_dir/functions/alias.fish
  eval (python -m virtualfish 2>/dev/null)

  # plugins
  if functions -q fundle
    fundle plugin 'tuvistavie/fish-ssh-agent'
    fundle init
  end

end

__config_custom
