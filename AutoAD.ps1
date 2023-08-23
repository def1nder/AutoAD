function New-User {
    $firstName = Read-Host "User ismini daxil edin:"
    $lastName = Read-Host "User soyadini daxil edin:"
    $userName = Read-Host "User domainini daxil edin"
    $password = Read-Host "Sifre teyin edin" | ConvertTo-SecureString -AsPlainText -Force
    $ouPath = "OU=OU1,DC=mylab,DC=local"
    New-ADUser -Name "$firstName $lastName" -SamAccountName $userName -UserPrincipalName "$userName@mylab.local" -GivenName $firstName -Surname $lastName -Enabled $true -AccountPassword $password -Path $ouPath
}

function New-OU {
    $ouName = Read-Host "Yeni OU ismini teyin edin"
    New-ADOrganizationalUnit -Name $ouName -Path "DC=mylab,DC=local"
}

function New-Group {
    $groupName = Read-Host "Yeni qrup ismini teyin edin"
    $groupScope = Read-Host "Qrup scope-u teyin edin ('Universal', 'Global' veya 'DomainLocal')"
    New-ADGroup -Name $groupName -GroupScope $groupScope
}

function Remove-User {
    $userNameToDelete = Read-Host "Silmek istediyiniz user-in ismini daxil edin"
    Remove-ADUser -Identity $userNameToDelete -Confirm:$false
}

do {
    Write-Host "Seciminizi teyin edin"
    Write-Host "1. Yeni user"
    Write-Host "2. Yeni OU (Organization Unit)"
    Write-Host "3. Yeni qrup"
    Write-Host "4. User silmek"
    Write-Host "5. Cixis"
    $choice = Read-Host "Bir secim teyin edin (1-5)"

    switch ($choice) {
        "1" {
            New-User
        }
        "2" {
            New-OU
        }
        "3" {
            New-Group
        }
        "4" {
            Remove-User
        }
        "5" {
            break
        }
        default {
            Write-Host "Yanlis input!"
        }
    }

} while ($true)