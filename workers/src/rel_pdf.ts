async function handleRequest(request: Request) {
	// Send request to origin server
	const response = await fetch(request);

	// Check if response is valid
	if (!response.headers.get('Content-Type')) {
		return response;
	}

	// Check if response is a HTML document
	if (response.headers.get('Content-Type')?.includes('text/html')) {
		// Get the URL of the request
		const url = new URL(request.url);

		// Get the base URL (protocol, domain, and port)
		const baseUrl = url.protocol + '//' + url.host;

		// Create the canonical URL by removing any query parameters
		const canonicalUrl = baseUrl + url.pathname;

		// Add the canonical tag to the response headers
		response.headers.set('Link', `<${canonicalUrl}>; rel="canonical"`);
	}

	// Return the modified response
	return response;
}
