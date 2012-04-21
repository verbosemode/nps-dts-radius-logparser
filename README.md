Parser for MS NPS dts/xml RADIUS log files
==========================================

This is just a quick&dirty parser, because I was tired of reading DTS XML log files while troubleshooting a RADIUS login issue. All the parser does at the moment is translating reason codes, packet types and returning powershell objects for every log entry. This allows you to use ?/where in the pipe to search for specific patterns

It is a PowerShell script, because that's what you get on most Windows 2008 R2 servers by default.

Feel free to send me complaints/patches/improvements/ideas ;-)


Known issues
------------

* Damn slow
* Reads only one file from command line


TODO
----

* Read input from pipe
* Command line parameters for basic filtering/searching
...


Usage Example
-------------

	PS C:\Windows\System32\LogFiles\NPS> .\nps-dts-radius-logparser.ps1 .\iaslog47.log | ? { $_.ClientFriendlyName -eq "NET_NCS" -and $_.SamAccountName -like "*manbearpig*" }
	<output omitted>
	Timestamp          : 04/19/2012 10:05:21.579
	ComputerName       : srvdc001
	NpPolicyName       : NP_NET_NCS
	ProxyPolicyName    : CRP_NET_NCS
	EventSource        : IAS
	UserName           :
	ClientIpAddress    : 192.0.2.10
	ClientVendor       : 0
	ClientFriendlyName : NET_NCS
	SamAccountName     : SOUTHPARK\manbearpig
	PacketType         : 2
	PacketTypeName     : Access-Accept
	ReasonCode         : 0
	ReasonCodeName     : IAS_SUCCESS
	<output omitted>

