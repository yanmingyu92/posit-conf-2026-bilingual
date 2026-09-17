<#
.SYNOPSIS
  Sync upstream posit::conf workshop materials into this bilingual repository.
  将上游 posit::conf 工作坊材料同步进本双语仓库。

.DESCRIPTION
  - 2026 materials are MIRRORED (verbatim copy) under content/en/<track>/<repo>/,
    with .git directories excluded, and provenance recorded in
    content/en/MANIFEST.json (org, repo, url, commit SHA, file count).
  - Prior-year (2024/2025) materials are CATALOGED only: if local clones exist
    under ..\posit-conf-archive\<year>\, their SHAs are recorded in
    content/en/MANIFEST-ARCHIVES.json; contents are never copied.
  - Re-running this script is idempotent (robocopy /MIR keeps mirrors exact).

.NOTES
  Requires: git, robocopy (built into Windows). Run from repo root or scripts/.
#>

[CmdletBinding()]
param(
    # Where the 2026 upstream clones live (local git clones, NOT remote).
    [string]$Upstream2026Root = (Join-Path $PSScriptRoot "..\..\learn-posit-conf-2026"),
    # Where prior-year archive clones live.
    [string]$ArchiveRoot     = (Join-Path $PSScriptRoot "..\..\posit-conf-archive"),
    # Destination for mirrored content.
    [string]$ContentRoot     = (Join-Path $PSScriptRoot "..\content\en")
)

$ErrorActionPreference = "Stop"

# 2026 repos: repo name => track folder (mirrored in full)
$Mirror2026 = [ordered]@{
    "positron"                   = "01-positron"
    "modern-r-workflow"          = "02-modern-r-workflow"
    "practical-quarto"           = "03-quarto"
    "practical-quarto-exercises" = "03-quarto"
    "llms"                       = "04-llms"
    "pharmaverse"                = "05-pharma"
    "r-pharma-regulated"         = "05-pharma"
    "modern-ds-python"           = "06-python"
}

# Prior-year repos: catalog only (org, year => repos)
$CatalogArchive = [ordered]@{
    "2025" = @(
        "shiny-r","shiny-py","pkg-dev","r-programming","r-programming-exercises",
        "ggplot2","tidymodels","scikit-learn","causal","quarto-brand",
        "quarto-extend","quarto-extend-exercises","reproducible-environments"
    )
    "2024" = @(
        "level-up-shiny","quarto-intro","databases","arrow","r-in-production","vetiver"
    )
}

New-Item -ItemType Directory -Path $ContentRoot -Force | Out-Null

# ---------- 1. Mirror 2026 ----------
$manifest = @()
foreach ($repo in $Mirror2026.Keys) {
    $track  = $Mirror2026[$repo]
    $src    = Join-Path $Upstream2026Root $repo
    $dst    = Join-Path $ContentRoot "$track\$repo"

    if (-not (Test-Path $src)) {
        Write-Warning "SKIP (no local clone): $src"
        continue
    }

    New-Item -ItemType Directory -Path (Split-Path $dst -Parent) -Force | Out-Null
    robocopy $src $dst /MIR /XD .git .Rproj.user /NFL /NDL /NJH /NJS /NP | Out-Null
    if ($LASTEXITCODE -ge 8) { throw "robocopy failed for $repo (exit $LASTEXITCODE)" }

    $sha   = git -C $src rev-parse HEAD
    $files = (Get-ChildItem $dst -Recurse -File | Measure-Object).Count
    $manifest += [pscustomobject]@{
        org = "posit-conf-2026"; repo = $repo
        url = "https://github.com/posit-conf-2026/$repo"
        sha = $sha; track = $track
        mirrored_into = "content/en/$track/$repo"; files = $files
    }
    Write-Verbose ("mirrored {0} ({1} files, {2})" -f $repo, $files, $sha.Substring(0,8))
}
$manifest | ConvertTo-Json -Depth 3 | Set-Content (Join-Path $ContentRoot "MANIFEST.json") -Encoding UTF8
Write-Output ("Mirrored {0} repos of 2026 -> content/en (MANIFEST.json written)" -f $manifest.Count)

# ---------- 2. Catalog prior years ----------
$archives = @()
foreach ($year in $CatalogArchive.Keys) {
    foreach ($repo in $CatalogArchive[$year]) {
        $src = Join-Path $ArchiveRoot "$year\$repo"
        $sha = $null
        if (Test-Path $src) { $sha = git -C $src rev-parse HEAD }
        $archives += [pscustomobject]@{
            org = "posit-conf-$year"; repo = $repo
            url = "https://github.com/posit-conf-$year/$repo"
            sha = $sha; catalog_only = $true
        }
    }
}
$archives | ConvertTo-Json -Depth 3 | Set-Content (Join-Path $ContentRoot "MANIFEST-ARCHIVES.json") -Encoding UTF8
Write-Output ("Cataloged {0} prior-year repos (MANIFEST-ARCHIVES.json written)" -f $archives.Count)
