# Domain Admins to Intel List
The following PowerShell script can be used to push Domain Administrators to an Intel List. This list can then be used in an Event Rule to automatically perform an action based on the user on the event.

For instance, if a Domain Administrator is detected performing a DC Sync, the severity level of the corresponding Event can be automatically reduced as an example use case.

```powershell
# Set your Reflex API token and the list UUID
$reflex_api_token = "YOURAPITOKENHERE"
$intel_list_uuid = "UUID-OF-THE-INTEL-LIST"

# Fetch all the members of the Domain Admins group and create a single list
# containing their SamAccountName and UserPrincipalName
$users = Get-ADGroupMember -Recursive "Domain Admins"
$SamAccountNames = $users | Select-Object SamAccountName
$UPNs = $users | Select-Object UserPrincipalName
$list_values = $SamAccountNames + $UPNs

# Format the API request payload
$request_payload = @{values = $list_values}
$request_payload = $request_payload | ConvertTo-Json

# Send the request to the API
Invoke-RestMethod -Method PUT -ContentType "application/json" -Headers @{"Authorization"="Bearer $reflex_api_token"} -Body $request_payload -Uri "https://console.reflexsoar.com/api/v2.0/list/$intel_list_uuid/add_value"
```