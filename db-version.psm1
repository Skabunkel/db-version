## This is not finished, there is stuff missing like creating or updating db_version.
## But the general idea is the same.

function Apply-Versions {
    param(
        [string]$Path,
        [System.Data.SqlClient.SqlConnection]$connection
    )

    if (-not (Test-Path $Path)) {
        throw "Path not found: $Path"
    }

    Push-Location $Path;
    $versions = Get-ChildItem -Directory | Where-Object { $_.Name -match '\d+\.\d+\.\d+' };
    foreach ($version in $versions) {
        Push-Location $version.Name
        $tran = $connection.BeginTransaction();
        Write-Information "Applying Version:\"$version\" on schema:\"$db_Schema\""

        try {
            Apply-Patch $tran 
        }
        catch {
            Write-Error "Unable to apply patches, rolling back."
            $tran.Rollback();
            Throw
        }

        Pop-Location
    }

    Pop-Location
}


function Apply-Patch {
    param (
        [System.Data.SqlClient.SqlTransaction]$Transaction
    )

    $patches = Get-ChildItem -File -Filter "*.sql" | Where-Object { $_.Name -match '\d{3}-\d{3}' };

    foreach ($patch in $patches) {
        if ($sql = Get-Content $patch) {
            $cmd = $Transaction.Connection.CreateCommand();
            $cmd.CommandText = "$sql;\r\nGO;";
            $cmd.ExecuteNonQuery();
        }
        else {
            Throw "File is empty";
        }
    }    
}