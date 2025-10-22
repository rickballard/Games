$ErrorActionPreference="Stop"
$root = (git rev-parse --show-toplevel).Trim()
$staged = & git diff --cached --name-only --diff-filter=ACMR
$touches = $staged | Where-Object { $_ -like "FTW/*" }
if($touches){
  & "$root\scripts\CoSync.ps1" -RepoRoot $root `
    -Area "FTW" -Type "change" -Summary "FTW staged changes" `
    -Data @{ files = $touches }
}
exit 0
