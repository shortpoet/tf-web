import { noCacheHeaders } from './header';
import { isAllowedIp } from './ipAddress';
import { maintPage } from './maintPage';

function logInfo(request: Request, env: unknown, ctx: ExecutionContext) {
	const out = {
		request,
		env,
		ctx,
	};
	console.log(JSON.stringify(out, null, 2));
	return out;
}

function info(request: Request, env: unknown, ctx: ExecutionContext) {
	const out = {
		request: request,
		env: env,
		ctx: ctx,
	};
	return new Response(JSON.stringify(out, null, 2), {
		headers: { 'content-type': 'application/json;charset=UTF-8' },
	});
}

export class AttributeRewriter {
	private attributeName: string;
	private newValue: string;
	constructor(attributeName: string, newValue: string) {
		this.attributeName = attributeName;
		this.newValue = newValue;
	}
	element(element: Element) {
		const attribute = element.getAttribute(this.attributeName);
		if (attribute) {
			element.setAttribute(this.attributeName, this.newValue);
		}
	}
}

async function rewriteOpenGraphTags(
	request: Request,
	env: unknown,
	ctx: ExecutionContext
): Promise<Response> {
	const originalResponse = await fetch(request);
	const contentType = originalResponse.headers.get('Content-Type');
	console.log('contentType', contentType);

	// If the response is not OK, return it as is
	if (!originalResponse.ok) {
		return originalResponse;
	}

	if (!contentType || !contentType.startsWith('text/html')) {
		return originalResponse;
	}

	const rewriter = new HTMLRewriter()
		.on('a', new AttributeRewriter('href', 'https://example.com'))
		.on('img', new AttributeRewriter('src', 'https://example.com/new-image.jpg'))
		.on('meta[name="description]', {
			element(element) {
				// Replace the content of the <meta> tag
				element.setAttribute('content', 'New Description');
			},
		})
		.on('title', {
			element(element) {
				// Replace the content of the <meta> tag
				element.setInnerContent('New Title');
			},
		})
		.on('meta[property="og:title"]', {
			element(element) {
				// Replace the content of the <meta> tag
				element.setAttribute('content', 'New Title');
			},
		})
		.on('meta[property="og:image"]', {
			element(element) {
				// Replace the content of the <meta> tag
				element.setAttribute('content', 'https://shortpoet.com/public/shortpoet_open_graph.png');
			},
		})
		.on('meta[property="og:description"]', {
			element(element) {
				// Replace the content of the <meta> tag
				element.setAttribute('content', 'New Description');
			},
		})
		.on('meta[property="og:type"]', {
			element(element) {
				// Replace the content of the <meta> tag
				element.setAttribute('content', 'website');
			},
		});

	// If the response is HTML, it can be transformed with
	// HTMLRewriter -- otherwise, it should pass through
	if (contentType && contentType.startsWith('text/html')) {
		const clone = await originalResponse.clone();
		const clone2 = await clone.clone();
		console.log('origHtml', await clone.text());
		const newHtml = await rewriter.transform(clone2).text();
		console.log('newHtml', newHtml);
		// return rewriter.transform(originalResponse);
		return new Response(newHtml, {
			status: originalResponse.status,
			statusText: originalResponse.statusText,
			headers: originalResponse.headers,
		});
	}
	const clone = await originalResponse.clone();
	const clone2 = await clone.clone();
	console.log('origHtml', await clone.text());
	const newHtml = await rewriter.transform(clone2).text();
	console.log('newHtml', newHtml);
	// return rewriter.transform(originalResponse);
	return new Response(newHtml, {
		status: originalResponse.status,
		statusText: originalResponse.statusText,
		headers: originalResponse.headers,
	});
}

async function rewriteOpenGraphTagsRegex(request: Request, env: unknown, ctx: ExecutionContext) {
	const originalResponse = await fetch(request);
	const contentType = originalResponse.headers.get('Content-Type');
	console.log('contentType', contentType);

	// If the response is not OK, return it as is
	if (!originalResponse.ok) {
		return originalResponse;
	}

	if (!contentType || !contentType.startsWith('text/html')) {
		return originalResponse;
	}
	const originalHtml = await originalResponse.text();

	// Use a regular expression to find and replace Open Graph tags
	const pattern = /<meta\s+property="og:([^"]+)"\s+content="([^"]*)"\s*\/?>/gi;
	const newHtml = originalHtml.replace(pattern, (match, property, content) => {
		// Modify the content of the Open Graph tag
		switch (property) {
			case 'title':
				content = 'New Title';
				break;
			case 'description':
				content = 'New Description';
				break;
			case 'image':
				content = 'https://shortpoet.com/public/shortpoet_open_graph.png';
				break;
			case 'type':
				content = 'website';
				break;
		}
		// Return the modified Open Graph tag
		return `<meta property="og:${property}" content="${content}"/>`;
	});

	return new Response(newHtml, {
		status: originalResponse.status,
		statusText: originalResponse.statusText,
		headers: originalResponse.headers,
	});
}

async function maintIp(request: Request, env: unknown, ctx: ExecutionContext) {
	const allowed = isAllowedIp(request.headers.get('cf-connecting-ip') || '');
	const info = logInfo(request, env, ctx);
	if (allowed) {
		return fetch(request);
	} else {
		return new Response(maintPage(info), {
			headers: noCacheHeaders(),
		});
	}
}

function maint(request: Request, env: unknown, ctx: ExecutionContext) {
	// return new Response(request.body);
	const out = {
		request: request,
		env: env,
		ctx: ctx,
	};
	return new Response(maintPage(out), {
		headers: noCacheHeaders(),
	});
}

export { logInfo, info, rewriteOpenGraphTags, rewriteOpenGraphTagsRegex, maintIp, maint };
