import type { ExportedHandlerFetchHandler, ExecutionContext } from '@cloudflare/workers-types';
import {
	AttributeRewriter,
	logInfo,
	maint,
	maintIp,
	rewriteOpenGraphTags,
	rewriteOpenGraphTagsRegex,
} from './actions';

export default {
	async fetch(request: Request, env: unknown, ctx: ExecutionContext) {
		// i think the rewrite only counts for crawlers that don't execute javascript;
		// the crawlers that do execute javascript will see the originally processed html
		return rewriteOpenGraphTagsRegex(request, env, ctx);
	},
};
