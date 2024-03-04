#####
# Pandoc Build Script
# github.com/thushan/pandoc-markdown-docs
#####
$CODE_STYLE = "zenburn"

$SOURCE = if ($args[0]) { $args[0] } else { "readme.md" }
$OUTPUT = $args[1]
$TEMPLATE = if ($args[2]) { $args[2] } else { "template/template.docx" }

if (!(Get-Command pandoc -ErrorAction SilentlyContinue)) {
    Write-Host "Please install pandoc to continue`n"  -foregroundcolor yellow

    if ($PSVersionTable.PSVersion.Major -lt 6) {
        Write-Host "$ choco install pandoc" -foregroundcolor blue
    } else {
        Write-Host "$ Install-Package pandoc" -foregroundcolor blue
    }
    exit 1
}

if (!(Test-Path $TEMPLATE)) {
    Write-Host "Template file $TEMPLATE not found :-("  -foregroundcolor red
    exit 1
}

if (!$OUTPUT) {
    $filename = [System.IO.Path]::GetFileNameWithoutExtension($SOURCE)
    $OUTPUT = "${filename}-draft.docx"
}

pandoc --toc --reference-doc $TEMPLATE `
        -o $OUTPUT `
        --highlight-style $CODE_STYLE `
        --from=markdown+grid_tables `
        $SOURCE

if (Test-Path $OUTPUT) {
    Write-Host "Document $OUTPUT created successfully :-)" -foregroundcolor green
} else {
    Write-Host "Document $OUTPUT was not created :-(" -foregroundcolor red
}
