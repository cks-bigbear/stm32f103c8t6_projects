# ==============================
# Toolchain PATH init (session-only)
# ==============================

$ScriptDir = Split-Path -Parent $PSCommandPath

$ProjectRoot = $ScriptDir

$CMAKE    = "C:\Program Files\CMake\bin"
$NINJA    = "C:\ninja-win"
$LLVM_ET  = "C:\LLVM-ET-Arm-19.1.5-Windows-x86_64\bin"

function Ensure-DirectoryExists($Path, $Name) {
    if (-not (Test-Path $Path)) {
        Write-Warning "$Name not found: $Path"
        return $false
    }
    return $true
}

$PathsToAdd = @()

if (Ensure-DirectoryExists $CMAKE "CMake") {
    $PathsToAdd += $CMAKE
}
if (Ensure-DirectoryExists $NINJA "Ninja") {
    $PathsToAdd += $NINJA
}
if (Ensure-DirectoryExists $LLVM_ET "LLVM Embedded Toolchain") {
    $PathsToAdd += $LLVM_ET
}

foreach ($p in $PathsToAdd) {
    if ($env:PATH -notlike "*$p*") {
        $env:PATH = "$p;$env:PATH"
    }
}

Write-Host "`Toolchain PATH initialized (current session only)" -ForegroundColor Green

try {
    $clangVer = clang --version | Select-Object -First 1
    Write-Host "clang: $clangVer" -ForegroundColor Cyan
} catch {
    Write-Warning "clang not callable. Check LLVM bin path."
}

try {
    Write-Host "ninja: $(ninja --version)" -ForegroundColor Cyan
} catch {
    Write-Warning "ninja not callable."
}

try {
    Write-Host "cmake: $(cmake --version | Select-Object -First 1)" -ForegroundColor Cyan
} catch {
    Write-Warning "cmake not callable."
}