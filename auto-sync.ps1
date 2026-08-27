param([int]$IntervalSeconds = 5)

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$logPath = Join-Path $env:TEMP 'stronka-auto-sync.log'

function Write-Log {
    param([string]$Message)
    $stamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    Add-Content -Path $logPath -Value "[$stamp] $Message"
    Write-Host "[$stamp] $Message"
}

Set-Location $repoRoot
Write-Log 'Auto-sync watcher started.'
$lastState = ''

while ($true) {
    try {
        $status = git status --porcelain --untracked-files=all 2>$null
        if ($status -and $status -ne $lastState) {
            $lastState = $status
            Write-Log 'Changes detected. Staging and committing...'
            git add -A
            $branch = git branch --show-current
            $stamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
            $commitMessage = "Auto-sync: $stamp"
            git commit -m $commitMessage 2>$null | Out-Null

            if ($LASTEXITCODE -eq 0) {
                Write-Log 'Commit created. Pushing...'
                git push origin $branch
                if ($LASTEXITCODE -eq 0) {
                    Write-Log 'Push completed.'
                }
            }
            else {
                Write-Log 'No new commit was created.'
            }
        }
        elseif (-not $status) {
            $lastState = ''
        }
    }
    catch {
        Write-Log "Error: $($_.Exception.Message)"
    }

    Start-Sleep -Seconds $IntervalSeconds
}
