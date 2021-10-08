# Ping to client in spesific IP range
# Made by Segilmez06

# Title
Write-Host "Pinger v1.0"
Write-Host "Pinger project made by Segilmez06"
Write-Host " "

# Argument error section
function errusg{
    Write-Host " "
    Write-Host "Usage:"
    Write-Host "    pinger <IP body> <first index> <last index> [ping count] [timeout duration]"
    Write-Host " "
    Write-Host "Example:"
    Write-Host '    pinger "192.168.1." 1 5'
    Write-Host '    pinger "192.168.1." 1 5 1 750'
    exit
}

# Ping options
$ipbody = "192.168.1."
$firstindex = 1
$lastindex = 5
$pingcount = 1
$timeout = 750

if($args[0] -ne $null){$ipbody = $args[0]} else{Write-Host "Error: IP body not defined."; errusg}
if($args[1] -ne $null){$firstindex = $args[1]} else{Write-Host "Error: First index not defined."; errusg}
if($args[2] -ne $null){$lastindex = $args[2]} else{Write-Host "Error: Last index not defined."; errusg}
if($args[3] -ne $null){$pingcount = $args[3]}
if($args[4] -ne $null){$timeout = $args[4]}

# Program variables
$output = ""
[int]$s_count = 0
[int]$e_count = 0
[int]$t_count = 0
[int]$p_count = 0
[int]$m_count = 0

# Pinging
Write-Host "========== START =========="
for ($i = [System.Decimal]::Parse($firstindex); $i -lt [System.Decimal]::Parse($lastindex) + 1; $i++)
{
    Write-Host -NoNewline "Pinging to ${ipbody}${i}: "

    $output = & ping $ipbody${i} -n $pingcount -w $timeout
    
    if($output -Match "Reply from ${ipbody}${i}:")
    {
        $s_count++
        Write-Host -NoNewline "OK: "

        $S1 = "Average = "
        $S2 = "ms"
        $pattern = "$S1(.*?)$S2"
        $result = [regex]::Match($output,$pattern).Groups[1].Value
        $integer = [int]$result
        if($integer -le 0)
        {
            $m_count++
        }
        Write-Host "${result}ms"
    }
    elseif ($output -Match "Request timed out.")
    {
        $t_count++
        Write-Host "TOUT"
    }
    else
    {
        $e_count++
        Write-Host "ERR"
    }
    $p_count++
}
Write-Host " "

#Writing results
Write-Host "========== RESULTS =========="
Write-Host "Succes: ${s_count}"
Write-Host "Timeout: ${t_count}"
Write-Host "Error: ${e_count}"
Write-Host "Total: ${p_count}"
Write-Host " "
if($m_count -gt 0)
{
    Write-Host "${m_count} of pings returnes 0ms. That means your either connection to that device is very strong (usually same device or router) or device is not responding."
    Write-Host " "
}
Write-Host "Important! If server is closed or unreachable, you will get timeout!"