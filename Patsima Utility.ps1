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
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\1394ohci" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\ACPI" /v "Start" /t REG_DWORD /d 0 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\AcpiDev" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\acpiex" /v "Start" /t REG_DWORD /d 0 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\acpipagr" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\AcpiPmi" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\acpitime" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\Acx01000" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\ADP80XX" /v "Start" /t REG_DWORD /d 0 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\AFD" /v "Start" /t REG_DWORD /d 1 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\afunix" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\ahcache" /v "Start" /t REG_DWORD /d 1 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\ALG" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdgpio2" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdi2c" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\AmdK8" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\AmdPPM" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdsata" /v "Start" /t REG_DWORD /d 0 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdsbs" /v "Start" /t REG_DWORD /d 0 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\amdxata" /v "Start" /t REG_DWORD /d 0 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppID" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppIDSvc" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\Appinfo" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppleKmdfFilter" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppleLowerFilter" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\applockerfltr" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppMgmt" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppReadiness" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\AppXSvc" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\AsyncMac" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\atapi" /v "Start" /t REG_DWORD /d 0 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\AudioEndpointBuilder" /v "Start" /t REG_DWORD /d 2 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\Audiosrv" /v "Start" /t REG_DWORD /d 2 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\bam" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\Beep" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\bindflt" /v "Start" /t REG_DWORD /d 2 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTAGService" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthA2dp" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthAvctpSvc" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthEnum" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthHFEnum" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthLEEnum" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthMini" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\BthPan" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHPORT" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\bthserv" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\BTHUSB" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\buttonconverter" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\CAD" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\cbdhsvc" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\cdfs" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\CDPSvc" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\CimFS" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\circlass" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\cnghwassist" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\CompositeBus" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\defragsvc" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dfsc" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagsvc" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\DispBrokerDesktopSvc" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\DisplayEnhancementService" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\DsmSvc" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\Eaphost" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\edgeupdate" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\edgeupdatem" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\EFS" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\ErrDev" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\fdc" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\fdPHost" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\FDResPub" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\flpydisk" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\FontCache" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\FontCache3.0.0.0" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\fvevol" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\GpuEnergyDrv" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\HidBth" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\icssvc" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\IKEEXT" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\InstallService" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\iphlpsvc" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\IpxlatCfgSvc" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\KSecPkg" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\KtmRm" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\lmhosts" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\luafv" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\Microsoft_Bluetooth_AvrcpTransport" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\mrxsmb20" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\MSDTC" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\MsLldp" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\NdisVirtualBus" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetTcpPortSharing" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\nvraid" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\PcaSvc" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\QWAVE" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\QWAVEdrv" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\RasMan" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\rdbss" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\rdyboost" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\RFCOMM" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\RmSvc" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\rspndr" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\sfloppy" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\ShellHWDetection" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\SiSRaid2" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\SiSRaid4" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\SmsRouter" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\Spooler" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\sppsvc" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\srv2" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\SSDPSRV" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\SstpSvc" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\SysMain" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\TapiSrv" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip6" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\tcpipreg" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\tdx" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\Themes" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\tzautoupdate" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\udfs" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\umbus" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\VaultSvc" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\VerifierExt" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\vsmraid" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\VSTXRAID" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\vwifibus" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\vwififlt" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\vwifimp" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WacomPen" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\wanarp" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\wanarpv6" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WarpJITSvc" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\wcifs" /v "Start" /t REG_DWORD /d 2 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\Wcmsvc" /v "Start" /t REG_DWORD /d 2 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\wcnfs" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\Wdf01000" /v "Start" /t REG_DWORD /d 0 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\wdiwifi" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WdmCompanionFilter" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WebClient" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\Wecsvc" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WEPHOSTSVC" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WFDSConMgrSvc" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WFPLWFS" /v "Start" /t REG_DWORD /d 0 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WiaRpc" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WIMMount" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WindowsTrustedRT" /v "Start" /t REG_DWORD /d 0 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WindowsTrustedRTProxy" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinHttpAutoProxySvc" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\Winmgmt" /v "Start" /t REG_DWORD /d 2 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WinNat" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WINUSB" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WlanSvc" /v "Start" /t REG_DWORD /d 2 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\wlidsvc" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WManSvc" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WmiAcpi" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\wmiApSrv" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WMPNetworkSvc" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\Wof" /v "Start" /t REG_DWORD /d 0 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WpdUpFltr" /v "Start" /t REG_DWORD /d 3 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WpnService" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WpnUserService" /v "Start" /t REG_DWORD /d 2 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\ws2ifsl" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\WSearch" /v "Start" /t REG_DWORD /d 4 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d 3 /f
            }
            "TweaksStorage" {
                # TweaksStorage
                reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy"          
            }
            "Disable Telemetry" {
                # Disable Telemetry
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppCompatFlags\TelemetryController" /v "DisableInventory" /t REG_DWORD /d 1 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppCompatFlags\TelemetryController" /v "DisableOutbound" /t REG_DWORD /d 1 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "AutoChkProxy" /t REG_DWORD /d 0 /f
                reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
                reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows\DiskDiagnostic" /v "DisableDiskDiagnosisExecution" /t REG_DWORD /d 1 /f
                reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
                reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "QueueReporting" /t REG_DWORD /d 0 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppCompatFlags\TelemetryController" /v "DisableInventory" /t REG_DWORD /d 1 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppCompatFlags\TelemetryController" /v "DisableOutbound" /t REG_DWORD /d 1 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppCompatFlags\TelemetryController" /v "DisableInventory" /t REG_DWORD /d 1 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppCompatFlags\TelemetryController" /v "DisableOutbound" /t REG_DWORD /d 1 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "OemPreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "PreInstalledAppsEnabled" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SilentInstalledAppsEnabled" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f
                reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f
                reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableTailoredExperiencesWithDiagnosticData" /t REG_DWORD /d 1 /f
                reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d 1 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 1 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v "EnthusiastMode" /t REG_DWORD /d 1 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "PeopleBand" /t REG_DWORD /d 0 /f
                reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "LongPathsEnabled" /t REG_DWORD /d 1 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 1 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "SystemResponsiveness" /t REG_DWORD /d 0 /f
                reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f
                reg add "HKCU\Control Panel\Desktop" /v "MenuShowDelay" /t REG_SZ /d "1" /f
                reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "ClearPageFileAtShutdown" /t REG_DWORD /d 0 /f
                reg add "HKLM\SYSTEM\ControlSet001\Services\Ndu" /v "Start" /t REG_DWORD /d 2 /f
                reg add "HKCU\Control Panel\Mouse" /v "MouseHoverTime" /t REG_SZ /d "400" /f
                reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "IRPStackSize" /t REG_DWORD /d 30 /f
                reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t REG_DWORD /d 0 /f
                reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t REG_DWORD /d 2 /f
                reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAMeetNow" /t REG_DWORD /d 1 /f
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
                reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 00000001 /f
                reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUServer" /t REG_SZ /d "0.0.0.0" /f
                reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "WUStatusServer" /t REG_SZ /d "0.0.0.0" /f
                reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "UpdateServiceUrlAlternate" /t REG_SZ /d "0.0.0.0" /f
                reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "SetProxyBehaviorForUpdateDetection" /t REG_DWORD /d 00000000 /f
                reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "SetDisableUXWUAccess" /t REG_DWORD /d 00000001 /f
                reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DoNotConnectToWindowsUpdateInternetLocations" /t REG_DWORD /d 00000001 /f
                reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 00000001 /f
                reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "UseWUServer" /t REG_DWORD /d 00000001 /f
                reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 00000002 /f
                reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 00000000 /f
                reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 00000001 /f
                reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 00000001 /f
                reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "HideMCTLink" /t REG_DWORD /d 00000001 /f
                reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "IsExpedited" /t REG_DWORD /d 00000000 /f
                reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "RestartNotificationsAllowed2" /t REG_DWORD /d 00000000 /f
                reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d 00000000 /f
                reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "OptInOOBE" /t REG_DWORD /d 00000000 /f
                reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 00000000 /f
                reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DriverSearching" /v "DontSearchWindowsUpdate" /t REG_DWORD /d 00000001 /f
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
