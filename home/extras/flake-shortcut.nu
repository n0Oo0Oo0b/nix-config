def search-flake [cwd?: string] {
  let dirs = generate {|dir|
    let parent = ($dir | path dirname)
    if $parent != $dir and $dir != $env.HOME {{out: $dir, next: $parent}}
  } ($cwd | default $"(pwd)")
    | where {|dir| $dir | path join "flake.nix" | path exists}
    | first 1
  if ($dirs | is-empty) {
    error make -u { msg: "no flake detected" }
  }
  $dirs | first
}

def my-nix-build [
  name="default"
  --add-git (-a)
] {
  let flake_root = search-flake
  if $add_git and ($flake_root | path join ".git" | path exists) {
    git add $flake_root
  }
  nix build $"($flake_root)#($name)"
}
alias nb = my-nix-build
