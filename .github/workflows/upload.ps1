az account show | jq '.name + " (" + .user.name + ")"'
            
# We first upload JSON files so that the markdown processing can fetch them if needed
$files = $env:CHANGED_JSON -split ' '
foreach ($file in $files) {
    if (-not (test-path $file -PathType Leaf)) { continue }
    $blob = "$env:AZURE_BLOB_URL$([System.IO.Path]::GetFileName($file))"
    $metadata = $(az storage blob metadata show --blob-url $blob --auth-mode login | jq -r 'to_entries | map("\(.key)=\(.value)") | join(";")' 2>$null) ?? ''
    $result = & azcopy copy $file $blob --overwrite=ifSourceNewer --metadata $metadata --content-type="application/json; charset=utf-8"

    if ($LASTEXITCODE -ne 0) {
        write-error "Failed to upload $file to blob storage: $result"
        exit $LASTEXITCODE
    }

    write-output "✅ $file > $blob"
}

# Then we upload the markdown files
$files = $env:CHANGED_MD -split ' '
foreach ($file in $files) {
    if (-not (test-path $file -PathType Leaf)) { continue }
    $blob = "$env:AZURE_BLOB_URL$([System.IO.Path]::GetFileName($file))"
    $metadata = $(az storage blob metadata show --blob-url $blob --auth-mode login | jq -r 'to_entries | map("\(.key)=\(.value)") | join(";")' 2>$null) ?? ''
    $result = & azcopy copy $file $blob --overwrite=ifSourceNewer --metadata $metadata --content-type="text/markdown; charset=utf-8"

    if ($LASTEXITCODE -ne 0) {
        write-error "Failed to upload $file to blob storage: $result"
        exit $LASTEXITCODE
    }

    write-output "✅ $file > $blob"
}