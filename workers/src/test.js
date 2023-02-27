import ipaddr from 'ipaddr.js';

function isInRange(ip, range) {
	const ipAddr = ipaddr.parse(ip);
	const rangeAddr = ipaddr.parseCIDR(range);
	return ipAddr.match(rangeAddr);
}

const res = isInRange(
	'2600:1700:2890:1de0:3886:2cc3:949b:73b4',
	'2600:1700:2890:1de0:0000:0000:0000:0000/64'
);
console.log(res);
