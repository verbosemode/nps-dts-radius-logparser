# Log parser for MS NPS dts RADIUS logs
# v 0.0.1 / 20120412
# Author: Jochen Bartl <jochen.bartl@gmail.com>

$filename = $args[0]

$PACKET_TYPES = @{
	1 = "Access-Request";
	2 = "Access-Accept";
	3 = "Access-Reject";
	4  = "Accounting-Request"
}

$REASON_CODES = @{
	0 = "IAS_SUCCESS";
	1 = "IAS_INTERNAL_ERROR";
	2 = "IAS_ACCESS_DENIED";
	3 = "IAS_MALFORMED_REQUEST";
	4 = "IAS_GLOBAL_CATALOG_UNAVAILABLE";
	5 = "IAS_DOMAIN_UNAVAILABLE";
	6 = "IAS_SERVER_UNAVAILABLE";
	7 = "IAS_NO_SUCH_DOMAIN";
	8 = "IAS_NO_SUCH_USER";
	16 = "IAS_AUTH_FAILURE";
	17 = "IAS_CHANGE_PASSWORD_FAILURE";
	18 = "IAS_UNSUPPORTED_AUTH_TYPE";
	32 = "IAS_LOCAL_USERS_ONLY";
	33 = "IAS_PASSWORD_MUST_CHANGE";
	34 = "IAS_ACCOUNT_DISABLED";
	35 = "IAS_ACCOUNT_EXPIRED";
	36 = "IAS_ACCOUNT_LOCKED_OUT";
	37 = "IAS_INVALID_LOGON_HOURS";
	38 = "IAS_ACCOUNT_RESTRICTION";
	48 = "IAS_NO_POLICY_MATCH";
	64 = "IAS_DIALIN_LOCKED_OUT";
	65 = "IAS_DIALIN_DISABLED";
	66 = "IAS_INVALID_AUTH_TYPE";
	67 = "IAS_INVALID_CALLING_STATION";
	68 = "IAS_INVALID_DIALIN_HOURS";
	69 = "IAS_INVALID_CALLED_STATION";
	70 = "IAS_INVALID_PORT_TYPE";
	71 = "IAS_INVALID_RESTRICTION";
	80 = "IAS_NO_RECORD";
	96 = "IAS_SESSION_TIMEOUT";
	97 = "IAS_UNEXPECTED_REQUEST";
}


foreach ($line in gc $filename) {
	$logline = [xml]$line
	$logline = $logline.Event
	
	$logobj = New-Object PSObject
	Add-Member -InputObject $logobj -MemberType NoteProperty -name "Timestamp" -value $logline.Timestamp."#text"
	Add-Member -InputObject $logobj -MemberType NoteProperty -name "ComputerName" -value $logline."Computer-Name"."#text"
	Add-Member -InputObject $logobj -MemberType NoteProperty -name "NpPolicyName" -value $logline."NP-Policy-Name"."#text"
	Add-Member -InputObject $logobj -MemberType NoteProperty -name "ProxyPolicyName" -value $logline."Proxy-Policy-Name"."#text"
	Add-Member -InputObject $logobj -MemberType NoteProperty -name "EventSource" -value $logline."Event-Source"."#text"
	Add-Member -InputObject $logobj -MemberType NoteProperty -name "UserName" -value $logline."User-Name"."#text"
	Add-Member -InputObject $logobj -MemberType NoteProperty -name "ClientIpAddress" -value $logline."Client-IP-Address"."#text"
	Add-Member -InputObject $logobj -MemberType NoteProperty -name "ClientVendor" -value $logline."Client-Vendor"."#text"
	Add-Member -InputObject $logobj -MemberType NoteProperty -name "ClientFriendlyName" -value $logline."Client-Friendly-Name"."#text"
	Add-Member -InputObject $logobj -MemberType NoteProperty -name "SamAccountName" -value $logline."SAM-Account-Name"."#text"
	
	
	
	Add-Member -InputObject $logobj -MemberType NoteProperty -name "PacketType" -value $logline."Packet-Type"."#text"
	Add-Member -InputObject $logobj -MemberType NoteProperty -name "PacketTypeName" -value $PACKET_TYPES[[int]$logline."Packet-Type"."#text"]
	Add-Member -InputObject $logobj -MemberType NoteProperty -name "ReasonCode" -value $logline."Reason-Code"."#text"
	Add-Member -InputObject $logobj -MemberType NoteProperty -name "ReasonCodeName" -value $REASON_CODES[[int]$logline."Reason-Code"."#text"]
	
	$logobj
}
