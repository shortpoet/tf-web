function noCacheHeaders() {
	let modifiedHeaders = new Headers();
	modifiedHeaders.set('Content-Type', 'text/html');
	modifiedHeaders.append('Pragma', 'no-cache');
	return modifiedHeaders;
}

export { noCacheHeaders };
