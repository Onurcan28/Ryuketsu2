import app

app.ServerName = None

STATE_NONE	= "..."

STATE_DICT	= {
			0:"....",
			1:"NORM",
			2:"BUSY",
			3:"FULL"
}

WINDOWS_IP	= "127.0.0.1"
FREEBSD_IP	= "135.125.234.85" # Change you Freebsd IP here
LOCAL_IP	= "192.168.0.160" # Change you Local IP here

AUTH_PORT	= 11002

CH1			= 13001
CH2			= 13002
CH3			= 13003


REGION_AUTH_SERVER_DICT = {
	0: {
		1: {"ip": WINDOWS_IP, "port": AUTH_PORT},
		2: {"ip": FREEBSD_IP, "port": AUTH_PORT},
		3: {"ip": LOCAL_IP,   "port": AUTH_PORT},
	}
}

SERVER1_CHANNELS = {
	1: {"key":11, "name":"Channel1", "ip":WINDOWS_IP, "tcp_port":CH1, "udp_port":CH1, "state":STATE_NONE},
	2: {"key":12, "name":"Channel2", "ip":WINDOWS_IP, "tcp_port":CH2, "udp_port":CH2, "state":STATE_NONE},
}

SERVER2_CHANNELS = {
	1: {"key":21, "name":"Channel1", "ip":FREEBSD_IP, "tcp_port":CH1, "udp_port":CH1, "state":STATE_NONE},
}

SERVER3_CHANNELS = {
	1: {"key":31, "name":"Channel1", "ip":LOCAL_IP, "tcp_port":CH1, "udp_port":CH1, "state":STATE_NONE},
	2: {"key":32, "name":"Channel2", "ip":LOCAL_IP, "tcp_port":CH2, "udp_port":CH2, "state":STATE_NONE},
	3: {"key":33, "name":"Channel3", "ip":LOCAL_IP, "tcp_port":CH3, "udp_port":CH3, "state":STATE_NONE},
}

REGION_NAME_DICT = {0: "GERMANY"}

REGION_DICT = {
	0: {
		1: {"name":"Windows",		"channel":SERVER1_CHANNELS},
		2: {"name":"FreeBSD",		"channel":SERVER2_CHANNELS},
		3: {"name":"FreeBSD Local",	"channel":SERVER3_CHANNELS},
	}
}

MARKADDR_DICT = {
	10: {"ip":WINDOWS_IP, "tcp_port":CH1, "mark":"10.tga", "symbol_path":"10"},
	20: {"ip":FREEBSD_IP, "tcp_port":CH1, "mark":"10.tga", "symbol_path":"10"},
	30: {"ip":LOCAL_IP,   "tcp_port":CH1, "mark":"10.tga", "symbol_path":"10"},
}

TESTADDR = {"ip":"127.0.0.1", "tcp_port":50000, "udp_port":50000}
