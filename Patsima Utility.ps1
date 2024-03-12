Add-Type -AssemblyName System.Windows.Forms

# Función para ejecutar acciones según el tipo de dispositivo
function Execute-Actions {
    param (
        [string]$deviceType
    )
    Clear-TextBox
    $actions[$deviceType] | ForEach-Object {
        $action = $_
        Add-Action $action
        # Aquí puedes incluir la lógica para ejecutar cada acción, si es necesario
        switch ($action) {
            "Restore point" {
                # Restore point
                Checkpoint-Computer -Description "Punto de restauración antes de la instalación de Patsima Utility"
            }
            "Disable Activity History" {
                # Deshabilitar el historial de actividades
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d 0 /f
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "PublishUserActivities" /t REG_DWORD /d 0 /f
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "UploadUserActivities" /t REG_DWORD /d 0 /f
            }
            "Disable GameDVR" {
                # Disable GameDVR
                reg add "HKCU\System\GameConfigStore" /v "GameDVR_FSEBehavior" /t REG_DWORD /d 2 /f
                reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f
                reg add "HKCU\System\GameConfigStore" /v "GameDVR_DXGIHonorFSEWindowsCompatible" /t REG_DWORD /d 1 /f
                reg add "HKCU\System\GameConfigStore" /v "GameDVR_HonorUserFSEBehaviorMode" /t REG_DWORD /d 1 /f
                reg add "HKCU\System\GameConfigStore" /v "GameDVR_EFSEFeatureFlags" /t REG_DWORD /d 0 /f
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f
            }
            "Disable Hibernation" {
                # Disable Hibernation
                reg add "HKLM\System\CurrentControlSet\Control\Session Manager\Power" /v "HibernateEnabled" /t REG_DWORD /d 0 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings" /v "ShowHibernateOption" /t REG_DWORD /d 0 /f
                powercfg.exe /hibernate off
            }
            "Disable Homegroup services" {
                # Disable Homegroup services
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\HomeGroupListener" /v Start /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\HomeGroupProvider" /v Start /t REG_DWORD /d 3 /f
            }
            "Disable Location Tracking" {
                # Disable Location Tracking
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "Value" /t REG_SZ /d "Deny" /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d 0 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d 0 /f
                reg add "HKLM\SYSTEM\Maps" /v "AutoUpdateEnabled" /t REG_DWORD /d 0 /f
            }
            "Services" {
                # Services
                Set-Service AxInstSV -StartupType Disabled
                Set-Service tzautoupdate -StartupType Disabled
                Set-Service bthserv -StartupType Disabled
                Set-Service dmwappushservice -StartupType Disabled
                Set-Service MapsBroker -StartupType Disabled
                Set-Service lfsvc -StartupType Disabled
                Set-Service SharedAccess -StartupType Disabled
                Set-Service lltdsvc -StartupType Disabled
                Set-Service AppVClient -StartupType Disabled
                Set-Service NetTcpPortSharing -StartupType Disabled
                Set-Service CscService -StartupType Disabled
                Set-Service PhoneSvc -StartupType Disabled
                Set-Service Spooler -StartupType Disabled
                Set-Service PrintNotify -StartupType Disabled
                Set-Service QWAVE -StartupType Disabled
                Set-Service RmSvc -StartupType Disabled
                Set-Service RemoteAccess -StartupType Disabled
                Set-Service SensorDataService -StartupType Disabled
                Set-Service SensrSvc -StartupType Disabled
                Set-Service SensorService -StartupType Disabled
                Set-Service ShellHWDetection -StartupType Disabled
                Set-Service SCardSvr -StartupType Disabled
                Set-Service ScDeviceEnum -StartupType Disabled
                Set-Service SSDPSRV -StartupType Disabled
                Set-Service WiaRpc -StartupType Disabled
                Set-Service TabletInputService -StartupType Disabled
                Set-Service upnphost -StartupType Disabled
                Set-Service UserDataSvc -StartupType Disabled
                Set-Service UevAgentService -StartupType Disabled
                Set-Service WalletService -StartupType Disabled
                Set-Service FrameServer -StartupType Disabled
                Set-Service stisvc -StartupType Disabled
                Set-Service wisvc -StartupType Disabled
                Set-Service icssvc -StartupType Disabled
                Set-Service XblAuthManager -StartupType Disabled
                Set-Service XblGameSave -StartupType Disabled
                Set-Service SEMgrSvc -StartupType Disabled
                Set-Service DiagTrack -StartupType Disabled
            }
            "TweaksStorage" {
                # TweaksStorage
                reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy"            
            }
            "Disable Telemetry" {
                #Deshabilitar TelemetryController
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppCompatFlags\TelemetryController" /v "DisableInventory" /t REG_DWORD /d 1 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppCompatFlags\TelemetryController" /v "DisableOutbound" /t REG_DWORD /d 1 /f

                #Configuración de AutoChkProxy
                reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "AutoChkProxy" /t REG_DWORD /d 0 /f

                #Deshabilitar CEIP (Customer Experience Improvement Program)
                reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f

                #Deshabilitar Diagnóstico de Disco
                reg add "HKLM\SOFTWARE\Microsoft\Windows\DiskDiagnostic" /v "DisableDiskDiagnosisExecution" /t REG_DWORD /d 1 /f

                #Deshabilitar Windows Error Reporting
                reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "QueueReporting" /t REG_DWORD /d 0 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f

                #Configuración de AllowTelemetry
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f

                #Configuración de ContentDeliveryManager
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f

                #Configuración de CloudContent
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f
                reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableTailoredExperiencesWithDiagnosticData" /t REG_DWORD /d 1 /f

                #Deshabilitar AdvertisingInfo
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d 1 /f

                #Configuración de DeliveryOptimization
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 1 /f

                #Configuración de Remote Assistance
                reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f

                #Configuración de OperationStatusManager
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v "EnthusiastMode" /t REG_DWORD /d 1 /f

                #Configuración de Explorer
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "PeopleBand" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f

                #Configuración de FileSystem
                reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "LongPathsEnabled" /t REG_DWORD /d 1 /f

                #Configuración de DriverSearching
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 1 /f

                #Configuración de Multimedia\SystemProfile
                reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f

                #Configuración de Desktop
                reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "1" /f
                reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f
                reg add "HKCU\Control Panel\Mouse" /v "MouseHoverTime" /t REG_SZ /d "400" /f

                #Configuración de LanmanServer
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "IRPStackSize" /t REG_DWORD /d 30 /f

                #Configuración de Windows Feeds
                reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d 0 /f
                reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d 2 /f

                #Configuración de Explorer\Policies
                reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAMeetNow" /t REG_DWORD /d 1 /f

                #Configuración de Multimedia\SystemProfile\Tasks\Games
                reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d "High" /f
            }
            "PowerPlan" {
                # PowerPlan
                powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
                powercfg /changename 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c PatsimaUtility
                powercfg /setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 d4e98f31-5ffe-4ce1-be31-1b38b384c009 0
                powercfg /setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
                powercfg /setacvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 100
                powercfg /setacvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318584 100
                powercfg /setacvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 4d2b0152-7d5c-498b-88e2-34345392a2c5 5000
                powercfg /setactive scheme_current
            }
            "OOSU10" {
                # OOSU10
                curl.exe -s "https://raw.githubusercontent.com/PATSIMA/Patsima-Utility/main/ooshutup10.cfg" -o "$env:temp\ooshutup10.cfg"
                curl.exe -s "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -o "$env:temp\OOSU10.exe"
                Start-Process -FilePath "$env:temp\OOSU10.exe" -ArgumentList "/quiet", "$env:temp\ooshutup10.cfg" -NoNewWindow -Wait
            }
            "SVHOST" {
                # SVHOST
                reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "4294967295" /f
            }
            "Reiniciando" {
                # Reiniciando
                shutdown /r /f /t 7 /c "Patsima Utility COMPLETADO: REINICIANDO"
            }
            "Stop Updates" {
                # Stop Updates
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DoNotConnectToWindowsUpdateInternetLocations" /t REG_DWORD /d 0 /f
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableWindowsUpdateAccess" /t REG_DWORD /d 1 /f
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUServer" /t REG_SZ /d "" /f
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUStatusServer" /t REG_SZ /d "" /f
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "UpdateServiceUrlAlternate" /t REG_SZ /d "" /f
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /f
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "UseWUServer" /t REG_DWORD /d 1 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsStore\WindowsUpdate" /v "AutoDownload" /t REG_DWORD /d 2 /f
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /f
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /v "DriverUpdateWizardWuSearchEnabled" /t REG_DWORD /d 0 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 0 /f
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f
            }
        }
    }
}

# Definir acciones para cada tipo de dispositivo
$actions = @{
    "desktop" = @(
        "Restore point",
        "Disable Activity History",
        "Disable GameDVR",
        "Disable Hibernation",
        "Disable Homegroup services",
        "Disable Location Tracking",
        "OOSU10",
        "Services",
        "TweaksStorage",
        "Disable Telemetry",
        "PowerPlan"
        "SVHOST"
        "Reiniciando"
    )
    "laptop" = @(
        "Restore point",
        "Disable Activity History",
        "Disable GameDVR",
        "Disable Homegroup services",
        "Disable Location Tracking",
        "OOSU10",
        "Services",
        "TweaksStorage",
        "Disable Telemetry",
        "PowerPlan"
        "SVHOST"
        "Reiniciando"
    )
    "minimal" = @(
        "Restore point",
        "Disable Homegroup services",
        "OOSU10",
        "Services",
        "Disable Telemetry"
        "SVHOST"
        "Reiniciando"
    )
    "updates" = @(
        "Restore point",
        "Stop Updates"
        "Reiniciando"
    )
}


# Función para agregar acción al cuadro de texto
function Add-Action {
    param (
        [string]$action
    )
    $textBox.AppendText("$action`r`n")
}

# Función para limpiar el cuadro de texto
function Clear-TextBox {
    $textBox.Clear()
}

# Crear formulario
$PatsimaUtilityForm = New-Object System.Windows.Forms.Form
$PatsimaUtilityForm.Text = "Patsima Utility"
$PatsimaUtilityForm.Size = New-Object System.Drawing.Size(700, 400)
$PatsimaUtilityForm.StartPosition = "CenterScreen"
$PatsimaUtilityForm.BackColor = "#141414"  # Color de fondo oscuro
$PatsimaUtilityForm.FormBorderStyle = "FixedSingle"  # Bloquea el tamaño
$PatsimaUtilityForm.MaximizeBox = $false  # Deshabilita el botón de maximizar
$iconUrl = "https://raw.githubusercontent.com/PATSIMA/Patsima-Utility/main/Utility.ico"
$iconPath = "$env:TEMP\Utility.ico"  # Ruta temporal para guardar el icono descargado
Invoke-WebRequest -Uri $iconUrl -OutFile $iconPath

# Verificar si se descargó el icono correctamente
if (Test-Path $iconPath) {
    # Asociar el icono con el formulario
    $PatsimaUtilityForm.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($iconPath)
} else {
    Write-Host "Error al descargar el icono desde la URL."
}


# Crear panel para mostrar acciones de botones
$panel = New-Object System.Windows.Forms.Panel
$panel.Location = New-Object System.Drawing.Point(50, 70)
$panel.Size = New-Object System.Drawing.Size(600, 250)
$panel.BackColor = "#1f1f1f"  # Color de fondo del panel oscuro

# Crear cuadro de texto para mostrar acciones
$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Multiline = $true
$textBox.Location = New-Object System.Drawing.Point(10, 10)
$textBox.Size = New-Object System.Drawing.Size(580, 230)
$textBox.BackColor = "#1f1f1f"
$textBox.ForeColor = "#ffffff"
$textBox.ReadOnly = $true
$textBox.BorderStyle = "None"
$segoeFont = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Regular)
$textBox.Font = $segoeFont
$textBox.Padding = New-Object System.Windows.Forms.Padding(5)

# Agregar cuadro de texto al panel
$panel.Controls.Add($textBox)

# Función para crear una región redondeada
function Create-RoundedRegion {
    param (
        [System.Drawing.Rectangle]$rect,
        [int]$radius
    )

    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $path.AddArc($rect.X, $rect.Y, $radius, $radius, 180, 90)
    $path.AddArc($rect.Right - $radius, $rect.Y, $radius, $radius, 270, 90)
    $path.AddArc($rect.Right - $radius, $rect.Bottom - $radius, $radius, $radius, 0, 90)
    $path.AddArc($rect.X, $rect.Bottom - $radius, $radius, $radius, 90, 90)
    $path.CloseAllFigures()

    return $path
}

# Crear botones
$button1 = New-Object System.Windows.Forms.Button
$button1.Text = "Desktop"
$button1.Location = New-Object System.Drawing.Point(50, 25)
$button1.BackColor = "#282828"  # Color de fondo del botón oscuro
$button1.ForeColor = "#ffffff"  # Color del texto del botón blanco
$button1.FlatStyle = "Flat"  # Botón plano
$button1.FlatAppearance.BorderSize = 0  # Eliminar el contorno
$button1.Size = New-Object System.Drawing.Size(100, 30) # Tamaño más grande
$button1.Add_MouseEnter({
    $this.BackColor = [System.Drawing.Color]::FromArgb(109, 119, 247)  # Cambiar a gris oscuro al pasar el mouse
})
$button1.Add_MouseLeave({
    $this.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 40)  # Volver al color oscuro original al salir del mouse
})
$button1.Add_Click({
    # Ejecutar acciones asociadas al tipo de dispositivo desktop
    Execute-Actions "desktop"
})

$button2 = New-Object System.Windows.Forms.Button
$button2.Text = "Laptop"
$button2.Location = New-Object System.Drawing.Point(170, 25)
$button2.BackColor = "#282828"  # Color de fondo del botón oscuro
$button2.ForeColor = "#ffffff"  # Color del texto del botón blanco
$button2.FlatStyle = "Flat"  # Botón plano
$button2.FlatAppearance.BorderSize = 0  # Eliminar el contorno
$button2.Size = New-Object System.Drawing.Size(100, 30) # Tamaño más grande
$button2.Add_MouseEnter({
    $this.BackColor = [System.Drawing.Color]::FromArgb(109, 119, 247)  # Cambiar a gris oscuro al pasar el mouse
})
$button2.Add_MouseLeave({
    $this.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 40)  # Volver al color oscuro original al salir del mouse
})
$button2.Add_Click({
    # Ejecutar acciones asociadas al tipo de dispositivo laptop
    Execute-Actions "laptop"
})

$button3 = New-Object System.Windows.Forms.Button
$button3.Text = "Minimal"
$button3.Location = New-Object System.Drawing.Point(290, 25)
$button3.BackColor = "#282828"  # Color de fondo del botón oscuro
$button3.ForeColor = "#ffffff"  # Color del texto del botón blanco
$button3.FlatStyle = "Flat"  # Botón plano
$button3.FlatAppearance.BorderSize = 0  # Eliminar el contorno
$button3.Size = New-Object System.Drawing.Size(100, 30) # Tamaño más grande
$button3.Add_MouseEnter({
    $this.BackColor = [System.Drawing.Color]::FromArgb(109, 119, 247)  # Cambiar a gris oscuro al pasar el mouse
})
$button3.Add_MouseLeave({
    $this.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 40)  # Volver al color oscuro original al salir del mouse
})
$button3.Add_Click({
    # Ejecutar acciones asociadas al tipo de dispositivo minimal
    Execute-Actions "minimal"
})

$button4 = New-Object System.Windows.Forms.Button
$button4.Text = "Updates"
$button4.Location = New-Object System.Drawing.Point(410, 25)
$button4.BackColor = "#282828"  # Color de fondo del botón oscuro
$button4.ForeColor = "#ffffff"  # Color del texto del botón blanco
$button4.FlatStyle = "Flat"  # Botón plano
$button4.FlatAppearance.BorderSize = 0  # Eliminar el contorno
$button4.Size = New-Object System.Drawing.Size(100, 30) # Tamaño más grande
$button4.Add_MouseEnter({
    $this.BackColor = [System.Drawing.Color]::FromArgb(109, 119, 247)  # Cambiar a gris oscuro al pasar el mouse
})
$button4.Add_MouseLeave({
    $this.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 40)  # Volver al color oscuro original al salir del mouse
})
$button4.Add_Click({
    Execute-Actions "Updates"
})

# Agregar botones al formulario
$PatsimaUtilityForm.Controls.Add($button1)
$PatsimaUtilityForm.Controls.Add($button2)
$PatsimaUtilityForm.Controls.Add($button3)
$PatsimaUtilityForm.Controls.Add($button4)

# Agregar panel al formulario
$PatsimaUtilityForm.Controls.Add($panel)

# Mostrar formulario
$PatsimaUtilityForm.ShowDialog()

# Limpiar recursos
$PatsimaUtilityForm.Dispose()
