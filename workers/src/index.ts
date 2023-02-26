import type { ExportedHandlerFetchHandler, ExecutionContext } from '@cloudflare/workers-types';

export default {
	far,
	async fetch(request: Request, env: unknown, ctx: ExecutionContext) {
		const out = {
			request,
			env,
			ctx,
		};
		console.log(JSON.stringify(out, null, 2));
		// return new Response(JSON.stringify(out, null, 2), {
		// 	headers: { 'content-type': 'application/json;charset=UTF-8' },
		// });
		// // return basic(request, env, ctx);
		// return info(request, env, ctx);
		return far(request, env, ctx);
	},
};

function basic(request: Request, env: unknown, ctx: ExecutionContext) {
	let modifiedHeaders = new Headers();
	return new Response('Hello World!', {
		headers: modifiedHeaders,
	});
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

async function far(request: Request, env: unknown, ctx: ExecutionContext) {
	let modifiedHeaders = new Headers();
	modifiedHeaders.set('Content-Type', 'text/html');
	modifiedHeaders.append('Pragma', 'no-cache');
	const out = {
		request,
		env,
		ctx,
	};
	console.log(JSON.stringify(out, null, 2));
	if (true) {
		// if (request.headers.get("cf-connecting-ip") !== "2600:1700:2890:1de0:50bd:4df9:1251:8823") {
		return new Response(maintPage(out), {
			headers: modifiedHeaders,
		});
	} else {
		return fetch(request);
	}
}
function fetchAndReplace(request: Request, env: unknown, ctx: ExecutionContext) {
	let modifiedHeaders = new Headers();

	modifiedHeaders.set('Content-Type', 'text/html');
	modifiedHeaders.append('Pragma', 'no-cache');
	// return new Response(request.body);
	const out = {
		request: request,
		env: env,
		ctx: ctx,
	};
	return new Response(maintPage(out), {
		headers: modifiedHeaders,
	});

	// //Return maint page if you're not calling from a trusted IP
	// if (request.headers.get('cf-connecting-ip') !== '2600:1700:2890:1de0:50bd:4df9:1251:8823') {
	// 	// Return modified response.
	// 	return new Response(maintPage(), {
	// 		headers: modifiedHeaders,
	// 	});
	// } //Allow users from trusted into site
	// else {
	// 	//Fire all other requests directly to our WebServers
	// 	return fetch(request);
	// }
}

let maintPage = (data = {}) => `

<!doctype html>
<title>Site Maintenance</title>
<style>
  body {
        text-align: center;
        padding: 150px;
        background: url('data:image/jpeg;base64,<base64EncodedImage>');
        background-size: cover;
        -webkit-background-size: cover;
        -moz-background-size: cover;
        -o-background-size: cover;
      }

    .content {
        background-color: rgba(255, 255, 255, 0.75);
        background-size: 100%;
        color: inherit;
        padding-top: 1px;
        padding-bottom: 10px;
        padding-left: 100px;
        padding-right: 100px;
        border-radius: 15px;
    }

  h1 { font-size: 40pt;}
  body { font: 20px Helvetica, sans-serif; color: #333; }
  article { display: block; text-align: left; width: 75%; margin: 0 auto; }
  a:hover { color: #333; text-decoration: none; }

</style>

<article>

        <div class="background">
            <div class="content">
        <h1>We&rsquo;ll be back soon!</h1>
            <p>We're very orry for the inconvenience but we&rsquo;re performing maintenance. Please check back soon...</p>
            <p>&mdash; <B><font color="red">{</font></B>RESDEVOPS<B><font color="red">}</font></B> Team</p>
        </div>
    </div>

    <pre>${JSON.stringify(data, null, 2)}</pre>

</article>
`;
