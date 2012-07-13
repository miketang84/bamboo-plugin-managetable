module(..., package.seeall)

local urlprefix = 'managetable'
local pathprefix = '../plugins/managetable/views/'

local TMPLS = {
	['basic'] = pathprefix + 'basic.html',
}

local pagination = require 'plugins.pagination'
bamboo.registerPlugin('pagination', pagination)


--[[
{% 	local goodworks = function (instance)
		local htmls = {}
		local images = instance:getForeign('images'); 
		if images then 
			for i, v in ipairs(images) do
				table.insert(htmls, '<a href="/${href}">${imagename}</a><br/>' % {href = v.path, imagename = v.imagename})
			end 
		end

		return table.concat(htmls)
	end
%}


{^ managetable datasource = artists,
	thead = { '艺术家', '代表作品', '流派', '国家', '圈子', '简介'  },
	tbody = { 'artistname', goodworks, 'style', 'country', 'sphere', 'brief'  },	
^}
--]]


function main(args, env)
	local tmpl = 'basic'

	assert(args._tag, '[Error] @plugin managetable - missing _tag.')
	assert(args.edit_url, '[Error] @plugin managetable - missing edit_url.')
	assert(args.del_url, '[Error] @plugin managetable - missing del_url.')

	args.thead = args.thead or {}
	args.tbody = args.tbody or {}	
	args.datasource = args.datasource or {}

	return View(TMPLS[tmpl])(args)

end
