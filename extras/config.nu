def start_zellij [] {
  if 'ZELLIJ' not-in ($env | columns) {
    if 'ZELLIJ_AUTO_ATTACH' in ($env | columns) and $env.ZELLIJ_AUTO_ATTACH == 'true' {
      zellij attach -c
    } else {
      zellij
    }
    if 'ZELLIJ_AUTO_EXIT' in ($env | columns) and $env.ZELLIJ_AUTO_EXIT == 'true' {
      exit
    }
  }
}

def set-sink [name?: string] {
  let search = $name
    | default (if "Jabra" in (pactl get-default-sink) {"hdmi"} else {"Jabra"});
  let new_sink = pactl list short sinks
    | lines
    | split column -r \s+ id desc
    | where desc =~ $search
    | get 0?.desc;
  if $new_sink != null {
    pactl set-default-sink $new_sink;
    $new_sink
  }
}

$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_MULTILINE_INDICATOR = ""

$env.config = {
  show_banner: false
  cursor_shape: {
    vi_insert: line
    vi_normal: block
  }
  edit_mode: vi
  # https://www.nushell.sh/cookbook/direnv.html
  hooks: {
    pre_prompt: [
      { ||
        if (which direnv | is-empty) {
          return
        }
        direnv export json | from json | default {} | load-env
        if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
          $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
        }
      }
    ]
  }
}
