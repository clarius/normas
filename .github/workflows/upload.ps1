az account show | jq '.name + " (" + .user.name + ")"'
if ([string]::IsNullOrEmpty($env:ALL_CHANGED_FILES)) {
    write-output "No files changed. Skipping upload."
    exit 0
}

$baseBlobUrl = $env:AZURE_BLOB_URL
if (-not $baseBlobUrl.EndsWith('/')) {
    $baseBlobUrl += '/'
}

$files = $env:ALL_CHANGED_FILES -split ' '
foreach ($file in $files) {
    # We may get changed directories
    if (-not (test-path $file -PathType Leaf)) { continue }

    $blobName = [System.IO.Path]::GetFileName($file)
    $blobUrl = "$baseBlobUrl$blobName"
    
    $existsJson = az storage blob exists --blob-url $blobUrl --auth-mode login
    $exists = ($existsJson | convertfrom-json).exists
    
    if ($exists) {
        $metadataJson = az storage blob metadata show --blob-url $blobUrl --auth-mode login
    } else {
        $metadataJson = "{}"
    }
    
    # Convert metadata JSON to an array of key=value pairs using jq
    $metadataPairs = $metadataJson | & jq -r 'to_entries | map("\(.key)=\(.value)") | .[]'
    
    $uploadArgs = @(
        "storage", "blob", "upload",
        "--blob-url", $blobUrl,
        "--file", $file,
        "--overwrite", "true"
        "--auth-mode", "login"
    )
    
    if ($metadataPairs) {
        $uploadArgs += "--metadata"
        $uploadArgs += $metadataPairs
    }
    
    # Suppress output but still check for errors
    $result = & az @uploadArgs 2>&1
    if ($LASTEXITCODE -ne 0) {
        write-error "Failed to upload $file to blob storage: $result"
        exit $LASTEXITCODE
    }

    write-output "✅ $file > $blobUrl"
}