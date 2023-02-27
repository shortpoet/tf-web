import type { ExportedHandlerFetchHandler, ExecutionContext } from '@cloudflare/workers-types';
import ipaddr from 'ipaddr.js';

function isInRange(ip: string, range: string) {
	const ipAddr = ipaddr.parse(ip);
	const rangeAddr = ipaddr.parseCIDR(range);
	return ipAddr.match(rangeAddr);
}

const allowed_ipv4 = ['104.182.207.154/32'];

const allowed_ipv6 = ['2600:1700:2890:1de0:0000:0000:0000:0000/64'];

export function isAllowedIp(ipAddress: string) {
	const isV6 = ipaddr.IPv6.isValid(ipAddress);
	const isV4 = ipaddr.IPv4.isValid(ipAddress);
	if (isV6) {
		return allowed_ipv6.some(range => isInRange(ipAddress, range));
	} else if (isV4) {
		return allowed_ipv4.some(range => isInRange(ipAddress, range));
	}
}
